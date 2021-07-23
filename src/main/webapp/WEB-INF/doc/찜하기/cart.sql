/**********************************/
/* Table Name: 찜하기 */
/**********************************/
DROP TABLE cart CASCADE CONSTRAINTS;
CREATE TABLE cart(
		cartno                    		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		memberno                      		NUMBER(10)		 NULL ,
        productno                       		NUMBER(10)		 NULL ,
        cnt                                         NUMBER(10)     DEFAULT 1     NOT NULL,
        tot                                         NUMBER(10)      NULL,
		sdate                         		DATE		 NOT NULL,
  FOREIGN KEY (productno) REFERENCES product (productno),
  FOREIGN KEY (memberno) REFERENCES member (memberno)
);

COMMENT ON TABLE cart is '찜하기';
COMMENT ON COLUMN cart.cartno is '찜번호';
COMMENT ON COLUMN cart.memberno is '회원 번호';
COMMENT ON COLUMN cart.productno is '상품번호';
COMMENT ON COLUMN cart.cnt is '수량';
COMMENT ON COLUMN cart.sdate is '날짜';

-- Sequence 생성 SQL
DROP SEQUENCE cart_seq;
CREATE SEQUENCE cart_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999999
  CACHE 2                     -- 2번은 메모리에서만 계산
  NOCYCLE;                   -- 다시 1부터 생성되는 것을 방지

-- 등록: 3건 이상
INSERT INTO cart(cartno, memberno, productno, cnt, sdate)
VALUES(cart_seq.nextval, 2, 2, 1, sysdate);

INSERT INTO cart(cartno, memberno, productno, cnt, sdate)
VALUES(cart_seq.nextval, 3, 2, 1, sysdate);

INSERT INTO cart(cartno, memberno, productno, cnt, sdate)
VALUES(cart_seq.nextval, 1, 1, 1, sysdate);

commit;

select * from cart;

-- 회원별 목록
SELECT cartno, memberno, productno, cnt, sdate
FROM cart
WHERE memberno=3
ORDER BY cartno;

-- 컨텐츠 + 장바구니 조인
SELECT i.cartno, p.productno, p.title, p.thumb1, p.price, i.cnt, i.memberno, i.sdate
FROM cart i, product p
WHERE i.productno = p.productno
ORDER BY cartno ASC;


-- 조회
SELECT i.cartno, p.productno, p.title, p.thumb1, p.price, p.cnt, i.memberno, i.cnt, i.sdate
FROM cart i, product p
WHERE (i.productno = p.productno) AND i.memberno=1
ORDER BY cartno ASC;

-- 상품 개수 카운트
SELECT SUM(cnt) as count
FROM cart
WHERE memberno=1;

-- 수정
UPDATE cart
SET cnt = 2
WHERE cartno=10;

-- 삭제
DELETE FROM cart WHERE cartno=10;

commit;
