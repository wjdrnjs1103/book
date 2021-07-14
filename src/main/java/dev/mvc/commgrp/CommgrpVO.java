package dev.mvc.commgrp;

public class CommgrpVO {
  
  /** 
    commgrpno                         NUMBER(10)    NOT NULL    PRIMARY KEY,
    name                              VARCHAR(50)    NOT NULL,
    seqno                             NUMBER(7)     NOT NULL,
    rdate                             DATE     NOT NULL
   */
  
  /** 커뮤니티 그룹 번호 */
  private int commgrpno;
  /** 커뮤니티 이름 */
  private String name;
  /** 출력 순서 */
  private int seqno;
  /** 등록일 */
  private String rdate;
  
  public CommgrpVO() {
    
  }
  
  public CommgrpVO(int commgrpno, String name, int seqno, String rdate) {
    this.commgrpno = commgrpno;
    this.name = name;
    this.seqno = seqno;
    this.rdate = rdate;
  }
  
  public int getCommgrpno() {
    return commgrpno;
  }
  public void setCommgrpno(int commgrpno) {
    this.commgrpno = commgrpno;
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
  
  
}
