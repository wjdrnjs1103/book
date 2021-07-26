package dev.mvc.selling;
/*
 *  sellno                            NUMBER(10)     NOT NULL    PRIMARY KEY,
    productno                         NUMBER(10)     NULL ,
    memberno                          NUMBER(10)     NULL ,
    cnt                          NUMBER(10)     NOT NULL,
 */
public class SellingVO {
  
  /** 상품 번호 */
  private int productno;
  /** 회원 번호 */
  private int memberno;
  /** 수량 */
  private int cnt;
  /** 게시글 등록일 */
  private String rdate;
  /** 제목 */
  private String title;
  /** 가격 */
  private int price;
  /** 판매 상태 */
  private int stateno;
  /** 미리보기 이미지 */
  private String thumb1;
  
  public int getProductno() {
    return productno;
  }
  public void setProductno(int productno) {
    this.productno = productno;
  }
  public int getMemberno() {
    return memberno;
  }
  public void setMemberno(int memberno) {
    this.memberno = memberno;
  }
  public int getCnt() {
    return cnt;
  }
  public void setCnt(int cnt) {
    this.cnt = cnt;
  }
  public String getRdate() {
    return rdate;
  }
  public void setRdate(String rdate) {
    this.rdate = rdate;
  }
  public String getTitle() {
    return title;
  }
  public void setTitle(String title) {
    this.title = title;
  }
  public int getPrice() {
    return price;
  }
  public void setPrice(int price) {
    this.price = price;
  }
  public int getStateno() {
    return stateno;
  }
  public void setStateno(int stateno) {
    this.stateno = stateno;
  }
  public String getThumb1() {
    return thumb1;
  }
  public void setThumb1(String thumb1) {
    this.thumb1 = thumb1;
  }
  
  
  
  
}
