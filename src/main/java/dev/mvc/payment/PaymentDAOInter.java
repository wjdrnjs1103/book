package dev.mvc.payment;

import java.util.List;

public interface PaymentDAOInter {

  /**
   * 상품 결제 등록
   * @param paymentVO
   * @return
   */
  public int create(PaymentVO paymentVO);
  
  /**
   * 회원별 주문 결제 목록
   * @param memberno
   * @return
   */
  public List<PaymentVO> list_by_memberno(int memberno);
}
