package dev.mvc.schedule;

public class ScheduleVO {
  
  /*
    classno                         NUMBER(10)     NOT NULL    PRIMARY KEY,
    classname                             VARCHAR2(100)    NOT NULL,
    memberno                              NUMBER(10)      NOT NULL,
    cday                                      VARCHAR2(100)   NOT NULL,                
    starttime                               NUMBER(7)    NOT NULL,
    endtime                               NUMBER(7)    NOT NULL
  */
  
  /** 수업번호 */
  private int classno;  
  /** 회원번호 */
  private int memberno;  
  /** 수업이름 */
  private String classname = "";
  /** 강의일 */
  private String cday="";
  /** 교수 */
  private String professor="";
  /** 교재 */
  private String textbook="";
  /** 시작시간 */
  private int starttime;  
  /** 종료시간 */
  private int endtime;
  
  
  public String getProfessor() {
    return professor;
  }
  public void setProfessor(String professor) {
    this.professor = professor;
  }
  public String getTextbook() {
    return textbook;
  }
  public void setTextbook(String textbook) {
    this.textbook = textbook;
  }
  public int getClassno() {
    return classno;
  }
  public void setClassno(int classno) {
    this.classno = classno;
  }
  public int getMemberno() {
    return memberno;
  }
  public void setMemberno(int memberno) {
    this.memberno = memberno;
  }
  public String getClassname() {
    return classname;
  }
  public void setClassname(String classname) {
    this.classname = classname;
  }
  public String getCday() {
    return cday;
  }
  public void setCday(String cday) {
    this.cday = cday;
  }
  public int getStarttime() {
    return starttime;
  }
  public void setStarttime(int starttime) {
    this.starttime = starttime;
  }
  public int getEndtime() {
    return endtime;
  }
  public void setEndtime(int endtime) {
    this.endtime = endtime;
  }  
  

}
