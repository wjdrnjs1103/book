/**********************************/
/* Table Name: 게시판 댓글 */
/**********************************/
DROP TABLE reply;

CREATE TABLE reply(
    replyno                          NUMBER(10)     NOT NULL    PRIMARY KEY,
    boardno                          NUMBER(10)     NULL ,
    memberno                         NUMBER(10)     NULL ,
    replycontent                     CLOB           NOT NULL,
    replypwd                         VARCHAR2(10)   NOT NULL,
    replydate                        DATE           NOT NULL,
  FOREIGN KEY (boardno) REFERENCES board (boardno),
  FOREIGN KEY (memberno) REFERENCES member (memberno)
);
COMMENT ON TABLE reply is '게시글 댓글';
COMMENT ON COLUMN reply.replyno is '댓글 번호';
COMMENT ON COLUMN reply.boardno is '게시글 번호';
COMMENT ON COLUMN reply.memberno is '회원 번호';
COMMENT ON COLUMN reply.replycontent is '내용';
COMMENT ON COLUMN reply.replypwd is '비번';
COMMENT ON COLUMN reply.replydate is '댓글 등록일';

DROP SEQUENCE reply_seq;

CREATE SEQUENCE reply_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 9999999999       -- 최대값: 9999999 --> NUMBER(7) 대응
  CACHE 2                   -- 2번은 메모리에서만 계산
  NOCYCLE;                  -- 다시 1부터 생성되는 것을 방지
  
-- 등록
INSERT INTO reply(replyno, boardno, memberno, replycontent, replypwd, replydate)
VALUES(reply_seq.nextval, 1, 1, '댓글1', '1234', sysdate);

INSERT INTO reply(replyno, boardno, memberno, replycontent, replypwd, replydate)
VALUES(reply_seq.nextval, 1, 1, '댓글2', '1234', sysdate);

INSERT INTO reply(replyno, boardno, memberno, replycontent, replypwd, replydate)
VALUES(reply_seq.nextval, 1, 1, '댓글3', '1234', sysdate);    

commit;
-- 사용 X ------------------------
INSERT INTO reply(replyno, boardno, memberno, replycontent, replypwd, replydate)
VALUES((SELECT NVL(MAX(replyno), 0) + 1 as replyno FROM reply),
             1, 1, '댓글1', '1234', sysdate);
INSERT INTO reply(replyno, boardno, memberno, replycontent, replypwd, replydate)
VALUES((SELECT NVL(MAX(replyno), 0) + 1 as replyno FROM reply),
             1, 1, '댓글2', '1234', sysdate);
INSERT INTO reply(replyno, boardno, memberno, replycontent, replypwd, replydate)
VALUES((SELECT NVL(MAX(replyno), 0) + 1 as replyno FROM reply),
             1, 1, '댓글3', '1234', sysdate);             
             

2) 전체 목록
SELECT replyno, boardno, memberno, replycontent, replypwd, replydate
FROM reply
ORDER BY replyno DESC;

 REPLYNO CONTENTSNO MEMBERNO CONTENT PASSWD RDATE
 ------- ---------- -------- ------- ------ ---------------------
       3          1        1 댓글3     1234   2019-12-17 16:59:38.0
       2          1        1 댓글2     1234   2019-12-17 16:59:37.0
       1          1        1 댓글1     1234   2019-12-17 16:59:36.0


3) boardno 별 목록
SELECT replyno, boardno, memberno, replycontent, replypwd, replydate
FROM reply
WHERE boardno=1
ORDER BY replyno DESC;

 REPLYNO CONTENTSNO MEMBERNO CONTENT PASSWD RDATE
 ------- ---------- -------- ------- ------ ---------------------
       3          1        1 댓글3     1234   2019-12-17 16:59:38.0
       2          1        1 댓글2     1234   2019-12-17 16:59:37.0
       1          1        1 댓글1     1234   2019-12-17 16:59:36.0


4) 삭제
-- 패스워드 검사
SELECT count(replypwd) as cnt
FROM reply
WHERE replyno=1 AND replypwd='1234';

 CNT
 ---
   1
   
-- 삭제
DELETE FROM reply
WHERE replyno=1;

5) boardno에 해당하는 댓글 수 확인 및 삭제
SELECT COUNT(*) as cnt
FROM reply
WHERE boardno=1;

 CNT
 ---
   1

DELETE FROM reply
WHERE contentsno=1;

6) memberno에 해당하는 댓글 수 확인 및 삭제
SELECT COUNT(*) as cnt
FROM reply
WHERE memberno=1;

 CNT
 ---
   1

DELETE FROM reply
WHERE memberno=1;

7) 회원 ID의 출력
SELECT m.id,
           r.replyno, r.boardno, r.memberno, r.replycontent, r.replypwd, r.replydate
FROM member m,  reply r
WHERE (m.memberno = r.memberno) AND r.boardno=1
ORDER BY r.replyno DESC;

 ID    REPLYNO CONTENTSNO MEMBERNO CONTENT                                                                                                                                                                         PASSWD RDATE
 ----- ------- ---------- -------- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ------ ---------------------
 user1       3          1        1 댓글 3                                                                                                                                                                            123    2019-12-18 16:46:43.0
 user1       2          1        1 댓글 2                                                                                                                                                                            123    2019-12-18 16:46:39.0
 user1       1          1        1 댓글 1                                                                                                                                                                            123    2019-12-18 16:46:35.0
 
 
8) 삭제용 패스워드 검사
SELECT COUNT(*) as cnt
FROM reply
WHERE replyno=1 AND replypwd='1234';

 CNT
 ---
   0

9) 삭제
DELETE FROM reply
WHERE replyno=1;