package dev.mvc.review;

public class Product_ReviewVO {
  
  /** 상품 번호 */
  private int r_productno;
  /** 상품 등록한 회원 번호*/
  private int r_memberno;
  /** 상품 제목 */
  private String r_title;
  /** 상품 내용 */
  private String r_content;
  
  
  /** 리뷰 번호 */
  private int reviewno;
  /** 상품 번호 */
  private int productno;
  /** 회원 번호 */
  private int memberno;
  /** 리뷰 내용 */
  private String content;
  /** 리뷰 평점 */
  private int score;
  /** 리뷰 조회수 */
  private int rcnt;
  /** 리뷰 등록일 */
  private String rdate;
  /** 메인 이미지 */
  private String file1 = "";  
  /** 메인 이미지 preview */
  private String thumb = "";
  /** 메인 이미지 크기 */
  private long rsize;
  /** 리뷰 작성자 */
  private String writer;
  /** 파일 크기 단위 출력 */
  private String size1_label;
  
  
  public int getR_productno() {
    return r_productno;
  }
  public void setR_productno(int r_productno) {
    this.r_productno = r_productno;
  }
  public int getR_memberno() {
    return r_memberno;
  }
  public void setR_memberno(int r_memberno) {
    this.r_memberno = r_memberno;
  }
  public String getR_title() {
    return r_title;
  }
  public void setR_title(String r_title) {
    this.r_title = r_title;
  }
  public String getR_content() {
    return r_content;
  }
  public void setR_content(String r_content) {
    this.r_content = r_content;
  }
  
  
  public int getReviewno() {
    return reviewno;
  }
  public void setReviewno(int reviewno) {
    this.reviewno = reviewno;
  }
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
  public int getRcnt() {
    return rcnt;
  }
  public void setRcnt(int rcnt) {
    this.rcnt = rcnt;
  }
  public String getRdate() {
    return rdate;
  }
  public void setRdate(String rdate) {
    this.rdate = rdate;
  }
  public String getFile1() {
    return file1;
  }
  public void setFile1(String file1) {
    this.file1 = file1;
  }
  public String getThumb() {
    return thumb;
  }
  public void setThumb(String thumb) {
    this.thumb = thumb;
  }
  public long getRsize() {
    return rsize;
  }
  public void setRsize(long rsize) {
    this.rsize = rsize;
  }
  public String getWriter() {
    return writer;
  }
  public void setWriter(String writer) {
    this.writer = writer;
  }
  public String getSize1_label() {
    return size1_label;
  }
  public void setSize1_label(String size1_label) {
    this.size1_label = size1_label;
  }

}
