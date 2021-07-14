/**********************************/
/* Table Name: 전공도서 */
/**********************************/
CREATE TABLE book(
		bookno                        		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		bookgrpno                     		NUMBER(10)		 NULL ,
		name                          		VARCHAR2(50)		 NOT NULL,
		rdate                         		DATE		 NOT NULL,
		cnt                           		NUMBER(10)		 DEFAULT 0		 NOT NULL,
  FOREIGN KEY (bookgrpno) REFERENCES bookgrp (bookgrpno)
);

COMMENT ON TABLE book is '전공도서';
COMMENT ON COLUMN book.bookno is '전공도서 번호';
COMMENT ON COLUMN book.bookgrpno is '전공도서 그룹 번호';
COMMENT ON COLUMN book.name is '전공도서 이름';
COMMENT ON COLUMN book.rdate is '등록일';
COMMENT ON COLUMN book.cnt is '관련 자료 수';

DROP SEQUENCE book_seq;

CREATE SEQUENCE book_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 999999999 --> NUMBER(10) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지
  
-- 등록
INSERT INTO book(bookno, bookgrpno, name, rdate, cnt)
VALUES(book_seq.nextval, 1, '소프트웨어공학', sysdate, 0);

INSERT INTO book(bookno, bookgrpno, name, rdate, cnt)
VALUES(book_seq.nextval, 1, '자동차공학/기계공학', sysdate, 0);

INSERT INTO book(bookno, bookgrpno, name, rdate, cnt)
VALUES(book_seq.nextval, 1, '전기/전자공학', sysdate, 0);

INSERT INTO book(bookno, bookgrpno, name, rdate, cnt)
VALUES(book_seq.nextval, 1, '건축공학', sysdate, 0);

INSERT INTO book(bookno, bookgrpno, name, rdate, cnt)
VALUES(book_seq.nextval, 1, '생명공학', sysdate, 0);

INSERT INTO book(bookno, bookgrpno, name, rdate, cnt)
VALUES(book_seq.nextval, 1, '환경공학', sysdate, 0);

INSERT INTO book(bookno, bookgrpno, name, rdate, cnt)
VALUES(book_seq.nextval, 1, '항공우주/조선해양공학', sysdate, 0);

INSERT INTO book(bookno, bookgrpno, name, rdate, cnt)
VALUES(book_seq.nextval, 1, '화학공학', sysdate, 0);

COMMIT;

SELECT bookno, bookgrpno, name, rdate, cnt
FROM book
ORDER BY bookno ASC;

SELECT bookno, bookgrpno, name, rdate, cnt
FROM book
WHERE bookno=1;