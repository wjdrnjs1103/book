package dev.mvc.bookgrp;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class BookgrpCont {
  @Autowired
  @Qualifier("dev.mvc.bookgrp.BookgrpProc")
  private BookgrpProcInter bookgrpProc;
  
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
  
  // http://localhost:9091/bookgrp/create.do
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
    mav.addObject("cnt", cnt); // request에 저장, request.setAttribute("cnt", cnt)
    
    mav.setViewName("/bookgrp/create_msg"); // /webapp/WEB-INF/views/bookgrp/create_msg.jsp

    return mav; // forward
  }
  
  // http://localhost:9091/bookgrp/list.do
  /**
   * 목록
   * @return
   */
  @RequestMapping(value="/bookgrp/list.do", method=RequestMethod.GET )
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();

    // 등록 순서별 출력    
    // List<bookgrpVO> list = this.bookgrpProc.list_bookgrpno_asc();

    // 출력 순서별 출력
    List<BookgrpVO> list = this.bookgrpProc.list_seqno_asc();

    mav.addObject("list", list); // request.setAttribute("list", list);

    mav.setViewName("/bookgrp/list"); // /webapp/WEB-INF/views/bookgrp/list.jsp
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
   
   mav.setViewName("/bookgrp/update_msg"); // update_msg.jsp
   
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
 
 mav.setViewName("/bookgrp/delete_msg"); // delete_msg.jsp

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