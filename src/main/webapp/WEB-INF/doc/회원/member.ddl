/**********************************/
/* Table Name: 회원 */
/**********************************/
DROP TABLE member;
CREATE TABLE MEMBER(
		MEMBERNO                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		ID                            		VARCHAR(20)		 NOT NULL,
		PASSWD                        		VARCHAR(100)		 NOT NULL,
		MNAME                         		VARCHAR(30)		 NOT NULL,
		EMAIL                         		VARCHAR(30)		 NOT NULL,
		TEL                           		VARCHAR(14)		 NOT NULL,
		ZIPCODE                       		VARCHAR(6)		 NULL ,
		ADDRESS1                      		VARCHAR(80)		 NULL ,
		ADDRESS2                      		VARCHAR(80)		 NULL ,
		GRADE                         		NUMBER(2)		 NOT NULL,
		OAUTH                         		VARCHAR(30)		 NULL ,
		MDATE                         		DATE		 NOT NULL
);

COMMENT ON TABLE MEMBER is '회원';
COMMENT ON COLUMN MEMBER.MEMBERNO is '회원 번호';
COMMENT ON COLUMN MEMBER.ID is '아이디';
COMMENT ON COLUMN MEMBER.PASSWD is '패스워드';
COMMENT ON COLUMN MEMBER.MNAME is '성명';
COMMENT ON COLUMN MEMBER.EMAIL is '이메일';
COMMENT ON COLUMN MEMBER.TEL is '전화번호';
COMMENT ON COLUMN MEMBER.ZIPCODE is '우편번호';
COMMENT ON COLUMN MEMBER.ADDRESS1 is '주소1';
COMMENT ON COLUMN MEMBER.ADDRESS2 is '주소2';
COMMENT ON COLUMN MEMBER.GRADE is '등급';
COMMENT ON COLUMN MEMBER.OAUTH is '가입유형';
COMMENT ON COLUMN MEMBER.MDATE is '가입일';


DROP SEQUENCE member_seq;
CREATE SEQUENCE member_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999999
  CACHE 2                     -- 2번은 메모리에서만 계산
  NOCYCLE;                   -- 다시 1부터 생성되는 것을 방지

-- 관리자 계정 생성
-- **관리자 계정은 꼭 DB에서 직접 인서트해주셔야 합니다.**
INSERT INTO member(memberno, ID, PASSWD, MNAME, EMAIL,
                        TEL, ZIPCODE, ADDRESS1, ADDRESS2, GRADE, OAUTH, MDATE)
VALUES(member_seq.nextval, 'admin', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '관리자', 'whitebello14@gmail.com',
            01053050315,000,'종로','솔데스크',1, null ,sysdate);
INSERT INTO member(memberno, ID, PASSWD, MNAME, EMAIL,
                        TEL, ZIPCODE, ADDRESS1, ADDRESS2, GRADE, OAUTH, MDATE)
VALUES(member_seq.nextval, 'admin1', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '관리자', 'whitebello14@gmail.com',
            01053050315,000,'종로','솔데스크',1, null ,sysdate);            
commit;
SELECT * FROM member;
