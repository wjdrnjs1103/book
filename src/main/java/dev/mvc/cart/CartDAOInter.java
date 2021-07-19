package dev.mvc.cart;

import java.util.List;

public interface CartDAOInter {

  /**
   * 상품 등록
   * @param cartVO
   * @return
   */
  public int create(CartVO cartVO);
  
  /**
   * 상품 목록
   * @param memberno
   * @return
   */
  public List<CartVO> list(int memberno);
  
  /**
   * 수량 변경
   * @param cartVO
   * @return
   */
  public int update_cnt(CartVO cartVO);
  
  /**
   * 상품 취소
   * @param cartno
   * @return
   */
  public int delete(int cartno);
}
