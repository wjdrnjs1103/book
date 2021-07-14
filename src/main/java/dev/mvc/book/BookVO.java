package dev.mvc.book;
/*
CREATE TABLE book(
    bookno                            NUMBER(10)     NOT NULL    PRIMARY KEY,
    bookgrpno                       NUMBER(10)     NOT NULL,
    name                              VARCHAR2(100)    NOT NULL,
    rdate                              DATE     NOT NULL,
    cnt                                 NUMBER(10)     DEFAULT 0     NOT NULL,
  FOREIGN KEY (bookgrpno) REFERENCES bookgrp (bookgrpno)
); 
 */
public class BookVO {
  /** 전공도서 번호 */
  private int bookno;  
  /** 전공도서 그룹 번호 */
  private int bookgrpno;
  /** 전공도서 이름 */
  private String name;
  /** 등록일 */
  private String rdate;
  /** 등록된 글 수 */
  private int cnt;
  
  public int getBookno() {
    return bookno;
  }
  public void setBookno(int bookno) {
    this.bookno = bookno;
  }
  public int getBookgrpno() {
    return bookgrpno;
  }
  public void setBookgrpno(int bookgrpno) {
    this.bookgrpno = bookgrpno;
  }
  public String getName() {
    return name;
  }
  public void setName(String name) {
    this.name = name;
  }
  public String getRdate() {
    return rdate;
  }
  public void setRdate(String rdate) {
    this.rdate = rdate;
  }
  public int getCnt() {
    return cnt;
  }
  public void setCnt(int cnt) {
    this.cnt = cnt;
  }
  
  
}