package dev.mvc.bookgrp;
 
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

 
// Autowired 기능에의해 자동 할당될 때 사용되는 이름
@Component("dev.mvc.bookgrp.BookgrpProc")
public class BookgrpProc implements BookgrpProcInter {
  @Autowired  // DI: Spring 자동으로 구현한 DAO class 객체를 할당
  private BookgrpDAOInter bookgrpDAO;
  // private bookgrpDAOInter bookgrpDAO = new bookgrpDAO();

  @Override
  public int create(BookgrpVO bookgrpVO) {
    int cnt = bookgrpDAO.create(bookgrpVO);
    
    return cnt;
  }
  
  @Override
  public List<BookgrpVO> list_bookgrpno_asc() {
    List<BookgrpVO> list = null;
    list = this.bookgrpDAO.list_bookgrpno_asc();
    return list;
  }
  
  @Override
  public List<BookgrpVO> list_seqno_asc() {
    List<BookgrpVO> list = null;
    list = this.bookgrpDAO.list_seqno_asc();
    return list;
  }
  
  @Override
  public BookgrpVO read(int bookgrpno) {
    BookgrpVO bookgrpVO = null;
    bookgrpVO = this.bookgrpDAO.read(bookgrpno);
    
    return bookgrpVO;
  }
  
  @Override
  public int update(BookgrpVO bookgrpVO) {
    int cnt = 0;
    cnt = this.bookgrpDAO.update(bookgrpVO);
    
    return cnt;
  }
  
  @Override
  public int delete(int bookgrpno) {
    int cnt = 0;
    cnt = this.bookgrpDAO.delete(bookgrpno);
    
    return cnt;
  }
  
  @Override
  public int update_seqno_up(int bookgrpno) {
    int cnt = 0;
    cnt = this.bookgrpDAO.update_seqno_up(bookgrpno);
    
    return cnt;
  }

  @Override
  public int update_seqno_down(int bookgrpno) {
    int cnt = 0;
    cnt = this.bookgrpDAO.update_seqno_down(bookgrpno);    
    return cnt;
  }


  
}