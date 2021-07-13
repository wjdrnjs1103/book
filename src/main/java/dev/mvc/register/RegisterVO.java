package dev.mvc.register;

public class RegisterVO {
  /*
    MEMBERNO                          NUMBER(10)     NOT NULL    PRIMARY KEY,
    ID                                VARCHAR2(20)     NOT NULL,
    PASSWD                            VARCHAR2(60)     NOT NULL,
    MNAME                             VARCHAR2(30)     NOT NULL,
    EMAIL                             VARCHAR2(30)     NOT NULL,
    TEL                               VARCHAR2(14)     NOT NULL,
    ZIPCODE                           VARCHAR2(5)    NULL ,
    ADDRESS1                          VARCHAR2(80)     NULL ,
    ADDRESS2                          VARCHAR2(50)     NULL ,
    GRADE                             NUMBER(2)    NOT NULL,
    OAUTH                             VARCHAR2(30)     NULL ,
    MDATE                             DATE     NOT NULL
   */

  /** 회원 번호 */
  private int memberno;  
  /** 아이디 */
  private String id = "";
  /** 비밀번호 */
  private String passwd = "";
  /** 회원이름 */
  private String mname = "";
  /** 전화번호 */
  private String tel = "";
  /** 우편번호 */
  private String zipcode = "";
  /** 이메일 */
  private String email = "";
  /** SNS */
  private String oauth = "";
  /** 주소1 */
  private String address1 = "";
  /** 주소2 */
  private String address2 = "";
  /** 가입일 */
  private String mdate = "";
  /** 회원등급 */
  private int grade = 0;
  
  public int getMemberno() {
    return memberno;
  }
  public void setMemberno(int memberno) {
    this.memberno = memberno;
  }
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getPasswd() {
    return passwd;
  }
  public void setPasswd(String passwd) {
    this.passwd = passwd;
  }
  public String getMname() {
    return mname;
  }
  public void setMname(String mname) {
    this.mname = mname;
  }
  public String getTel() {
    return tel;
  }
  public void setTel(String tel) {
    this.tel = tel;
  }
  public String getZipcode() {
    return zipcode;
  }
  public void setZipcode(String zipcode) {
    this.zipcode = zipcode;
  }
  public String getEmail() {
    return email;
  }
  public void setEmail(String email) {
    this.email = email;
  }
  public String getOauth() {
    return oauth;
  }
  public void setOauth(String oauth) {
    this.oauth = oauth;
  }
  public String getAddress1() {
    return address1;
  }
  public void setAddress1(String address1) {
    this.address1 = address1;
  }
  public String getAddress2() {
    return address2;
  }
  public void setAddress2(String address2) {
    this.address2 = address2;
  }
  public String getMdate() {
    return mdate;
  }
  public void setMdate(String mdate) {
    this.mdate = mdate;
  }
  public int getGrade() {
    return grade;
  }
  public void setGrade(int grade) {
    this.grade = grade;
  }
  
}