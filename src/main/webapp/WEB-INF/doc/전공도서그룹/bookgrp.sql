/**********************************/
/* Table Name: 전공그룹 */
/**********************************/
CREATE TABLE bookgrp(
		bookgrpno                     		NUMERIC(10)		 NOT NULL		 PRIMARY KEY,
		name                          		VARCHAR(50)		 NOT NULL,
		seqno                         		NUMERIC(7)		 NOT NULL,
		rdate                         		DATE		 NOT NULL
);

COMMENT ON TABLE bookgrp is '전공 그룹';
COMMENT ON COLUMN bookgrp.bookgrpno is '전공 그룹 번호';
COMMENT ON COLUMN bookgrp.name is '이름';
COMMENT ON COLUMN bookgrp.seqno is '출력 순서';
COMMENT ON COLUMN bookgrp.rdate is '그룹 생성일';

DROP SEQUENCE bookgrp_seq;
CREATE SEQUENCE bookgrp_seq
  START WITH 1               -- 시작 번호
  INCREMENT BY 1           -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999 --> NUMBER(7) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지
  

INSERT INTO bookgrp(bookgrpno, name, seqno,  rdate)
VALUES(bookgrp_seq.nextval, '공과대학전공', 1,  sysdate);
INSERT INTO bookgrp(bookgrpno, name, seqno,  rdate)
VALUES(bookgrp_seq.nextval, '자연과학전공', 2, sysdate);
INSERT INTO bookgrp(bookgrpno, name, seqno,  rdate)
VALUES(bookgrp_seq.nextval, '경영대학전공', 3, sysdate);
INSERT INTO bookgrp(bookgrpno, name, seqno,  rdate)
VALUES(bookgrp_seq.nextval, '사범대학전공', 4, sysdate);
INSERT INTO bookgrp(bookgrpno, name, seqno,  rdate)
VALUES(bookgrp_seq.nextval, '문과대학전공', 5, sysdate);
INSERT INTO bookgrp(bookgrpno, name, seqno,  rdate)
VALUES(bookgrp_seq.nextval, '사회과학대학전공', 6, sysdate);
INSERT INTO bookgrp(bookgrpno, name, seqno, rdate)
VALUES(bookgrp_seq.nextval, '의과대학전공', 7, sysdate);
INSERT INTO bookgrp(bookgrpno, name, seqno, rdate)
VALUES(bookgrp_seq.nextval, '예술체육대학전공', 8, sysdate);
INSERT INTO bookgrp(bookgrpno, name, seqno, rdate)
VALUES(bookgrp_seq.nextval, '외국어전공', 9, sysdate);  

commit;

SELECT bookgrpno, name, seqno, rdate
FROM bookgrp
ORDER BY bookgrpno ASC;