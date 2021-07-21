package dev.mvc.reply;

public class ReplyMemberVO {
  /** 아이디 */
  private String id = "";
  
  /** 댓글 번호*/
  private int replyno;
  /** 관련 게시글 번호 */
  private int boardno;
  /** 회원 번호 */
  private int memberno;
  /** 댓글 내용 */
  private String replycontent;
  /** 댓글 비밀번호 */
  private String replypwd;
  /** 댓글 등록일 */
  private String replydate;
  
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
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
  