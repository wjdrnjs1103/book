/**********************************/
/* Table Name: 결제 */
/**********************************/
DROP TABLE payment CASCADE CONSTRAINTS;

CREATE TABLE payment(
    paymentno                         NUMBER(10)     NOT NULL    PRIMARY KEY,
    memberno                          NUMBER(10)     NULL ,
    realname                          VARCHAR(30)    NOT NULL,
    phone                               VARCHAR(20)    NOT NULL,
    postcode                          VARCHAR(10)    NOT NULL,
    address                           VARCHAR(100)    NOT NULL,
    detaddress                        VARCHAR(50)    NOT NULL,
    paytype                           NUMBER(1)    DEFAULT 1     NOT NULL,
    paymoney                          NUMBER(30)     NOT NULL,
    rdate                             DATE     NOT NULL,
  FOREIGN KEY (memberno) REFERENCES member (memberno)
);

COMMENT ON TABLE payment is '결제';
COMMENT ON COLUMN payment.paymentno is '결제번호';
COMMENT ON COLUMN payment.memberno is '회원 번호';
COMMENT ON COLUMN payment.realname is '성명';
COMMENT ON COLUMN payment.phone is '전화번호';
COMMENT ON COLUMN payment.postcode is '우편번호';
COMMENT ON COLUMN payment.address is '주소';
COMMENT ON COLUMN payment.detaddress is '상세주소';
COMMENT ON COLUMN payment.paytype is '결제종류';
COMMENT ON COLUMN payment.paymoney is '결제금액';
COMMENT ON COLUMN payment.rdate is '결제날짜';

-- ALTER TABLE payment RENAME COLUMN tel TO phone;

-- Sequence 생성 SQL
DROP SEQUENCE payment_seq;
CREATE SEQUENCE payment_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999999
  CACHE 2                     -- 2번은 메모리에서만 계산
  NOCYCLE;                   -- 다시 1부터 생성되는 것을 방지

-- 등록: 3건 이상
-- paytype = 1: 만남거래   2: 계좌이체    3: 신용카드  4: 모바일 
INSERT INTO payment(paymentno, memberno, realname, phone, postcode, address, detaddress,
                            paytype, paymoney, rdate)
VALUES(payment_seq.nextval, 1, '김민지', '010-1111-1111', '11111', '서울특별시 중구 광희동', '3-3',
            2, 10000, sysdate);

INSERT INTO payment(paymentno, memberno, realname, phone, postcode, address, detaddress,
                            paytype, paymoney, rdate)
VALUES (payment_seq.nextval, 2, '김철수', '010-2222-2222', '22222','서울특별시 중구 순화동', '64-4',
            2, 5000, sysdate);

INSERT INTO payment(paymentno, memberno, realname, phone, postcode, address, detaddress,
                            paytype, paymoney, rdate)
VALUES (payment_seq.nextval, 3 , '김민지', '010-1111-1111', '11111', '서울특별시 중구 광희동', '3-3',
            1, 7000, sysdate);

commit;

-- 전체 목록
SELECT paymentno, memberno, realname, phone, postcode, address, detaddress, paytype, paymoney, rdate
FROM payment
ORDER BY paymentno DESC;

-- 회원별 목록
SELECT paymentno, memberno, realname, phone, postcode, address, detaddress, paytype, paymoney, rdate
FROM payment
WHERE memberno=1
ORDER BY paymentno;


-- 삭제
DELETE FROM payment
WHERE paymentno=10;



/**********************************/
/* Table Name: 결제2 */
/**********************************/
DROP TABLE payment2 CASCADE CONSTRAINTS;

CREATE TABLE payment2(
    paymentno                         NUMBER(10)     NOT NULL    PRIMARY KEY,
    memberno                          NUMBER(10)     NULL ,
    productno                           NUMBER(10)     NULL ,
    realname                          VARCHAR(30)    NOT NULL,
    phone                               VARCHAR(20)    NOT NULL,
    postcode                          VARCHAR(10)    NOT NULL,
    address                           VARCHAR(50)    NOT NULL,
    detaddress                        VARCHAR(50)    NOT NULL,
    paytype                           NUMBER(1)    DEFAULT 1     NOT NULL,
    paymoney                          NUMBER(30)     NOT NULL,
    rdate                             DATE     NOT NULL,
  FOREIGN KEY (memberno) REFERENCES member (memberno),
  FOREIGN KEY (productno) REFERENCES orders (productno)
);

COMMENT ON TABLE payment2 is '결제';
COMMENT ON COLUMN payment2.paymentno is '결제번호';
COMMENT ON COLUMN payment2.memberno is '회원 번호';
COMMENT ON COLUMN payment2.realname is '성명';
COMMENT ON COLUMN payment2.phone is '전화번호';
COMMENT ON COLUMN payment2.postcode is '우편번호';
COMMENT ON COLUMN payment2.address is '주소';
COMMENT ON COLUMN payment2.detaddress is '상세주소';
COMMENT ON COLUMN payment2.paytype is '결제종류';
COMMENT ON COLUMN payment2.paymoney is '결제금액';
COMMENT ON COLUMN payment2.rdate is '결제날짜';

