package dev.mvc.orders;
/*
    ordersno                           NUMBER(10)     NOT NULL    PRIMARY KEY,
    paymentno                         NUMBER(10)     NULL ,
    memberno                          NUMBER(10)     NULL ,
    boardno                           NUMBER(10)     NULL ,
    cnt                               NUMBER(5)    DEFAULT 1     NOT NULL,
    tot                               NUMBER(10)     DEFAULT 0     NOT NULL,
    states                             NUMBER(1)    DEFAULT 0     NOT NULL,
    rdate                             DATE     NOT NULL,
 */
public class OrdersVO {
  /** 주문 번호 */
  private int ordersno;
  /** 결제 번호 */
  private int paymentno;
  /** 회원 번호 */
  private int memberno;
  /** 상품 번호 */
  private int productno;
  /** 수량 */
  private int cnt;
  /** 합계 */
  private int tot;
  /** 
      배송 상태:  1: 결재 완료, 2: 상품 준비중, 3: 배송 시작, 4: 배달중, 5: 오늘 도착, 6: 배달 완료  
    */
  private int states;
  /** 주문날짜 */
  private String rdate;
  
  public int getOrdersno() {
    return ordersno;
  }
  public void setOrdersno(int ordersno) {
    this.ordersno = ordersno;
  }
  public int getPaymentno() {
    return paymentno;
  }
  public void setPaymentno(int paymentno) {
    this.paymentno = paymentno;
  }
  public int getMemberno() {
    return memberno;
  }
  public void setMemberno(int memberno) {
    this.memberno = memberno;
  }
  public int getProductno() {
    return productno;
  }
  public void setProductno(int productno) {
    this.productno = productno;
  }
  public int getCnt() {
    return cnt;
  }
  public void setCnt(int cnt) {
    this.cnt = cnt;
  }
  public int getTot() {
    return tot;
  }
  public void setTot(int tot) {
    this.tot = tot;
  }
  public int getStates() {
    return states;
  }
  public void setStates(int states) {
    this.states = states;
  }
  public String getRdate() {
    return rdate;
  }
  public void setRdate(String rdate) {
    this.rdate = rdate;
  }
  
}
