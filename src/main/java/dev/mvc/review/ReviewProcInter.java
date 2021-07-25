package dev.mvc.review;

import java.util.HashMap;
import java.util.List;

import dev.mvc.board.BoardVO;

public interface ReviewProcInter {
  
  /**
   * 등록
   * @param bookgrpVO
   * @return 등록된 레코드 갯수
   */
  public int create(ReviewVO reviewVO);

  /**
   * 리뷰 전체 목록
   * 
   * @return
   */
  public List<ReviewVO> list_reviewno_asc();
  
  /**
   * 특정 멤버의 리뷰 목록
   * @param memberno
   * @return
   */
  public List<ReviewVO> list_by_productno(int productno);
  
  /**
   * 특정 멤버의 리뷰 목록
   * @param memberno
   * @return
   */
  public List<ReviewVO> list_by_memberno(int memberno);
  
  /**
   * Product + Review join 연결 목록
   * @return
   */
  public List<Product_ReviewVO> list_all_join(); 
  
  /**
   * Product + Review productno join 연결 목록
   * @return
   */
  public List<Product_ReviewVO> list_by_productno_join(HashMap<String, Object> map); 
  
  /**
   * 조회
   * 
   * @param commgrpno 카테고리 그룹 번호, PK
   * @return
   */
  public ReviewVO read(int reviewno);
  
  /**
   * 수정용 조회
   * @param boardno
   * @return
   */
  public ReviewVO read_update(int reviewno);
  
  
  /**
   * 수정 처리
   * 
   * @param reviewVO
   * @return 처리된 레코드 갯수
  */
  
  public int update(ReviewVO reviewVO);
  
  /**
   * 삭제 처리
   * 
   * @param reviewno
   * @return 처리된 레코드 갯수
  */
  public int delete(int reviewno);
  
  /**
   * 조회수 증가
   * @param reviewno
   * @return
   */ 
  public int rcnt_read(ReviewVO reviewVO) throws Exception;
  
}
