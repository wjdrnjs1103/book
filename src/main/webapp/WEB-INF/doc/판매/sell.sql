/**********************************/
/* Table Name: 판매 */
/**********************************/
DROP TABLE selling;
CREATE TABLE selling(
    sellno                            NUMBER(10)     NOT NULL    PRIMARY KEY,
    productno                         NUMBER(10)     NULL ,
    memberno                          NUMBER(10)     NULL ,
  FOREIGN KEY (productno) REFERENCES product (productno) ON DELETE SET NULL,
  FOREIGN KEY (memberno) REFERENCES member (memberno)
);

COMMENT ON TABLE selling is '판매';
COMMENT ON COLUMN selling.sellno is '판매 번호';
COMMENT ON COLUMN selling.productno is '상품 번호';
COMMENT ON COLUMN selling.memberno is '회원 번호';

DROP SEQUENCE sell_seq;
CREATE SEQUENCE sell_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999999
  CACHE 2                     -- 2번은 메모리에서만 계산
  NOCYCLE;                   -- 다시 1부터 생성되는 것을 방지
  
  
 -- 등록
INSERT INTO selling(sellno, productno, memberno)
VALUES(sell_seq.nextval, 1, 1);
INSERT INTO selling(sellno, productno, memberno)
VALUES(sell_seq.nextval, 2, 1);
INSERT INTO selling(sellno, productno, memberno)
VALUES(sell_seq.nextval, 4, 1);

commit;

-- 조회
SELECT sellno, productno, memberno
FROM selling
WHERE memberno=1;





-- 전체 내역
SELECT s.sellno, p.productno, p.title, p.price, p.thumb1, p.rdate, p.stateno, p.cnt
FROM selling s LEFT OUTER JOIN product p
ON s.productno = p.productno
WHERE s.memberno=1
ORDER BY sellno DESC;

-- 판매 중
SELECT s.sellno, p.productno, p.title, p.price, p.thumb1, p.rdate, p.stateno, p.cnt
FROM selling s, product p
WHERE (s.productno = p.productno) AND s.memberno=1 AND p.stateno=1
ORDER BY sellno DESC;

SELECT s.sellno, p.productno, p.title, p.price, p.thumb1, p.rdate, p.stateno, p.cnt
FROM selling s LEFT OUTER JOIN product p
ON s.productno = p.productno
WHERE s.memberno=1 AND p.stateno=1
ORDER BY sellno DESC;


-- 판매 완료
SELECT s.sellno, p.productno, p.title, p.price, p.thumb1, p.rdate, p.stateno, p.cnt
FROM selling s, product p
WHERE (s.productno = p.productno) AND s.memberno=1 AND p.stateno=2
ORDER BY sellno DESC;

SELECT s.sellno, p.productno, p.title, p.price, p.thumb1, p.rdate, p.stateno, p.cnt
FROM selling s LEFT OUTER JOIN product p
ON s.productno = p.productno
WHERE s.memberno=1 AND p.memberno=1 AND p.stateno=2
ORDER BY sellno DESC;


