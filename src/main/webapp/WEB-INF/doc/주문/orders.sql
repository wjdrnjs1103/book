/**********************************/
/* Table Name: 주문 */
/**********************************/
DROP TABLE orders CASCADE CONSTRAINTS;

CREATE TABLE orders(
    ordersno                           NUMBER(10)     NOT NULL    PRIMARY KEY,
    paymentno                         NUMBER(10)     NULL ,
    memberno                          NUMBER(10)     NULL ,
    productno                           NUMBER(10)     NULL ,
    cnt                               NUMBER(5)    DEFAULT 1     NOT NULL,
    tot                               NUMBER(10)     DEFAULT 0     NOT NULL,
    states                             NUMBER(1)    DEFAULT 0     NOT NULL,
    rdate                             DATE     NOT NULL,
  FOREIGN KEY (paymentno) REFERENCES payment (paymentno),
  FOREIGN KEY (memberno) REFERENCES member (memberno)
);

COMMENT ON TABLE orders is '주문';
COMMENT ON COLUMN orders.ordersno is '주문번호';
COMMENT ON COLUMN orders.paymentno is '결제번호';
COMMENT ON COLUMN orders.memberno is '회원 번호';
COMMENT ON COLUMN orders.productno is '상품 번호';
COMMENT ON COLUMN orders.cnt is '수량';
COMMENT ON COLUMN orders.tot is '합계';
COMMENT ON COLUMN orders.states is '주문상태';
COMMENT ON COLUMN orders.rdate is '주문날짜';

-- Sequence 생성 SQL
DROP SEQUENCE orders_seq;
CREATE SEQUENCE orders_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999999
  CACHE 2                     -- 2번은 메모리에서만 계산
  NOCYCLE;                   -- 다시 1부터 생성되는 것을 방지
  
-- 등록: 3건 이상
-- 배송 상태(states):  1: 결재 완료, 2: 상품 준비중, 3: 배송 시작, 4: 배달중, 5: 오늘 도착, 6: 배달 완료  
INSERT INTO orders(ordersno, paymentno, memberno, productno, cnt, tot, states, rdate)
VALUES(orders_seq.nextval, 1, 1, 1, 1, 10000, 1, sysdate);

INSERT INTO orders(ordersno, paymentno, memberno, productno, cnt, tot, states, rdate)
VALUES(orders_seq.nextval, 2, 2, 1, 1, 5000, 1, sysdate);

INSERT INTO orders(ordersno, paymentno, memberno, productno, cnt, tot, states, rdate)
VALUES(orders_seq.nextval, 1, 1, 2, 1, 10000, 1, sysdate);

-- 전체 목록
SELECT ordersno, paymentno, memberno, productno, cnt, tot, states, rdate
FROM orders
ORDER BY ordersno DESC;

-- 회원별 목록
SELECT ordersno, paymentno, memberno, productno, cnt, tot, states, rdate
FROM orders
WHERE memberno=1
ORDER BY ordersno DESC;

-- 주문 결제별 주문 상세 목록
SELECT ordersno, paymentno, memberno, productno, cnt, tot, states, rdate
FROM orders
WHERE ordersno=1
ORDER BY ordersno DESC;

-- contents + order_pay join 주문 결재별 주문 상세 목록 <-- 구현
-- 다른 사용자 주문 상세 내역 해킹방지를위해 memberno를 비교
-- 추후 개발
SELECT o.ordersno, o.paymentno, o.memberno, p.productno, p.title, p.price, m.mname,
            o.cnt, o.tot, o.states, o.rdate
FROM orders o, product p, member m 
WHERE (o.productno = p.productno) AND (m.memberno = o.memberno) AND paymentno=1 AND o.memberno=1
ORDER BY ordersno DESC;

-- 수정

-- 삭제
DELETE FROM orders
WHERE memberno = 10;

commit;