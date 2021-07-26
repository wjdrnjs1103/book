package dev.mvc.board;

public class Commgrp_BoardVO {
  /**
  SELECT r.commgrpno as r_commgrpno, r.name as r_name,
      c.boardno, c.commgrpno, c.title, c.bcon, c.brdate, c.budate, c.word, c.file1, c.thumb, c.bsize, c.price, c.bcnt, c.writer
  FROM commgrp r, board c
  WHERE r.commgrpno = c.commgrpno
  ORDER BY commgrpno ASC, boardno DESC;
  */
  
  /** 커뮤니티 그룹 번호 */
  private int r_commgrpno;
  /** 커뮤니티 그룹 이름 */
  private String r_name;
  
  
  /** 게시판 번호 */
  private int boardno;
  /** 회원 번호 */
  private int memberno;
  /** 커뮤니티 그룹 번호 */
  private int commgrpno;
  /** 전공도서 번호 */
  private int bookno;
  /** 제목 */
  private String title;
  /** 내용 */
  private String bcon;
  /** 등록일자 */
  private String brdate = "";
  /** 수정일자 */
  private String budate = "";
  /** 검색어 */
  private String word = "";
  /** 메인 이미지 */
  private String file1 = "";  
  /** 메인 이미지 preview */
  private String thumb = "";
  /** 메인 이미지 크기 */
  private long bsize;
  /** 조회수 */
  private int bcnt;
  /** 댓글수 */
  private int breplycnt;
  /** 게시판 작성자 */
  private String writer;
 
  public int getR_commgrpno() {
    return r_commgrpno;
  }
  public void setR_commgrpno(int r_commgrpno) {
    this.r_commgrpno = r_commgrpno;
  }
  public String getR_name() {
    return r_name;
  }
  public void setR_name(String r_name) {
    this.r_name = r_name;
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
  public int getCommgrpno() {
    return commgrpno;
  }
  public void setCommgrpno(int commgrpno) {
    this.commgrpno = commgrpno;
  }
  public int getBookno() {
    return bookno;
  }
  public void setBookno(int bookno) {
    this.bookno = bookno;
  }
  public String getTitle() {
    return title;
  }
  public void setTitle(String title) {
    this.title = title;
  }
  public String getBcon() {
    return bcon;
  }
  public void setBcon(String bcon) {
    this.bcon = bcon;
  }
  public String getBrdate() {
    return brdate;
  }
  public void setBrdate(String brdate) {
    this.brdate = brdate;
  }
  public String getBudate() {
    return budate;
  }
  public void setBudate(String budate) {
    this.budate = budate;
  }
  public String getWord() {
    return word;
  }
  public void setWord(String word) {
    this.word = word;
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
  public long getBsize() {
    return bsize;
  }
  public void setBsize(long bsize) {
    this.bsize = bsize;
  }
  public int getBcnt() {
    return bcnt;
  }
  public void setBcnt(int bcnt) {
    this.bcnt = bcnt;
  }
  public String getWriter() {
    return writer;
  }
  public void setWriter(String writer) {
    this.writer = writer;
  }
  public int getBreplycnt() {
    return breplycnt;
  }
  public void setBreplycnt(int breplycnt) {
    this.breplycnt = breplycnt;
  }
  
  
  
}
