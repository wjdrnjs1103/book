package dev.mvc.review;

import org.springframework.web.multipart.MultipartFile;

/*
    reviewno                          NUMBER(10)      NOT NULL    PRIMARY KEY,
    productno                         NUMBER(10)     NULL ,
    memberno                          NUMBER(10)      NULL ,
    content                           CLOB            NOT NULL,
    score                             NUMBER(2)       NOT NULL,
    rcnt                              NUMBER(10)      NOT NULL,
    rdate                             DATE            NOT NULL,
    file1                             VARCHAR2(100)   NULL ,
    thumb                             VARCHAR2(100)   NULL ,
    rsize                             NUMBER(20)     DEFAULT 0     NULL ,

 */
public class ReviewVO {
  
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
  
  /** 
  이미지 MultipartFile 
  <input type='file' class="form-control" name='file1MF' id='file1MF' 
                   value='' placeholder="파일 선택">
  */
  private MultipartFile file1MF;
  /** 파일 크기 단위 출력 */
  private String size1_label;
  
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
  
  public MultipartFile getFile1MF() {
    return file1MF;
  }
  public void setFile1MF(MultipartFile file1mf) {
    file1MF = file1mf;
  }
  public String getSize1_label() {
    return size1_label;
  }
  public void setSize1_label(String size1_label) {
    this.size1_label = size1_label;
  }
  
}
