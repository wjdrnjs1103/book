package dev.mvc.interested;
/*
    interestedno                        NUMBER(10)     NOT NULL    PRIMARY KEY,
    memberno                          NUMBER(10)     NULL ,
    boardno                           NUMBER(10)     NULL ,
    sdate                             DATE     NOT NULL,
 */
public class InterestedVO {
  /** 관심 번호 */
  private int interestedno;
  /** 회원 번호 */
  private int memberno;
  /** 상품 번호 */
  private int productno;
  /** 관심 등록 날짜 */
  private String sdate;
  /** 제목 */
  private String title="";
  /** 메인 이미지 preview */
  private String thumb1;
  /** 가격 */
  private int price;
  /** 상품 총 갯수 */
  private int cnt;
  
  public int getCnt() {
    return cnt;
  }
  public void setCnt(int cnt) {
    this.cnt = cnt;
  }
  public int getInterestedno() {
    return interestedno;
  }
  public void setInterestedno(int interestedno) {
    this.interestedno = interestedno;
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
  public String getSdate() {
    return sdate;
  }
  public void setSdate(String sdate) {
    this.sdate = sdate;
  }
  public String getTitle() {
    return title;
  }
  public void setTitle(String title) {
    this.title = title;
  }
  public String getThumb1() {
    return thumb1;
  }
  public void setThumb1(String thumb1) {
    this.thumb1 = thumb1;
  }
  public int getPrice() {
    return price;
  }
  public void setPrice(int price) {
    this.price = price;
  }
  
 
  
  
}
