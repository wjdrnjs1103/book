package dev.mvc.payment;

public interface PaymentProcInter {

  /**
   * 주문 상품 등록
   * @param paymentVO
   * @return
   */
  public int create(PaymentVO paymentVO);
  
}
