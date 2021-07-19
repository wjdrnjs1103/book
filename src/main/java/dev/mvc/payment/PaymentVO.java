package dev.mvc.payment;
/*
 *     paymentno                         NUMBER(10)     NOT NULL    PRIMARY KEY,
    memberno                          NUMBER(10)     NULL ,
    realname                          VARCHAR(30)    NOT NULL,
    phone                               VARCHAR(20)    NOT NULL,
    postcode                          VARCHAR(10)    NOT NULL,
    address                           VARCHAR(50)    NOT NULL,
    detaddress                        VARCHAR(50)    NOT NULL,
    paytype                           NUMBER(1)    DEFAULT 1     NOT NULL,
    paymoney                          NUMBER(30)     NOT NULL,
    rdate                             DATE     NOT NULL,
 */
public class PaymentVO {

  /** 결제 번호 */
  private int paymentno;
  /** 회원 번호 */
  private int memberno;
  /** 이름 */
  private String realname;
  /** 전화번호 */
  private String phone;
  /** 우편번호 */
  private String postcode;
  /** 주소 */
  private String address;
  /** 상세 주소 */
  private String detaddress;
  /** 결제 방식 */
  private int paytype;
  /** 결제 금액 */
  private int paymoney;
  /** 결제일시 */
  private String rdate;
  
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
  public String getRealname() {
    return realname;
  }
  public void setRealname(String realname) {
    this.realname = realname;
  }
  public String getPhone() {
    return phone;
  }
  public void setPhone(String phone) {
    this.phone = phone;
  }
  public String getPostcode() {
    return postcode;
  }
  public void setPostcode(String postcode) {
    this.postcode = postcode;
  }
  public String getAddress() {
    return address;
  }
  public void setAddress(String address) {
    this.address = address;
  }
  public String getDetaddress() {
    return detaddress;
  }
  public void setDetaddress(String detaddress) {
    this.detaddress = detaddress;
  }
  public int getPaytype() {
    return paytype;
  }
  public void setPaytype(int paytype) {
    this.paytype = paytype;
  }
  public int getPaymoney() {
    return paymoney;
  }
  public void setPaymoney(int paymoney) {
    this.paymoney = paymoney;
  }
  public String getRdate() {
    return rdate;
  }
  public void setRdate(String rdate) {
    this.rdate = rdate;
  }
  
  
}
