/**********************************/
/* Table Name: 커뮤니티 그룹 */
/**********************************/
DROP TABLE commgrp;

CREATE TABLE commgrp(
    commgrpno                         NUMBER(10)    NOT NULL    PRIMARY KEY,
    name                              VARCHAR(50)   NOT NULL,
    seqno                             NUMBER(7)     NOT NULL,
    rdate                             DATE     NOT NULL
);
COMMENT ON TABLE commgrp is '커뮤니티 그룹';
COMMENT ON COLUMN commgrp.commgrpno is '커뮤니티 그룹 번호';
COMMENT ON COLUMN commgrp.name is '이름';
COMMENT ON COLUMN commgrp.seqno is '출력 순서';
COMMENT ON COLUMN commgrp.rdate is '그룹 생성일';

DROP SEQUENCE commgrp_seq;

CREATE SEQUENCE commgrp_seq
  START WITH 1               -- 시작 번호
  INCREMENT BY 1             -- 증가값
  MAXVALUE 9999999999        -- 최대값: 9999999 --> NUMBER(7) 대응
  CACHE 2                    -- 2번은 메모리에서만 계산
  NOCYCLE;                   -- 다시 1부터 생성되는 것을 방지
  
-- Create, 등록
INSERT INTO commgrp(commgrpno, name, seqno, rdate)
VALUES(commgrp_seq.nextval, '자유 게시판', 1, sysdate);
INSERT INTO commgrp(commgrpno, name, seqno, rdate)
VALUES(commgrp_seq.nextval, '공지사항', 2, sysdate);
INSERT INTO commgrp(commgrpno, name, seqno, rdate)
VALUES(commgrp_seq.nextval, 'QnA', 3, sysdate);


commit;

-- List, 목록
SELECT commgrpno, name, seqno, rdate
FROM commgrp
ORDER BY commgrpno ASC;

-- Read, 조회
SELECT commgrpno, name, seqno, rdate
FROM commgrp
WHERE commgrpno = 1;

-- Update, 수정, PK는 일반적으로 update 불가능, 컬럼의 특징을 파악후 변경여부 결정,
-- WHERE 절에 PK 컬럼 명시
UPDATE commgrp
SET name='자유게시판2', seqno=5
WHERE commgrpno=1;

UPDATE commgrp
SET name='기타게시판', seqno=1
WHERE commgrpno=1;

-- Delete, 삭제
DELETE FROM commgrp
WHERE commgrpno=3;

SELECT * FROM commgrp;

-- 새로운 데이터 추가
INSERT INTO commgrp(commgrpno, name, seqno, rdate)
VALUES(commgrp_seq.nextval, '음악', 3, sysdate);

SELECT * FROM commgrp;
 CATEGRPNO NAME                                                    SEQNO V RDATE              
---------- -------------------------------------------------- ---------- - -------------------
         1 영화                                                        1 Y 2021-04-01 10:09:29
         2 여행                                                        2 Y 2021-04-01 10:10:24
         4 음악                                                        3 Y 2021-04-01 10:45:56

-- 갯수, 그룹화 함수, *: 전체 컬럼, 컬럼에 null이 있으면 갯수 산정에서 제외됨, as: 컬럼에 별명 사용.
SELECT COUNT(*) FROM commgrp;

  COUNT(*)  <- 컬럼명
----------
         3

SELECT COUNT(*) as cnt FROM commgrp; 

       CNT  <- 컬럼명
----------
         3
         
commit;       

-- 출력 순서에따른 전체 목록
SELECT commgrpno, name, seqno, rdate
FROM commgrp
ORDER BY seqno ASC;
 
-- 출력 순서 올림(상향), 10 ▷ 1
UPDATE commgrp
SET seqno = seqno - 1
WHERE commgrpno=1;
 
-- 출력순서 내림(하향), 1 ▷ 10
UPDATE commgrp
SET seqno = seqno + 1
WHERE commgrpno=1;

commit;


-- 1) ORA-02449: unique/primary keys in table referenced by foreign keys
DROP TABLE commgrp;

-- 2) CASCADE option을 이용한 자식 테이블을 무시한 테이블 삭제, 관련된 제약조건이 삭제됨.
DROP TABLE commgrp CASCADE CONSTRAINTS;
         
        
  



  