package dev.mvc.payment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.payment.PaymentProc")
public class PaymentProc implements PaymentProcInter {

  @Autowired
  private PaymentDAOInter paymentDAO;
  
  @Override
  public int create(PaymentVO paymentVO) {
    int cnt = this.paymentDAO.create(paymentVO);
    return cnt;
  }

}
