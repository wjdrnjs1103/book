package dev.mvc.cart;
/*
    interestedno                        NUMBER(10)     NOT NULL    PRIMARY KEY,
    memberno                          NUMBER(10)     NULL ,
    boardno                           NUMBER(10)     NULL ,
    sdate                             DATE     NOT NULL,
 */
public class CartVO {
  /** 관심 번호 */
  private int cartno;
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
  /** 상품 개수 */
  private int cnt;
  /** 금액 */
  private int tot;
  /** 등록된 상품의 수량 != CartVO.cnt */
  private int product_cnt;
  
  public int getProduct_cnt() {
    return product_cnt;
  }
  public void setProduct_cnt(int product_cnt) {
    this.product_cnt = product_cnt;
  }
  public int getTot() {
    return tot;
  }
  public void setTot(int tot) {
    this.tot = tot;
  }
  public int getCartno() {
    return cartno;
  }
  public void setCartno(int cartno) {
    this.cartno = cartno;
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
  public int getCnt() {
    return cnt;
  }
  public void setCnt(int cnt) {
    this.cnt = cnt;
  }
  


  
}
