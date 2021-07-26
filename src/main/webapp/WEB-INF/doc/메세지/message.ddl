/**********************************/
/* Table Name: 쪽지 */
/**********************************/
DROP TABLE message;
CREATE TABLE message(
		messageno                     		NUMBER(10)		 NOT NULL  PRIMARY KEY,
		title                         		VARCHAR2(300)		 NOT NULL,
		contents                      		CLOB		 NOT NULL,
		recv_member                   		NUMBER(10)		 NOT NULL,
		send_member                   		NUMBER(10)		 NOT NULL,
		s_date                        		DATE		 NOT NULL,
         productno                          NUMBER(10)		   NULL,
  FOREIGN KEY (recv_member) REFERENCES member (memberno),
  FOREIGN KEY (send_member) REFERENCES member (memberno),
  FOREIGN KEY (productno) REFERENCES product (productno) on DELETE SET NULL
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
WHERE productno=3;



