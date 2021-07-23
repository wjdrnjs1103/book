package dev.mvc.review;

public interface ReviewDAOInter {
  
  /**
   * 등록
   * @param bookgrpVO
   * @return 등록된 레코드 갯수
   */
  public int create(ReviewVO reviewVO);

}
