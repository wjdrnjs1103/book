package dev.mvc.book;

import java.util.List;

public interface BookDAOInter {
  /**
   * 등록
   * @param bookVO
   * @return 등록된 갯수
   */
  public int create(BookVO bookVO);
  
  /**
   *  전체 목록
   * @return
   */
  public List<BookVO> list_all();
  
  /**
   *  bookgrpno별 목록
   * @return
   */
  public List<BookVO> list_by_bookgrpno(int bookgrpno);   
  
  /**
   * 조회, 수정폼
   * @param bookno 카테고리 번호, PK
   * @return
   */
  public BookVO read(int bookno);
  
  /**
   * 수정 처리
   * @param bookVO
   * @return
   */
  public int update(BookVO bookVO);
  
  /**
   * 삭제 처리 
   * @param bookno
   * @return
   */
  public int delete(int bookno);
  
  /**
   * 특정 그룹에 속한 레코드 갯수 산출
   * @param bookgrpno
   * @return
   */
  public int count_by_bookgrpno(int bookgrpno);
  
  /**
   * bookgrpno가 같은 모든 레코드 삭제
   * @param bookgrpno
   * @return
   */
  public int delete_by_bookgrpno(int bookgrpno);
}