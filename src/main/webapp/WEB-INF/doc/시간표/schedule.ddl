/**********************************/
/* Table Name: 시간표 */
/**********************************/

CREATE TABLE schedule(
		classno                     		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		classname                         		VARCHAR2(100)		 NOT NULL,
		textbook                       		VARCHAR2(100)		 NOT NULL,
		starttime                           		NUMBER(7)		 NOT NULL,
        endtime                           		NUMBER(7)		 NOT NULL,
		classroom                         		VARCHAR2(100)		 NULL ,
		professor                    		VARCHAR2(100)		 NULL 
);

COMMENT ON TABLE schedule is '시간표';
COMMENT ON COLUMN schedule.classno is '강의 번호';
COMMENT ON COLUMN schedule.classname is '강의명';
COMMENT ON COLUMN schedule.textbook is '교재';
COMMENT ON COLUMN schedule.starttime is '시작시간';
COMMENT ON COLUMN schedule.endtime is '종료시간';
COMMENT ON COLUMN schedule.classroom is '강의장';
COMMENT ON COLUMN schedule.professor is '교수님';

DROP SEQUENCE schedule_seq;
CREATE SEQUENCE schedule_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999999
  CACHE 2                     -- 2번은 메모리에서만 계산
  NOCYCLE;                   -- 다시 1부터 생성되는 것을 방지
  



