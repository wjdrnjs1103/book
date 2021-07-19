package dev.mvc.message;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
   * 쪽지 보내기 폼
   * http://localhost:9091/message/message.do?
   * @return
   */
  @RequestMapping(value="/message/create.do", method=RequestMethod.GET )
  public ModelAndView create(HttpServletRequest request, int productno) {
    ModelAndView mav = new ModelAndView();
    
    System.out.println("productno:" + productno);
    
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
   * 쪽지 보내기 처리
   * http://localhost:9091/message/message.do?
   * @return
   */
  @RequestMapping(value="/message/create.do", method=RequestMethod.POST )
  public ModelAndView create(MessageVO messageVO, int productno) {
    ModelAndView mav = new ModelAndView();
    
    int recv_member = this.messageProc.get_memberno(productno); // get_memberno 함수로 게시글 작성자의 회원번호 추출
    messageVO.setRecv_member(recv_member); 
    
    System.out.println(recv_member);
    
    int cnt = this.messageProc.create(messageVO);


    
    mav.addObject("cnt", cnt); // redirect parameter 적용
    
    mav.setViewName("/message/list"); // webapp/message/create.jsp
   
    return mav; // forward
  }
  
  /**
   * Ajax 기반 목록
   * http://localhost:9091/message/list.do
   * @return
   */
  @RequestMapping(value="/message/list.do", method=RequestMethod.GET )
  public ModelAndView list(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    
    int recv_member = (int)session.getAttribute("memberno");
    // 출력 순서별 출력
    List<MessageVO> list = this.messageProc.list(recv_member);
    
    mav.addObject("list", list); // request.setAttribute("list", list);

    mav.setViewName("/message/list"); // /WEB-INF/views/message/list.jsp
    
    return mav;
  }
  
}
