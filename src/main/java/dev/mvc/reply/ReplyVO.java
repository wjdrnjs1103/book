package dev.mvc.reply;

/*
    replyno                          NUMBER(10)     NOT NULL    PRIMARY KEY,
    boardno                          NUMBER(10)     NULL ,
    memberno                         NUMBER(10)     NULL ,
    replycontent                     CLOB           NOT NULL,
    replypwd                         VARCHAR2(10)   NOT NULL,
    replydate                        DATE           NOT NULL,
*/
public class ReplyVO {
  
  /** 댓글 번호*/
  private int replyno;
  /** 관련 게시글 번호 */
  private int boardno;
  /** 회원 번호 */
  private int memberno;
  /** 내용 */
  private String replycontent;
  /** 비밀번호 */
  private String replypwd;
  /** 등록일 */
  private String replydate;
  
  public int getReplyno() {
    return replyno;
  }
  public void setReplyno(int replyno) {
    this.replyno = replyno;
  }
  public int getBoardno() {
    return boardno;
  }
  public void setBoardno(int boardno) {
    this.boardno = boardno;
  }
  public int getMemberno() {
    return memberno;
  }
  public void setMemberno(int memberno) {
    this.memberno = memberno;
  }
  public String getReplycontent() {
    return replycontent;
  }
  public void setReplycontent(String replycontent) {
    this.replycontent = replycontent;
  }
  public String getReplypwd() {
    return replypwd;
  }
  public void setReplypwd(String replypwd) {
    this.replypwd = replypwd;
  }
  public String getReplydate() {
    return replydate;
  }
  public void setReplydate(String replydate) {
    this.replydate = replydate;
  }

}
