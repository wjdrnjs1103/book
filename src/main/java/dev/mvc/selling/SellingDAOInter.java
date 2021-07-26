package dev.mvc.selling;

import java.util.List;

public interface SellingDAOInter {

  
  /**
   * 전체 판매 상품 목록
   * @param memberno
   * @return
   */
  public List<SellingVO> list_all(int memberno);
  
  /**
   * 판매 중인 판매 상품 목록
   * @param memberno
   * @return
   */
  public List<SellingVO> list_selling(int memberno);
 
  /**
   * 판매 중인 판매 상품 목록
   * @param memberno
   * @return
   */
  public List<SellingVO> list_sold(int memberno);
}
