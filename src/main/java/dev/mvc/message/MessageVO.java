package dev.mvc.message;

public class MessageVO {
  /*
    messageno                         NUMBER(10)     NOT NULL    PRIMARY KEY,
    title                             VARCHAR2(10)     NOT NULL,
    contents                          CLOB     NOT NULL,
    recv_member                       NUMBER(10)     NOT NULL,
    send_member                       NUMBER(10)     NOT NULL,
    s_date                            DATE     NOT NULL,
  */
  
  /** 메세지 번호 */
  private int messageno;  
  /** 제목 */
  private String title="";
  /** 내용 */
  private String contents="";
  /** 보낸이 번호 */
  private int send_member;  
  /** 받는이 번호 */
  private int recv_member;
  /** 등록 날짜 */
  private String s_date="";
  public int getMessageno() {
    return messageno;
  }
  public void setMessageno(int messageno) {
    this.messageno = messageno;
  }
  public String getTitle() {
    return title;
  }
  public void setTitle(String title) {
    this.title = title;
  }
  public String getContents() {
    return contents;
  }
  public void setContents(String contents) {
    this.contents = contents;
  }
  public int getSend_member() {
    return send_member;
  }
  public void setSend_member(int send_member) {
    this.send_member = send_member;
  }
  public int getRecv_member() {
    return recv_member;
  }
  public void setRecv_member(int recv_member) {
    this.recv_member = recv_member;
  }
  public String getS_date() {
    return s_date;
  }
  public void setS_date(String s_date) {
    this.s_date = s_date;
  }
  


}
