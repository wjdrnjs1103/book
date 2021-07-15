package dev.mvc.book;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.book.BookProc")
public class BookProc implements BookProcInter {
  @Autowired
  private BookDAOInter bookDAO;
 
  public BookProc() {
    System.out.println("-> BookProc created");
  }
  
  @Override
  public int create(BookVO bookVO) {
    int cnt = this.bookDAO.create(bookVO);
    return cnt;
  }
  
  @Override
  public List<BookVO> list_all() {
    List<BookVO> list = this.bookDAO.list_all();
    return list;
  }
  
  @Override
  public List<BookVO> list_by_bookgrpno(int bookgrpno) {
    List<BookVO> list = this.bookDAO.list_by_bookgrpno(bookgrpno);
    return list;
  }
  
  @Override
  public BookVO read(int bookno) {
    BookVO bookVO = this.bookDAO.read(bookno);
    return bookVO;
  }
  
  @Override
  public int update(BookVO bookVO) {
    int cnt = this.bookDAO.update(bookVO);
    return cnt;
  }
  
  @Override
  public int delete(int bookno) {
    int cnt = this.bookDAO.delete(bookno);
    return cnt;
  }
  
  @Override
  public int count_by_bookgrpno(int bookgrpno) {
    int cnt = this.bookDAO.count_by_bookgrpno(bookgrpno);
    return cnt;
  }

  @Override
  public int delete_by_bookgrpno(int bookgrpno) {
    int cnt = this.bookDAO.delete_by_bookgrpno(bookgrpno);
    return cnt;
  }

}