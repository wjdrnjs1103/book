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


/**********************************/
/* Table Name: 쪽지 */
/**********************************/
DROP TABLE message;
CREATE TABLE message(
		messageno                     		NUMBER(10)		 NOT NULL  PRIMARY KEY,
		title                         		VARCHAR2(10)		 NOT NULL,
		contents                      		CLOB		 NOT NULL,
		recv_member                   		NUMBER(10)		 NOT NULL,
		send_member                   		NUMBER(10)		 NOT NULL,
		s_date                        		DATE		 NOT NULL,
        productno                          NUMBER(10)		 NOT NULL,
  FOREIGN KEY (recv_member) REFERENCES member (memberno),
  FOREIGN KEY (send_member) REFERENCES member (memberno),
  FOREIGN KEY (productno) REFERENCES product (productno)
);

COMMENT ON TABLE message is '쪽지';
COMMENT ON COLUMN message.messageno is '메세지번호';
COMMENT ON COLUMN message.title is '제목';
COMMENT ON COLUMN message.contents is '내용';
COMMENT ON COLUMN message.recv_member is '받는 사람';
COMMENT ON COLUMN message.send_member is '보낸 사람';
COMMENT ON COLUMN message.s_date is '보낸날짜';
COMMENT ON COLUMN message.productno is '상품번호';

DROP SEQUENCE message_seq;
CREATE SEQUENCE message_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999999
  CACHE 2                     -- 2번은 메모리에서만 계산
  NOCYCLE;                   -- 다시 1부터 생성되는 것을 방지

INSERT INTO message(messageno, title, contents, recv_member, send_member, s_date, productno)
VALUES(MESSAGE_SEQ.nextval, 'Hello', 'Hello', 1 , 1, sysdate, 1);

SELECT messageno, title, contents, recv_member, send_member, s_date
FROM message
WHERE recv_member =11;

SELECT a.messageno, a.title, a.contents, a.recv_member, a.send_member, a.s_date, a.productno, b.mname as sender
FROM message a, member b
WHERE a.recv_member=1 and a.send_member = b.memberno;

SELECT distinct(a.mname)
FROM member a, message b
WHERE a.memberno = 2;

commit;

SELECT memberno FROM product
WHERE productno=1;
/**********************************/
/* Table Name: 송신 */
/**********************************/
CREATE TABLE send(
		send_no                       		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		memberno                      		NUMBER(10)		 NULL ,
		messageno                     		NUMBER(10)		 NULL ,
  FOREIGN KEY (messageno) REFERENCES message (messageno),
  FOREIGN KEY (memberno) REFERENCES member (memberno)
);

COMMENT ON TABLE send is '송신';
COMMENT ON COLUMN send.send_no is '송신번호';
COMMENT ON COLUMN send.memberno is '회원 번호';
COMMENT ON COLUMN send.messageno is '메세지번호';


