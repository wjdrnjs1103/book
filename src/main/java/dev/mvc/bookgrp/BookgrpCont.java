package dev.mvc.bookgrp;

import java.util.List;

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


@Controller
public class BookgrpCont {
  @Autowired
  @Qualifier("dev.mvc.bookgrp.BookgrpProc")
  private BookgrpProcInter bookgrpProc;
  
  @Autowired // bookProcInter를 구현한 bookProc.java의 객체가 할당
  @Qualifier("dev.mvc.book.BookProc")
  private BookProcInter bookProc;
  
  public BookgrpCont() {
    System.out.println("-> BookgrpCont created.");
  }
  
  // http://localhost:9091/bookgrp/create.do
  /**
   * 등록 폼
   * @return
   */
  @RequestMapping(value="/bookgrp/create.do", method=RequestMethod.GET )
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/bookgrp/create"); // webapp/WEB-INF/views/bookgrp/create.jsp
    
    System.out.println("ok");
    return mav; // forward
  }
  
//http://localhost:9091/bookgrp/create.do
 /**
  * 등록 처리
  * @param bookgrpVO
  * @return
  */
 @RequestMapping(value="/bookgrp/create.do", method=RequestMethod.POST )
 public ModelAndView create(BookgrpVO bookgrpVO) { // bookgrpVO 자동 생성, Form -> VO
   // bookgrpVO bookgrpVO <FORM> 태그의 값으로 자동 생성됨.
   // request.setAttribute("bookgrpVO", bookgrpVO); 자동 실행
   
   ModelAndView mav = new ModelAndView();
   
   int cnt = this.bookgrpProc.create(bookgrpVO); // 등록 처리
   
   // cnt = 0; // error test
   if (cnt == 1) {
     mav.setViewName("redirect:/bookgrp/list.do");   
   } else {
     mav.addObject("code", "create"); // request에 저장, request.setAttribute("cnt", cnt)
     mav.setViewName("/bookgrp/error_msg"); // /WEB-INF/views/bookgrp/error_msg.jsp
   }
   

   return mav; // forward
 }
  
 /**
  * 목록(회원 전용)  
  * http://localhost:9091/bookgrp/list.do 
  * @return
  */
 @RequestMapping(value = "/bookgrp/list.do", method = RequestMethod.GET)
 public ModelAndView list() {
   ModelAndView mav = new ModelAndView();

   // 등록 순서별 출력
   // List<CategrpVO> list = this.categrpProc.list_categrpno_asc();

   // 출력 순서별 출력
   List<BookgrpVO> list = this.bookgrpProc.list_seqno_asc();

   mav.addObject("list", list); // request.setAttribute("list", list);

   mav.setViewName("/bookgrp/list"); // /WEB-INF/views/bookgrp/list.jsp
   return mav;
 }
  
  /**
   * Ajax 기반 목록
   * http://localhost:9091/bookgrp/list.do
   * @return
   */
  @RequestMapping(value="/bookgrp/list_ajax.do", method=RequestMethod.GET )
  public ModelAndView list_ajax() {
    ModelAndView mav = new ModelAndView();
    
    // 등록 순서별 출력    
    // List<bookgrpVO> list = this.bookgrpProc.list_bookgrpno_asc();
    
    // 출력 순서별 출력
    List<BookgrpVO> list = this.bookgrpProc.list_seqno_asc();
        
    mav.addObject("list", list); // request.setAttribute("list", list);

    mav.setViewName("/bookgrp/list_ajax"); // /WEB-INF/views/bookgrp/list_ajax.jsp
    return mav;
  }
  
 
 // http://localhost:9090/bookgrp/read_update.do
 /**
  * 조회 + 수정폼
  * @param bookgrpno 조회할 카테고리 번호
  * @return
  */
 @RequestMapping(value="/bookgrp/read_update.do", method=RequestMethod.GET )
 public ModelAndView read_update(int bookgrpno) {
   // request.setAttribute("bookgrpno", int bookgrpno) 작동 안됨.
   
   ModelAndView mav = new ModelAndView();
   
   BookgrpVO bookgrpVO = this.bookgrpProc.read(bookgrpno);
   mav.addObject("bookgrpVO", bookgrpVO);  // request 객체에 저장
   
   List<BookgrpVO> list = this.bookgrpProc.list_bookgrpno_asc();
   mav.addObject("list", list);  // request 객체에 저장

   mav.setViewName("/bookgrp/read_update"); // /WEB-INF/views/bookgrp/read_update.jsp 
   return mav; // forward
 }
 
 
 /**
  * 조회 + 수정폼/삭제폼 + Ajax, , VO에서 각각의 필드를 JSON으로 변환하는경우
  * http://localhost:9091/bookgrp/read_ajax.do?bookgrpno=1
  * {"bookgrpno":1,"visible":"Y","seqno":1,"rdate":"2021-04-08 17:01:28","name":"문화"}
  * @param bookgrpno 조회할 카테고리 번호
  * @return
  */
 @RequestMapping(value="/bookgrp/read_ajax.do", 
                             method=RequestMethod.GET )
 @ResponseBody
 public String read_ajax(int bookgrpno) {
   BookgrpVO bookgrpVO = this.bookgrpProc.read(bookgrpno);
   
   JSONObject json = new JSONObject();
   json.put("bookgrpno", bookgrpVO.getBookgrpno());
   json.put("name", bookgrpVO.getName());
   json.put("seqno", bookgrpVO.getSeqno());
   json.put("rdate", bookgrpVO.getRdate());
   
   // 자식 레코드의 갯수 추가
   int count_by_bookgrpno = this.bookProc.count_by_bookgrpno(bookgrpno);
   json.put("count_by_bookgrpno", count_by_bookgrpno);
   
   return json.toString();

 }
 
 
 // http://localhost:9090/bookgrp/update.do
 /**
  * 수정 처리
  * @param bookgrpVO
  * @return
  */
 @RequestMapping(value="/bookgrp/update.do", method=RequestMethod.POST )
 public ModelAndView update(BookgrpVO bookgrpVO) {
   // bookgrpVO bookgrpVO <FORM> 태그의 값으로 자동 생성됨.
   // request.setAttribute("bookgrpVO", bookgrpVO); 자동 실행
   
   ModelAndView mav = new ModelAndView();
   
   int cnt = this.bookgrpProc.update(bookgrpVO);
   mav.addObject("cnt", cnt); // request에 저장
   
   if (cnt == 1) {
     mav.setViewName("redirect:/bookgrp/list.do");   
   } else {
     mav.setViewName("/bookgrp/update_msg"); // /WEB-INF/views/bookgrp/update_msg.jsp
   }
   
   return mav;
 }
 
//http://localhost:9091/bookgrp/read_delete.do
/**
 * 조회 + 삭제폼
 * @param bookgrpno 조회할 카테고리 번호
 * @return
 */
@RequestMapping(value="/bookgrp/read_delete.do", method=RequestMethod.GET )
public ModelAndView read_delete(int bookgrpno) {
  ModelAndView mav = new ModelAndView();
  
  BookgrpVO bookgrpVO = this.bookgrpProc.read(bookgrpno); // 삭제할 자료 읽기
  mav.addObject("bookgrpVO", bookgrpVO);  // request 객체에 저장
  
  List<BookgrpVO> list = this.bookgrpProc.list_bookgrpno_asc();
  mav.addObject("list", list);  // request 객체에 저장

  mav.setViewName("/bookgrp/read_delete"); // read_delete.jsp
  return mav;
}

//http://localhost:9091/bookgrp/delete.do
/**
* 삭제
* @param bookgrpno 조회할 카테고리 번호
* @return
*/
@RequestMapping(value="/bookgrp/delete.do", method=RequestMethod.POST )
public ModelAndView delete(int bookgrpno) {
 ModelAndView mav = new ModelAndView();
 
 BookgrpVO bookgrpVO = this.bookgrpProc.read(bookgrpno); // 삭제 정보
 mav.addObject("bookgrpVO", bookgrpVO);  // request 객체에 저장
 
 int cnt = this.bookgrpProc.delete(bookgrpno); // 삭제 처리
 mav.addObject("cnt", cnt);  // request 객체에 저장
 
 if (cnt == 1) {
   mav.setViewName("redirect:/bookgrp/list.do");   
 } else {
   mav.setViewName("/bookgrp/delete_msg"); // /WEB-INF/views/bookgrp/delete_msg.jsp
 }

 return mav;
}


// http://localhost:9091/bookgrp/update_seqno_up.do?bookgrpno=1
// http://localhost:9091/bookgrp/update_seqno_up.do?bookgrpno=1000
/**
 * 우선순위 상향 up 10 ▷ 1
 * @param bookgrpno 카테고리 번호
 * @return
 */
@RequestMapping(value="/bookgrp/update_seqno_up.do", 
                            method=RequestMethod.GET )
public ModelAndView update_seqno_up(int bookgrpno) {
  ModelAndView mav = new ModelAndView();
  
  BookgrpVO bookgrpVO = this.bookgrpProc.read(bookgrpno); // 카테고리 그룹 정보
  mav.addObject("bookgrpVO", bookgrpVO);  // request 객체에 저장
  
  int cnt = this.bookgrpProc.update_seqno_up(bookgrpno);  // 우선 순위 상향 처리
  mav.addObject("cnt", cnt);  // request 객체에 저장

  // mav.setViewName("/bookgrp/update_seqno_up_msg"); // update_seqno_up_msg.jsp
  mav.setViewName("redirect:/bookgrp/list.do");
  return mav;
}  

// http://localhost:9091/bookgrp/update_seqno_down.do?bookgrpno=1
// http://localhost:9091/bookgrp/update_seqno_down.do?bookgrpno=1000
/**
 * 우선순위 하향 up 1 ▷ 10
 * @param bookgrpno 카테고리 번호
 * @return
 */
@RequestMapping(value="/bookgrp/update_seqno_down.do", 
                            method=RequestMethod.GET )
public ModelAndView update_seqno_down(int bookgrpno) {
  ModelAndView mav = new ModelAndView();
  
  BookgrpVO bookgrpVO = this.bookgrpProc.read(bookgrpno); // 카테고리 그룹 정보
  mav.addObject("bookgrpVO", bookgrpVO);  // request 객체에 저장
  
  int cnt = this.bookgrpProc.update_seqno_down(bookgrpno);
  mav.addObject("cnt", cnt);  // request 객체에 저장

  // mav.setViewName("/bookgrp/update_seqno_down_msg"); // update_seqno_down_msg.jsp
  mav.setViewName("redirect:/bookgrp/list.do");

  return mav;
}  

  
  
}