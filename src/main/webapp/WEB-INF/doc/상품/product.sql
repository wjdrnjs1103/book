/**********************************/
/* Table Name: 상품 */
/**********************************/
DROP TABLE product;
CREATE TABLE product(
		productno                     		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		bookno                        		NUMBER(10)		 NULL ,
		memberno                      		NUMBER(10)		 NULL ,
		title                         		VARCHAR2(100)		 NOT NULL,
		content                       		CLOB		 NOT NULL,
		cnt                           		NUMBER(7)		 DEFAULT 0		 NOT NULL,
		word                          		VARCHAR2(300)		 NULL ,
		rdate                         		DATE		 NOT NULL,
		file1                         		VARCHAR2(100)		 NULL ,
		file1saved                    		VARCHAR2(100)		 NULL ,
		thumb1                         		VARCHAR2(100)		 NULL ,
		size1                          		NUMBER(10)		 DEFAULT 0		 NULL ,
		price                         		NUMBER(10)		 DEFAULT 0		 NOT NULL,
  FOREIGN KEY (bookno) REFERENCES book (bookno),
  FOREIGN KEY (memberno) REFERENCES member (memberno)
);

COMMENT ON TABLE product is '상품';
COMMENT ON COLUMN product.productno is '상품 번호';
COMMENT ON COLUMN product.bookno is '전공도서 번호';
COMMENT ON COLUMN product.memberno is '회원 번호';
COMMENT ON COLUMN product.title is '제목';
COMMENT ON COLUMN product.content is '내용';
COMMENT ON COLUMN product.cnt is '조회수';
COMMENT ON COLUMN product.word is '검색어';
COMMENT ON COLUMN product.rdate is '등록일';
COMMENT ON COLUMN product.file1 is '메인 이미지';
COMMENT ON COLUMN product.file1saved is '실제 저장된 메인 이미지';
COMMENT ON COLUMN product.thumb1 is '메인 이미지 Preview';
COMMENT ON COLUMN product.size1 is '메인 이미지 크기';
COMMENT ON COLUMN product.price is '가격';

DROP SEQUENCE product_seq;
CREATE SEQUENCE product_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999999
  CACHE 2                     -- 2번은 메모리에서만 계산
  NOCYCLE;                   -- 다시 1부터 생성되는 것을 방지
  
INSERT INTO product(productno, bookno, memberno, title, content, cnt, word, rdate, file1, file1saved, thumb1, size1, price)
VALUES(product_seq.nextval, 1, 1, '스프링부트', '출판사:RubyPaper/상태좋음', 0, '스프링', sysdate, 'spring.jpg', 'spring_1.jpg', 'spring_t.jpg', 1000, 25000); 

INSERT INTO product(productno, bookno, memberno, title, content, cnt, word, rdate, file1, file1saved, thumb1, size1, price)
VALUES(product_seq.nextval, 1, 1, '자바프로그래밍', '출판사:한빛/상태보통', 0, '자바', sysdate, 'java.jpg', 'java_1.jpg', 'java_t.jpg', 1000, 19000);

-- 목록
SELECT productno, bookno, memberno, title, content, cnt, word, rdate, file1, file1saved, thumb1, size1, price
FROM product
ORDER BY productno ASC;

