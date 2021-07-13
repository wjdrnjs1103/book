/**********************************/
/* Table Name: 회원 */
/**********************************/
CREATE TABLE member(
		memberno                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		id                            		VARCHAR2(20)		 NOT NULL,
		passwd                        		VARCHAR2(60)		 NOT NULL,
		mname                         		VARCHAR2(30)		 NOT NULL,
		tel                           		VARCHAR2(14)		 NOT NULL,
		zipcode                       		VARCHAR2(5)		 NULL ,
		email                         		VARCHAR(30)		 NOT NULL,
		oauth                         		VARCHAR(10)		 NULL ,
		address1                      		VARCHAR2(80)		 NULL ,
		mdate                         		DATE		 NOT NULL,
		grade                         		NUMBER(2)		 NOT NULL
);

COMMENT ON TABLE member is '회원';
COMMENT ON COLUMN member.memberno is '회원 번호';
COMMENT ON COLUMN member.id is '아이디';
COMMENT ON COLUMN member.passwd is '패스워드';
COMMENT ON COLUMN member.mname is '성명';
COMMENT ON COLUMN member.tel is '전화번호';
COMMENT ON COLUMN member.zipcode is '우편번호';
COMMENT ON COLUMN member.email is '이메일';
COMMENT ON COLUMN member.oauth is '로그인타입';
COMMENT ON COLUMN member.address1 is '주소1';
COMMENT ON COLUMN member.mdate is '가입일';
COMMENT ON COLUMN member.grade is '등급';

