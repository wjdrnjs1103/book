package dev.mvc.message;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.book.BookProcInter;
import dev.mvc.book.BookVO;
import dev.mvc.bookgrp.BookgrpProcInter;
import dev.mvc.bookgrp.BookgrpVO;
import dev.mvc.product.ProductProcInter;
import dev.mvc.product.ProductVO;

@Controller
public class MessageCont {
  @Autowired // CategrpProcInter를 구현한 CategrpProc.java의 객체가 할당
  @Qualifier("dev.mvc.message.MessageProc")
  private MessageProcInter messageProc;
  
  @Autowired 
  @Qualifier("dev.mvc.product.ProductProc")
  private ProductProcInter productProc;
  
  @Autowired 
  @Qualifier("dev.mvc.book.BookProc")
  private BookProcInter bookProc;
  
  @Autowired 
  @Qualifier("dev.mvc.bookgrp.BookgrpProc")
  private BookgrpProcInter bookgrpProc;
  
  public MessageCont() {
    System.out.println("-> RegisterCont created.");
  }
  
  /**
   * 새로고침 방지
   * @return
   */
  @RequestMapping(value="/message/msg.do", method=RequestMethod.GET)
  public ModelAndView msg(String url){
    ModelAndView mav = new ModelAndView();

    mav.setViewName(url); // forward
    
    return mav; // forward
  }
  
  /**
   * 쪽지 보내기 폼
   * http://localhost:9091/message/create.do?
   * @return
   */
  @RequestMapping(value="/message/create.do", method=RequestMethod.GET )
  public ModelAndView create(HttpServletRequest request, int productno) {
    ModelAndView mav = new ModelAndView();
    
    // System.out.println("productno:" + productno);
    
    ProductVO productVO = this.productProc.read(productno);
    mav.addObject("productVO", productVO); // request.setAttribute("productVO", productVO);

    BookVO bookVO = this.bookProc.read(productVO.getBookno());
    mav.addObject("bookVO", bookVO); 

    BookgrpVO bookgrpVO = this.bookgrpProc.read(bookVO.getBookgrpno());
    mav.addObject("bookgrpVO", bookgrpVO); 
    
    mav.setViewName("/message/create"); // webapp/message/create.jsp
   
    return mav; // forward
  }
  
  /**
   * 쪽지 답장 폼
   * http://localhost:9091/message/message.do?
   * @return
   */
  @RequestMapping(value="/message/reply.do", method=RequestMethod.GET )
  public ModelAndView reply(HttpServletRequest request, int send_member, int productno) {
    ModelAndView mav = new ModelAndView();
    
    mav.setViewName("/message/reply"); // webapp/message/reply.jsp
   
    return mav; // forward
  }
  
  
  
  /**
   * 쪽지 보내기 처리
   * http://localhost:9091/message/message.do?
   * @return
   */
  @RequestMapping(value="/message/create.do", method=RequestMethod.POST )
  public ModelAndView create(HttpSession session, MessageVO messageVO, int productno) {
    ModelAndView mav = new ModelAndView();
    if(session.getAttribute("id") == null) {
      mav.setViewName("/register/login_form");
      
      return mav;
    } else {
      int recv_member = this.messageProc.get_memberno(productno); // get_memberno 함수로 게시글 작성자의 회원번호 추출
      messageVO.setRecv_member(recv_member);
      messageVO.setProductno(productno);
      
      int cnt = this.messageProc.create(messageVO);
      
      mav.addObject("cnt", cnt); // redirect parameter 적용
      mav.addObject("url", "/message/msg");
      
      mav.setViewName("redirect:/message/msg.do"); // webapp/message/create.jsp
     
      return mav; // forward
    }

  }
  
  /**
   * 쪽지 답장 처리
   * http://localhost:9091/message/message.do?
   * @return
   */
  @RequestMapping(value="/message/reply.do", method=RequestMethod.POST )
  public ModelAndView create(MessageVO messageVO, int productno, int send_member) {
    ModelAndView mav = new ModelAndView();
    
    int recv_member = this.messageProc.get_memberno(productno); // get_memberno 함수로 게시글 작성자의 회원번호 추출
    messageVO.setRecv_member(send_member);  // 내가 보내는사람 (주객전도)
    messageVO.setProductno(productno);
    messageVO.setSend_member(recv_member);
    
    int cnt = this.messageProc.create(messageVO);
    
    List<MessageVO> list = this.messageProc.list(recv_member);
    mav.addObject("list", list); // request.setAttribute("list", list);
    
    mav.addObject("cnt", cnt); // redirect parameter 적용
    
    mav.setViewName("/message/list"); // webapp/message/list.jsp
   
    return mav; // forward
  }
  
  
  /**
   * Ajax 기반 목록
   * http://localhost:9091/message/list.do
   * @return
   */
  @RequestMapping(value="/message/list.do", method=RequestMethod.GET )
  public ModelAndView list(MessageVO messageVO, HttpSession session) {
    ModelAndView mav = new ModelAndView();
    
    if (session.getAttribute("id") == null) {
      mav.setViewName("/register/login_form");
      
      return mav;
    } else {
      
      int recv_member = (int)session.getAttribute("memberno");
      
      // 출력 순서별 출력
      List<MessageVO> list = this.messageProc.list(recv_member);
      
      // mav.addObject("sender", sender);
      mav.addObject("list", list); // request.setAttribute("list", list);
      
      mav.setViewName("/message/list"); // /WEB-INF/views/message/list.jsp
      
      return mav;
    }

  }
  
  /**
   * 조회 + 수정폼/삭제폼 + Ajax, , VO에서 각각의 필드를 JSON으로 변환하는경우
   * http://localhost:9091/message/read_ajax.do?messageno=2
   * {"bookgrpno":1,"visible":"Y","seqno":1,"rdate":"2021-04-08 17:01:28","name":"문화"}
   * @param messageno 조회할 쪽지 번호
   * @return
   */
  @RequestMapping(value="/message/read_ajax.do", 
                              method=RequestMethod.GET )
  @ResponseBody
  public String read_ajax(int messageno) {
    MessageVO messageVO = this.messageProc.read(messageno);
    
    JSONObject json = new JSONObject();
    json.put("messageno", messageVO.getMessageno());
    json.put("title", messageVO.getTitle());
    json.put("send_member", messageVO.getSend_member());
    json.put("s_date", messageVO.getS_date());
    
    
    return json.toString();

  }
  
  //http://localhost:9091/message/delete.do
  /**
  * 삭제
  * @param message 조회할 카테고리 번호
  * @return
  */
  @RequestMapping(value="/message/delete.do", method=RequestMethod.POST )
  public ModelAndView delete(int messageno) {
    ModelAndView mav = new ModelAndView();
     
    MessageVO messageVO = this.messageProc.read(messageno); // 삭제 정보
    mav.addObject("messageVO", messageVO);  // request 객체에 저장
     
    int cnt = this.messageProc.delete(messageno); // 삭제 처리
    mav.addObject("cnt", cnt);  // request 객체에 저장
     
    if (cnt == 1) {
      mav.setViewName("redirect:/message/list.do");   
    } else {
      mav.setViewName("/message/delete_msg"); // /WEB-INF/views/message/delete_msg.jsp
    }
    
    return mav;
  }
  
  // http://localhost:9091/message/read.do
  /**
   * 조회
   * @return
   */
  @RequestMapping(value="/message/read.do", method=RequestMethod.GET )
  public ModelAndView read(HttpServletRequest request, int messageno, int productno) {
    ModelAndView mav = new ModelAndView();
   
    if (productno == 0) {
      mav.setViewName("/message/no_product_msg");
      
      return mav;
    } else {
      int stateno = this.productProc.get_stateno(productno);
      
      MessageVO messageVO = this.messageProc.read(messageno);
      mav.addObject("messageVO", messageVO); // request.setAttribute("productVO", productVO);
      mav.addObject("stateno", stateno);
      
      mav.setViewName("/message/read"); // /WEB-INF/views/product/read.jsp
        
      return mav;
    }
  }
  
}
