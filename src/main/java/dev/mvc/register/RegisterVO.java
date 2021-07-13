package dev.mvc.register;

public class RegisterVO {
  /*
    member_no                       NUMBER(10)     NOT NULL    PRIMARY KEY,
    id                                    VARCHAR(20)    NOT NULL,
    passwd                            VARCHAR(60)    NOT NULL,
    m_name                            VARCHAR(30)    NOT NULL,
    tel                                   VARCHAR(14)    NOT NULL,
    zipcode                           VARCHAR(5)     NULL ,
    email                             VARCHAR(30)    NOT NULL,
    oauth                             VARCHAR(10)    NULL ,
    address                           VARCHAR(80)    NULL ,
    rdate                             DATE     NOT NULL,
    grade                             NUMBER(2)    NOT NULL
   */

  /** 회원 번호 */
  private int member_no;  
  /** 아이디 */
  private String id;
  /** 비밀번호 */
  private String passwd;
  /** 회원이름 */
  private String m_name;
  /** 전화번호 */
  private String tel;
  /** 우편번호 */
  private String zipcode;
  /** 이메일 */
  private String email;
  /** SNS */
  private String oauth;
  /** 주소 */
  private String address1;
  /** 가입일 */
  private String rdate;
  /** 회원등급 */
  private int grade;
  public int getMember_no() {
    return member_no;
  }
  public void setMember_no(int member_no) {
    this.member_no = member_no;
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
  public String getM_name() {
    return m_name;
  }
  public void setM_name(String m_name) {
    this.m_name = m_name;
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
  public String getRdate() {
    return rdate;
  }
  public void setRdate(String rdate) {
    this.rdate = rdate;
  }
  public int getGrade() {
    return grade;
  }
  public void setGrade(int grade) {
    this.grade = grade;
  }
  
  
}
