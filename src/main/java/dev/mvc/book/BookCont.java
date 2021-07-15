package dev.mvc.book;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.bookgrp.BookgrpVO;
import dev.mvc.bookgrp.BookgrpProcInter;

@Controller
public class BookCont {
  @Autowired
  @Qualifier("dev.mvc.bookgrp.BookgrpProc")
  private BookgrpProcInter bookgrpProc;
  
  @Autowired
  @Qualifier("dev.mvc.book.BookProc")
  private BookProcInter bookProc;
  
  public BookCont() {
    System.out.println("-> BookCont created.");
  }
  
  /**
   * 새로고침 방지
   * @return
   */
  @RequestMapping(value="/book/msg.do", method=RequestMethod.GET)
  public ModelAndView msg(String url){
    ModelAndView mav = new ModelAndView();

    mav.setViewName(url); // forward
    
    return mav; // forward
  }
  
  /**
   * 등록폼 http://localhost:9091/book/create.do?bookgrpno=1
   * 
   * @return
   */
  @RequestMapping(value = "/book/create.do", method = RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/book/create"); // /webapp/WEB-INF/views/book/create.jsp

    return mav;
  }

  /**
   * 등록처리
   * http://localhost:9091/book/create.do
   * 
   * @return
   */
  @RequestMapping(value = "/book/create.do", method = RequestMethod.POST)
  public ModelAndView create(BookVO bookVO) {
    ModelAndView mav = new ModelAndView();

    // System.out.println("-> bookgrpno: " + bookVO.getbookgrpno());
    
    int cnt = this.bookProc.create(bookVO);
    mav.addObject("cnt", cnt);
    mav.addObject("bookgrpno", bookVO.getBookgrpno());
    mav.addObject("name", bookVO.getName());
    mav.addObject("url", "/book/create_msg");  // /book/create_msg -> /book/create_msg.jsp
    
    mav.setViewName("redirect:/book/msg.do");
    // response.sendRedirect("/book/msg.do");
    
    return mav;
  }
  
  /**
   * 전체 목록
   * http://localhost:9091/book/list_all.do 
   * @return
   */
  @RequestMapping(value="/book/list_all.do", method=RequestMethod.GET )
  public ModelAndView list_all() {
    ModelAndView mav = new ModelAndView();
    
    List<BookVO> list = this.bookProc.list_all();
    mav.addObject("list", list); // request.setAttribute("list", list);

    mav.setViewName("/book/list_all"); // /book/list_all.jsp
    return mav;
  }
  
  /**
   * 카테고리 그룹별 전체 목록
   * http://localhost:9091/book/list_by_bookgrpno.do?bookgrpno=1 
   * @return
   */
  @RequestMapping(value="/book/list_by_bookgrpno.do", method=RequestMethod.GET )
  public ModelAndView list_by_bookgrpno(int bookgrpno) {
    ModelAndView mav = new ModelAndView();
    
    List<BookVO> list = this.bookProc.list_by_bookgrpno(bookgrpno);
    mav.addObject("list", list); // request.setAttribute("list", list);

    BookgrpVO  bookgrpVO = bookgrpProc.read(bookgrpno); // 카테고리 그룹 정보
    mav.addObject("bookgrpVO", bookgrpVO); 
    
    mav.setViewName("/book/list_by_bookgrpno"); // /book/list_by_bookgrpno.jsp
    return mav;
  }
  
  /**
   * 조회 + 수정폼 http://localhost:9091/book/read_update.do
   * 
   * @return
   */
  @RequestMapping(value = "/book/read_update.do", method = RequestMethod.GET)
  public ModelAndView read_update(int bookno, int bookgrpno) {
    // int bookno = Integer.parseInt(request.getParameter("bookno"));
    // int bookgrpno = Integer.parseInt(request.getParameter("bookgrpno"));
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/book/read_update"); // read_update.jsp

    BookgrpVO bookgrpVO = this.bookgrpProc.read(bookgrpno);
    mav.addObject("bookgrpVO", bookgrpVO);
    
    BookVO bookVO = this.bookProc.read(bookno);
    mav.addObject("bookVO", bookVO);
    // request.setAttribute("bookVO", bookVO);

    List<BookVO> list = this.bookProc.list_by_bookgrpno(bookgrpno);
    mav.addObject("list", list);

    return mav; // forward
  }
  
  /**
   * 수정 처리
   * 
   * @param bookVO
   * @return
   */
  @RequestMapping(value = "/book/update.do", method = RequestMethod.POST)
  public ModelAndView update(BookVO bookVO) {
    ModelAndView mav = new ModelAndView();

    int cnt = this.bookProc.update(bookVO);
    
    mav.addObject("cnt", cnt); // request에 저장
    mav.addObject("bookno", bookVO.getBookno());
    mav.addObject("bookgrpno", bookVO.getBookgrpno());
    mav.addObject("name", bookVO.getName());
    mav.addObject("url", "/book/update_msg");  // /book/create_msg -> /book/update_msg.jsp로 최종 실행됨.
    
    // mav.setViewName("redirect:/book/msg.do"); // 새로고침 문제 해결, request 초기화
    mav.setViewName("redirect:/book/list_by_bookgrpno.do");
    return mav;
  }
 
  /**
   * 조회 + 삭제폼 http://localhost:9091/book/read_delete.do
   * 
   * @return
   */
  @RequestMapping(value = "/book/read_delete.do", method = RequestMethod.GET)
  public ModelAndView read_delete(int bookno, int bookgrpno) {
    // int bookno = Integer.parseInt(request.getParameter("bookno"));
    // int bookgrpno = Integer.parseInt(request.getParameter("bookgrpno"));
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/book/read_delete"); // read_delete.jsp

    BookgrpVO bookgrpVO = this.bookgrpProc.read(bookgrpno);
    mav.addObject("bookgrpVO", bookgrpVO);
    
    BookVO bookVO = this.bookProc.read(bookno);
    mav.addObject("bookVO", bookVO);
    // request.setAttribute("bookVO", bookVO);

    List<BookVO> list = this.bookProc.list_by_bookgrpno(bookgrpno);
    mav.addObject("list", list);

    return mav; // forward
  }
  
  /**
   * 삭제 처리
   * 
   * @param bookVO
   * @return
   */
  @RequestMapping(value = "/book/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(int bookno, int bookgrpno) {
    ModelAndView mav = new ModelAndView();
    // 삭제될 레코드 정보를 삭제하기전에 읽음
    BookVO bookVO = this.bookProc.read(bookno); 
    
    int cnt = this.bookProc.delete(bookno);
    
    mav.addObject("cnt", cnt); // request에 저장
    mav.addObject("bookno", bookVO.getBookno());
    mav.addObject("bookgrpno", bookVO.getBookgrpno());
    mav.addObject("name", bookVO.getName());
    // mav.addObject("url", "/book/delete_msg");  // /book/delete_msg.jsp로 최종 실행됨.
    
    // mav.setViewName("redirect:/book/msg.do"); // 새로고침 문제 해결, request 초기화
    mav.setViewName("redirect:/book/list_by_bookgrpno.do");
    
    return mav;
  }
  
  /**
   * bookgrpno가 같은 모든 레코드 삭제
   * 
   * @param bookVO
   * @return
   */
  @RequestMapping(value = "/book/delete_by_bookgrpno.do", method = RequestMethod.POST)
  public ModelAndView delete_by_bookgrpno(int bookgrpno) {
    ModelAndView mav = new ModelAndView();
    int cnt = this.bookProc.delete_by_bookgrpno(bookgrpno);
    
    mav.addObject("bookgrpno", bookgrpno);

    mav.setViewName("redirect:/book/list_by_bookgrpno.do"); // 새로고침 문제 해결, request 초기화
    
    return mav;
  }
  
}
