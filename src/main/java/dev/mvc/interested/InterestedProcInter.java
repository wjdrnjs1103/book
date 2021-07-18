package dev.mvc.interested;

import java.util.List;

public interface InterestedProcInter {

  /**
   * 관심 상품 등록
   * @param interestedVO
   * @return
   */
  public int create(InterestedVO interestedVO);
  
  /**
   * 회원별 관심상품 목록
   * @param memberno
   * @return
   */
  public List<InterestedVO> list(int memberno);
  
  /**
   * 관심 상품 삭제
   * @param interestedno
   * @return
   */
  public int delete(int interestedno);
  
}
