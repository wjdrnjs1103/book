package dev.mvc.bookgrp;
 
/*
    bookgrpno                         NUMBER(10)     NOT NULL    PRIMARY KEY,
    name                              VARCHAR2(50)     NOT NULL,
    seqno                             NUMBER(7)    DEFAULT 0     NOT NULL,
    visible                           CHAR(1)    DEFAULT 'Y'     NOT NULL,
    rdate                                 DATE     NOT NULL 
 */
public class BookgrpVO {
  
  /** 카테고리 그룹 번호 */
  private int bookgrpno;
  
  /**  카테고리 이름 */ 
  private String name;
  
  /** 출력 순서 */
  private int seqno;
  
  /** 등록일 */
  private String rdate;
  
  public BookgrpVO() {
    
  }
  
  public BookgrpVO(int bookgrpno, String name, int seqno, String rdate) {
    this.bookgrpno = bookgrpno;
    this.name = name;
    this.seqno = seqno;
    this.rdate = rdate;
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
  public int getSeqno() {
    return seqno;
  }
  public void setSeqno(int seqno) {
    this.seqno = seqno;
  }
  public String getRdate() {
    return rdate;
  }
  public void setRdate(String rdate) {
    this.rdate = rdate;
  }

  @Override
  public String toString() {
    return "[bookgrpno=" + bookgrpno + ", name=" + name + ", seqno=" + seqno + ", rdate=" + rdate + "]";
  }
  
  
}







 