package dev.mvc.product;

import org.springframework.web.multipart.MultipartFile;

/*

productno                         NUMBER(10)     NOT NULL    PRIMARY KEY,
bookno                            NUMBER(10)     NULL ,
memberno                          NUMBER(10)     NULL ,
title                             VARCHAR2(100)    NOT NULL,
content                           CLOB     NOT NULL,
cnt                               NUMBER(7)    DEFAULT 0     NOT NULL,
word                              VARCHAR2(300)    NULL ,
rdate                             DATE     NOT NULL,
file1                             VARCHAR2(100)    NULL ,
file1saved                        VARCHAR2(100)    NULL ,
thumb1                            VARCHAR2(100)    NULL ,
size1                             NUMBER(10)     DEFAULT 0     NULL ,
price                             NUMBER(10)     DEFAULT 0     NOT NULL,

*/
public class ProductVO {
  /** 상품 번호 */
  private int productno;
  /** 전공도서 번호 */
  private int bookno;
  /** 회원 번호*/
  private int memberno;
  /** 제목 */
  private String title = "";
  /** 내용 */
  private String content = "";
  /** 조회수 */
  private int cnt = 0;
  /** 검색어 */
  private String word = "";
  /** 등록 날짜 */
  private String rdate = "";
  
  /** 메인 이미지 */
  private String file1 = "";
  /** 실제 저장된 메인 이미지 */
  private String file1saved = "";  
  /** 메인 이미지 preview */
  private String thumb1 = "";
  /** 메인 이미지 크기 */
  private long size1;

  /** 정가 */
  private int price;
  
  /** 
  이미지 MultipartFile 
  <input type='file' class="form-control" name='file1MF' id='file1MF' 
                   value='' placeholder="파일 선택">
  */
  private MultipartFile file1MF;
  
  /**
   * 파일 크기 단위 출력
   */
  private String size1_label;

  public int getProductno() {
    return productno;
  }

  public void setProductno(int productno) {
    this.productno = productno;
  }

  public int getBookno() {
    return bookno;
  }

  public void setBookno(int bookno) {
    this.bookno = bookno;
  }

  public int getMemberno() {
    return memberno;
  }

  public void setMemberno(int memberno) {
    this.memberno = memberno;
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

  public int getCnt() {
    return cnt;
  }

  public void setCnt(int cnt) {
    this.cnt = cnt;
  }

  public String getWord() {
    return word;
  }

  public void setWord(String word) {
    this.word = word;
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

  public String getFile1saved() {
    return file1saved;
  }

  public void setFile1saved(String file1saved) {
    this.file1saved = file1saved;
  }

  public String getThumb1() {
    return thumb1;
  }

  public void setThumb1(String thumb1) {
    this.thumb1 = thumb1;
  }

  public long getSize1() {
    return size1;
  }

  public void setSize1(long size1) {
    this.size1 = size1;
  }

  public int getPrice() {
    return price;
  }

  public void setPrice(int price) {
    this.price = price;
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
