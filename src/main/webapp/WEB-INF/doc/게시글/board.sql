/**********************************/
/* Table Name: 게시글 */
/**********************************/
DROP TABLE board;

CREATE TABLE board(
		boardno                       		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		memberno                      		NUMBER(10)		 NULL ,
		commgrpno                     		NUMBER(10)		 NULL ,
		bookno                        		NUMBER(10)		 NULL ,
		title                         		VARCHAR2(200)	 NOT NULL,
		bcon                          		CLOB		       NOT NULL,
		brecom                        		NUMBER(10)		 DEFAULT 0		 NOT NULL,
		bcnt                          		NUMBER(10)		 DEFAULT 0		 NOT NULL,
		breplycnt                     		NUMBER(10)		 DEFAULT 0		 NOT NULL,
		brdate                        		DATE		       NOT NULL,
		budate                        		DATE		       NOT NULL,
		word                         	    VARCHAR2(300)  NOT NULL,
		file1                         		VARCHAR2(100)	 NULL ,
		thumb                         		VARCHAR2(100)	 NULL ,
		bsize                         		NUMBER(10)		 DEFAULT 0		 NOT NULL,
        writer                              VARCHAR2(50)   NOT NULL,
  FOREIGN KEY (memberno) REFERENCES member (memberno),
  FOREIGN KEY (commgrpno) REFERENCES commgrp (commgrpno),
  FOREIGN KEY (bookno) REFERENCES book (bookno)
);
COMMENT ON TABLE board is '게시글';
COMMENT ON COLUMN board.boardno is '게시글 번호';
COMMENT ON COLUMN board.memberno is '회원 번호';
COMMENT ON COLUMN board.commgrpno is '커뮤니티 그룹 번호';
COMMENT ON COLUMN board.bookno is '전공도서 번호';
COMMENT ON COLUMN board.title is '제목';
COMMENT ON COLUMN board.bcon is '내용';
COMMENT ON COLUMN board.brecom is '추천수';
COMMENT ON COLUMN board.bcnt is '조회수';
COMMENT ON COLUMN board.breplycnt is '댓글수';
COMMENT ON COLUMN board.brdate is '등록일자';
COMMENT ON COLUMN board.budate is '수정일자';
COMMENT ON COLUMN board.word is '검색어';
COMMENT ON COLUMN board.file1 is '메인 이미지';
COMMENT ON COLUMN board.thumb is '메인 이미지 Preview';
COMMENT ON COLUMN board.bsize is '메인 이미지 크기';
COMMENT ON COLUMN board.writer is '작성자';


DROP SEQUENCE board_seq;

CREATE SEQUENCE board_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 9999999999       -- 최대값: 9999999 --> NUMBER(7) 대응
  CACHE 2                   -- 2번은 메모리에서만 계산
  NOCYCLE;                  -- 다시 1부터 생성되는 것을 방지

1. 자유게시판 게시글 등록 commgrpno =1
INSERT INTO board(boardno, memberno, commgrpno, bookno, title, bcon, brecom, bcnt, breplycnt, 
                             brdate, budate, word, file1, thumb, bsize, writer)
VALUES(board_seq.nextval, 1, 1, 1,'게시글 제목', '게시글 내용 테스트', 0, 0, 0, 
                            sysdate, sysdate, '테스트1', 'space.jpg', 'space_t.jpg', 100, 'user1');
INSERT INTO board(boardno, memberno, commgrpno, bookno, title, bcon, brecom, bcnt, breplycnt, 
                             brdate, budate, word, file1, thumb, bsize, writer)
VALUES(board_seq.nextval, 1, 1, 1,'요즘 책 현황', '안녕하세요', 0, 0, 0, 
                            sysdate, sysdate, '테스트2', 'space.jpg', 'space_t.jpg', 200, 'user1');
INSERT INTO board(boardno, memberno, commgrpno, bookno, title, bcon, brecom, bcnt, breplycnt, 
                             brdate, budate, word, file1, thumb, bsize, writer)
VALUES(board_seq.nextval, 1, 2, 1,'공지사항 제목', '공지사항 테스트', 0, 0, 0, 
                            sysdate, sysdate, '공상', 'space.jpg', 'space_t.jpg', 200, 'admin1');

commit;

2. 목록
SELECT boardno, memberno, commgrpno, bookno, title, bcon, brecom, bcnt, breplycnt, 
                             brdate, budate, word, file1, thumb, bsize, writer
FROM board
ORDER BY boardno ASC;

-- commgrpno별 목록
SELECT boardno, memberno, commgrpno, bookno, title, bcon, brecom, bcnt, breplycnt, 
                             brdate, budate, word, file1, thumb, bsize, writer
FROM board
WHERE writer='admin1'
ORDER BY commgrpno ASC;


-- commgrpno별 목록
SELECT boardno, memberno, commgrpno, bookno, title, bcon, brecom, bcnt, breplycnt, 
                             brdate, budate, word, file1, thumb, bsize, writer
FROM board
WHERE boardno=5
ORDER BY commgrpno ASC;

SELECT boardno, memberno, commgrpno, bookno, title, bcon, brecom, bcnt, breplycnt, 
                             brdate, budate, word, file1, thumb, bsize, writer
FROM board
WHERE writer LIKE '%test1%'
ORDER BY commgrpno ASC;

-- 모든 레코드 삭제
DELETE FROM board;

commit;

-- boardno =25 삭제
DELETE FROM board
WHERE boardno = 25;

commit;

-- commgrpno별 검색 목록
-- 1) 검색
-- ① commgrpno별 검색 목록
-- word 컬럼의 존재 이유: 검색 정확도를 높이기 위하여 중요 단어를 명시
-- 글에 'swiss'라는 단어만 등장하면 한글로 '스위스'는 검색 안됨.
-- 이런 문제를 방지하기위해 'swiss,스위스,스의스,수의스,유럽' 검색어가 들어간 word 컬럼을 추가함.
SELECT boardno, memberno, commgrpno, bookno, title, bcon, brecom, bcnt, breplycnt, 
                            brdate, budate, word, file1, thumb, bsize, writer
FROM board
WHERE commgrpno=1 AND word LIKE '%테스트%'
ORDER BY boardno DESC;

-- title, bcon, word column search
SELECT boardno, memberno, commgrpno, bookno, title, bcon, brecom, bcnt, breplycnt, 
                            brdate, budate, word, file1, thumb, bsize, writer
FROM board
WHERE commgrpno=1 AND (title LIKE '%제목%' OR bcon LIKE '%제목%' OR word LIKE '%제목%')
ORDER BY boardno DESC;

-- ② 검색 레코드 갯수
-- 전체 레코드 갯수
SELECT COUNT(*) as cnt
FROM board
WHERE commgrpno=1;

-- commgrpno 별 검색된 레코드 갯수
SELECT COUNT(*) as cnt
FROM board
WHERE commgrpno=1 AND word LIKE '%테스트%';

SELECT COUNT(*) as cnt
FROM board
WHERE commgrpno=1 AND (title LIKE '%유럽%' OR bcon LIKE '%유럽%' OR word LIKE '%유럽%')

-- 검색 + 페이징 + 메인 이미지
-- step 1
SELECT boardno, memberno, commgrpno, bookno, title, bcon, brecom, bcnt, breplycnt, 
                            brdate, budate, word, writer
FROM board
WHERE commgrpno=1 AND word LIKE '%테스트%'
ORDER BY boardno DESC;

-- step 2
SELECT boardno, memberno, commgrpno, bookno, title, bcon, brecom, bcnt, breplycnt, 
            brdate, budate, word, writer, rownum as r
FROM (
          SELECT boardno, memberno, commgrpno, bookno, title, bcon, brecom, bcnt, breplycnt, 
                            brdate, budate, word, writer
          FROM board
          WHERE commgrpno=1 AND word LIKE '%테스트%'
          ORDER BY boardno DESC
);

-- step 3, 1 page
SELECT boardno, memberno, commgrpno, bookno, title, bcon, brecom, bcnt, breplycnt, 
            brdate, budate, word, writer, r
FROM (
           SELECT boardno, memberno, commgrpno, bookno, title, bcon, brecom, bcnt, breplycnt, 
                        brdate, budate, word, writer, rownum as r
           FROM (
                     SELECT boardno, memberno, commgrpno, bookno, title, bcon, brecom, bcnt, breplycnt, 
                             brdate, budate, word, writer
                     FROM board
                     WHERE commgrpno=1 AND word LIKE '%테스트%'
                     ORDER BY boardno DESC
           )          
)
WHERE r >= 1 AND r <= 3;

-- step 3, 2 page
SELECT boardno, memberno, commgrpno, bookno, title, bcon, brecom, bcnt, breplycnt, 
            brdate, budate, word, writer, r
FROM (
           SELECT boardno, memberno, commgrpno, bookno, title, bcon, brecom, bcnt, breplycnt, 
                    brdate, budate, word, writer, rownum as r
           FROM (
                     SELECT boardno, memberno, commgrpno, bookno, title, bcon, brecom, bcnt, breplycnt, 
                            brdate, budate, word, writer
                     FROM board
                     WHERE commgrpno=1 AND word LIKE '%현황%'
                     ORDER BY boardno DESC
           )          
)
WHERE r >= 11 AND r <= 20;

-- 등록 기능 상품 정보 등록
UPDATE board
SET price=300
WHERE boardno = 1;

commit;

-- 조회
SELECT boardno, memberno, commgrpno, bookno, title, bcon, brecom, bcnt, breplycnt, 
                            brdate, budate, word, file1, thumb, bsize, writer
FROM board
WHERE boardno = 1;

-- 텍스트 수정: 예외 컬럼: 추천수, 조회수, 댓글 수
UPDATE board
SET title='게시글 기차를 타고', bcon='계획없이 여행 출발',  word='자유게시판,게시판,출발'
WHERE boardno = 1;

-- SUCCESS
UPDATE board
SET title='기차를 타고', bcon='계획없이 ''여행'' 출발',  word='나,기차,생각'
WHERE boardno = 1;

-- 파일 수정
UPDATE board
SET file1='train.jpg', thumb='train_t.jpg'
WHERE boardno = 1;

-- 삭제
DELETE FROM board
WHERE boardno = 42;

commit;

-- 추천
UPDATE board
SET brecom = brecom + 1
WHERE boardno = 1;

-- 커뮤니티 그룹에 속한 레코드 갯수 산출
SELECT COUNT(*) as cnt 
FROM board 
WHERE commgrpno=1;

-- 전공도서에 속한 레코드 갯수 산출
SELECT COUNT(*) as cnt 
FROM board 
WHERE bookno=1;

-- 커뮤니티 그룹에 속한 레코드 모두 삭제
DELETE FROM board
WHERE commgrpno=1;

-- 전공도서에 속한 레코드 모두 삭제
DELETE FROM board
WHERE bookno=1;

-- 다수의 커뮤니티 그룹에 속한 레코드 갯수 산출: IN
SELECT COUNT(*) as cnt
FROM board
WHERE commgrpno IN(1,2,3);

-- 다수의 카테고리에 속한 레코드 모두 삭제: IN
SELECT boardno, memberno, commgrpno, bookno
FROM board
WHERE commgrpno IN(1,2,3);

-- Commgrp + Board join 연결 목록
SELECT commgrpno, name, seqno, rdate
FROM commgrp
ORDER BY commgrpno ASC;

-- 부모 테이블의 PK 컬럼, 자식 테이블의 FK 컬럼의 값이 같으면 하나의 레코드로 결합
-- 결합시 자식 테이블의 레코드 갯수 만큼 결합(join)이 발생함.
-- as로 컬럼 별명을 선언하면 실제 컬럼명은 사용 못함.
-- boardno, commgrpno, title, bcon, brdate, budate, word, file1, thumb, bsize, price, bcnt

-- list_all_join
SELECT r.commgrpno as r_commgrpno, r.name as r_name,
           c.boardno, c.commgrpno, c.title, c.bcon, c.brdate, c.budate, c.word, c.file1, c.thumb, c.bsize, c.bcnt, c.writer
FROM commgrp r, board c
WHERE r.commgrpno = c.commgrpno
ORDER BY commgrpno ASC, boardno DESC;

-- list_by_commgrpno_join
SELECT r.commgrpno as r_commgrpno, r.name as r_name,
           c.boardno, c.commgrpno, c.title, c.bcon, c.brdate, c.budate, c.word, c.file1, c.thumb, c.bsize, c.price, c.bcnt, c.writer
FROM commgrp r, board c
WHERE r.commgrpno=1 AND r.commgrpno = c.commgrpno 
ORDER BY boardno DESC;

SELECT r.commgrpno as r_commgrpno, r.name as r_name,
           c.boardno, c.commgrpno, c.title, c.bcon, c.brdate, c.budate, c.word, c.file1, c.thumb, c.bsize, c.price, c.bcnt, c.writer
FROM commgrp r, board c
WHERE r.commgrpno=2 AND r.commgrpno = c.commgrpno 
ORDER BY boardno DESC;