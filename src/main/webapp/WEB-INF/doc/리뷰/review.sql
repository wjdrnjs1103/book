/**********************************/
/* Table Name: 리뷰 */
/**********************************/
DROP TABLE review;

CREATE TABLE review(
    reviewno                          NUMBER(10)      NOT NULL    PRIMARY KEY,
    productno                     	  NUMBER(10)		 NULL ,
    memberno                          NUMBER(10)      NULL ,
    content                           CLOB            NOT NULL,
    score                             NUMBER(2)       NOT NULL,
    rdate                             DATE            NOT NULL,
    rcnt                              NUMBER(10)      NOT NULL,
    file1                             VARCHAR2(100)   NULL ,
    thumb                             VARCHAR2(100)   NULL ,
    rsize                             NUMBER(20)      DEFAULT 0     NULL ,
    writer                            VARCHAR2(50)   NOT NULL,
  FOREIGN KEY (memberno) REFERENCES member (memberno),
  FOREIGN KEY (productno) REFERENCES product (productno)
);
COMMENT ON TABLE review is '리뷰';
COMMENT ON COLUMN review.reviewno is '리뷰 번호';
COMMENT ON COLUMN review.productno is '상품 번호';
COMMENT ON COLUMN review.memberno is '회원 번호';
COMMENT ON COLUMN review.content is '내용';
COMMENT ON COLUMN review.score is '평점';
COMMENT ON COLUMN review.rcnt is '조회수';
COMMENT ON COLUMN review.rdate is '등록일';
COMMENT ON COLUMN review.file1 is '메인 이미지 파일';
COMMENT ON COLUMN review.thumb is '메인 이미지 Preview';
COMMENT ON COLUMN review.rsize is '메인 이미지 크기';
COMMENT ON COLUMN review.writer is '리뷰 작성자';

DROP SEQUENCE review_seq;

CREATE SEQUENCE review_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 9999999999       -- 최대값: 9999999 --> NUMBER(7) 대응
  CACHE 2                   -- 2번은 메모리에서만 계산
  NOCYCLE;                  -- 다시 1부터 생성되는 것을 방지
  

1. 등록
INSERT INTO review(reviewno, productno, memberno, content, score, rcnt, 
                             rdate, file1, thumb, rsize, writer)
VALUES(review_seq.nextval, 1, 1, '리뷰 내용 테스트', 0, 0, 
                            sysdate, 'space.jpg', 'space_t.jpg', 1000, 'admin');
INSERT INTO review(reviewno, productno, memberno, content, score, rcnt, 
                             rdate, file1, thumb, rsize, writer)
VALUES(review_seq.nextval, 1, 2, '숫자 세기', 0, 0, 
                            sysdate, 'space.jpg', 'space_t.jpg', 1000, 'user1');
INSERT INTO review(reviewno, productno, memberno, content, score, rcnt, 
                             rdate, file1, thumb, rsize, writer)
VALUES(review_seq.nextval, 2, 1, '리뷰 테스트', 0, 0, 
                            sysdate, 'space.jpg', 'space_t.jpg', 1000, 'admin1');
commit;

2. 목록
SELECT reviewno, productno, memberno, content, score, rcnt, rdate, file1, thumb, rsize, writer
FROM review
ORDER BY reviewno ASC;

3. 조회
SELECT reviewno, productno, memberno, content, score, rcnt, rdate, file1, thumb, rsize, writer
FROM review
WHERE reviewno = 1;

-- memberno =1 쓴 리뷰
SELECT reviewno, productno, memberno, content, score, rcnt, rdate, file1, thumb, rsize, writer
FROM review
WHERE memberno = 1;

-- productno =1 쓴 리뷰
SELECT reviewno, productno, memberno, content, score, rcnt, rdate, c, thumb, rsize, writer
FROM review
WHERE productno = 1
ORDER BY reviewno DESC;


4. 수정
UPDATE review 
SET title='제목 테스트 수정'
WHERE reviewno=1;

commit;

5. 삭제
DELETE FROM review;

commit

-- list_all_join
SELECT r.productno as r_productno, r.memberno as r_memberno, r.title as r_title, r.content as r_content,
           c.reviewno, c.productno, c.memberno, c.content, c.score, c.rcnt, c.rdate, c.file1, c.thumb, c.rsize, c.writer
FROM product r, review c
WHERE r.productno = c.productno
ORDER BY productno ASC, reviewno DESC;

-- list_by_productno_join
SELECT r.productno as r_productno, r.memberno as r_memberno, r.title as r_title, r.content as r_content,
           c.reviewno, c.productno, c.memberno, c.content, c.score, c.rcnt, c.rdate, c.file1, c.thumb, c.rsize, c.writer
FROM product r, review c
WHERE r.productno=1 AND r.productno = c.productno 
ORDER BY reviewno DESC;


------------------------------------------------------------
--초간단 review test
------------------------------------------------------------

DROP TABLE review;
CREATE TABLE review(
    reviewno                          NUMBER(10)      NOT NULL    PRIMARY KEY,
    memberno                          NUMBER(10)      NOT NULL ,
    productno                          NUMBER(10)      NOT NULL ,
    title                             VARCHAR2(100)   NOT NULL,
    content                           CLOB            NOT NULL,
    score                             NUMBER(2)       NOT NULL,
  FOREIGN KEY (memberno) REFERENCES member (memberno),
  FOREIGN KEY (productno) REFERENCES product (productno)
);
COMMENT ON TABLE review is '리뷰';
COMMENT ON COLUMN review.reviewno is '리뷰 번호';
COMMENT ON COLUMN review.memberno is '회원 번호';
COMMENT ON COLUMN review.productno is '상품 번호';
COMMENT ON COLUMN review.title is '제목';
COMMENT ON COLUMN review.content is '내용';
COMMENT ON COLUMN review.score is '평점';

DROP SEQUENCE review_seq;

CREATE SEQUENCE review_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 9999999999       -- 최대값: 9999999 --> NUMBER(7) 대응
  CACHE 2                   -- 2번은 메모리에서만 계산
  NOCYCLE;                  -- 다시 1부터 생성되는 것을 방지
  
INSERT INTO review(reviewno, memberno, productno, title, content, score)
VALUES(review_seq.nextval, 1, 1, '리뷰 제목 테스트', '리뷰 내용 테스트', 0);