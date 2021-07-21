/**********************************/
/* Table Name: 리뷰 */
/**********************************/
DROP TABLE review;

CREATE TABLE review(
    reviewno                          NUMBER(10)      NOT NULL    PRIMARY KEY,
    memberno                          NUMBER(10)      NULL ,
    title                             VARCHAR2(100)   NOT NULL,
    content                           CLOB            NOT NULL,
    score                             NUMBER(2)       NOT NULL,
    recom                             NUMBER(10)      DEFAULT 0     NOT NULL,
    cnt                               NUMBER(10)      DEFAULT 0     NOT NULL,
    pwd                               VARCHAR2(10)    NOT NULL,
    rdate                             DATE            NOT NULL,
    file1                             VARCHAR2(100)   NULL ,
    thumb                             VARCHAR2(100)   NULL ,
    rsize                             NUMBER(20)     DEFAULT 0     NULL ,
  FOREIGN KEY (memberno) REFERENCES member (memberno)
);
COMMENT ON TABLE review is '리뷰';
COMMENT ON COLUMN review.reviewno is '리뷰 번호';
COMMENT ON COLUMN review.memberno is '회원 번호';
COMMENT ON COLUMN review.title is '제목';
COMMENT ON COLUMN review.content is '내용';
COMMENT ON COLUMN review.score is '평점';
COMMENT ON COLUMN review.recom is '추천수';
COMMENT ON COLUMN review.cnt is '조회수';
COMMENT ON COLUMN review.pwd is '패스워드';
COMMENT ON COLUMN review.rdate is '등록일';
COMMENT ON COLUMN review.file1 is '메인 이미지 파일';
COMMENT ON COLUMN review.thumb is '메인 이미지 Preview';
COMMENT ON COLUMN review.rsize is '메인 이미지 크기';

DROP SEQUENCE review_seq;

CREATE SEQUENCE review_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 9999999999       -- 최대값: 9999999 --> NUMBER(7) 대응
  CACHE 2                   -- 2번은 메모리에서만 계산
  NOCYCLE;                  -- 다시 1부터 생성되는 것을 방지
  

1. 등록
INSERT INTO review(reviewno, memberno, title, content, score, recom, cnt, 
                             pwd, rdate, file1, thumb, rsize)
VALUES(review_seq.nextval, 1, '리뷰 제목 테스트', '리뷰 내용 테스트', 0, 0, 0, 
                            '1234', sysdate, 'space.jpg', 'space_t.jpg', 1000);
commit;

2. 목록
SELECT reviewno, memberno, title, content, score, recom, cnt, pwd, rdate, file1, thumb, rsize
FROM review
ORDER BY reviewno ASC;

3. 조회
SELECT reviewno, memberno, title, content, score, recom, cnt, pwd, rdate, file1, thumb, rsize
FROM review
WHERE reviewno = 1;

4. 수정
UPDATE review 
SET title='제목 테스트 수정'
WHERE reviewno=1;

commit;

5. 삭제
DELETE FROM review;

commit;