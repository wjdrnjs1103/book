package dev.mvc.review;

public class ReviewVO {
  
  /*
   *     reviewno                          NUMBER(10)      NOT NULL    PRIMARY KEY,
    memberno                          NUMBER(10)      NOT NULL ,
    productno                          NUMBER(10)      NOT NULL ,
    title                             VARCHAR2(100)   NOT NULL,
    content                           CLOB            NOT NULL,
    score                             NUMBER(2)       NOT NULL 
   * */
  
  /** 리뷰 번호(pk)*/
  private int reviewno;
  /** 회원 번호(fk) */
  private int memberno;
  /** 상품 번호(fk) */
  private int productno;
  /** 제목 */
  private String title ="";
  /** 내용  */
  private String content ="";
  /** 평점 */
  private int score=0;  // 평점 NOT NULL 이고 디폴트는 0점으로 할게요~(추후 변경하셔도 됩니당)
  
  
  public int getReviewno() {
    return reviewno;
  }
  public void setReviewno(int reviewno) {
    this.reviewno = reviewno;
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
  public String getTitle() {
    return title;
  }
  public void setTitle(String title) {
    this.title = title;
  }
  public String getContent() {
    return content;
  }
  public void setContent(String content) {
    this.content = content;
  }
  public int getScore() {
    return score;
  }
  public void setScore(int score) {
    this.score = score;
  }

}
