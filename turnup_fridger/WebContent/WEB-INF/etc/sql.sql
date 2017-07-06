


/*전체 사용자(회원, 관리자) 권한관리_로그인용*/
DROP TABLE AUTHORITY CASCADE CONSTRAINT;
DELETE FROM AUTHORITY;
CREATE TABLE AUTHORITY(
	LOGIN_ID VARCHAR2(20) PRIMARY KEY,
	LOGIN_PW VARCHAR2(20) NOT NULL,
	LOGIN_AUTHORITY VARCHAR2(50) NOT NULL
);
--관리자권한줄때 반드시 ROLE_**** 이런식으로 대문자!!
select * from authority order by login_id;

select * from admin order by admin_id;
--DELETE FROM AUTHORITY WHERE LOGIN_ID='admin1';
--insert into authority values('admin1','1111','ROLE_ADMIN');
--insert into authority values('user1','1111','ROLE_MEMBER');


/* 회원정보 */
DROP TABLE MEMBER CASCADE CONSTRAINT;
DELETE FROM MEMBER;
CREATE TABLE MEMBER (
   MEMBER_ID VARCHAR2(20) PRIMARY KEY, /* 회원ID */
   MEMBER_PW VARCHAR2(20) NOT NULL, /* 패스워드 */
   MEMBER_NAME VARCHAR2(30) NOT NULL, /* 이름 */
   MEMBER_ADDRESS VARCHAR2(100) NOT NULL, /* 주소 */
   MEMBER_EMAIL VARCHAR2(100) UNIQUE NOT NULL, /* 이메일 */
   MEMBER_TEL VARCHAR2(20) NOT NULL, /* 핸드폰번호 */
   MEMBER_SEX VARCHAR2(10) NOT NULL,/* 성별 */
   CONSTRAINT MEMBER_LOGIN_ID_FK FOREIGN KEY(MEMBER_ID) REFERENCES AUTHORITY(LOGIN_ID)
);
select * from member order by member_id;
--insert into MEMBER values('id','pw','이름','주소','이메일','전번','성별')
--INSERT INTO MEMBER VALUES('user1','1111','회원1','주소1','이메일1','전번1','여성');

/* 개인 메모 */
DROP TABLE MY_MEMO;
DELETE FROM MY_MEMO;
CREATE TABLE MY_MEMO (
	MEMO_ID NUMBER PRIMARY KEY, 
   MEMO_NAME VARCHAR2(100) NOT NULL, /* 메모제목 */
   MEMO_TXT VARCHAR2(3000) NOT NULL, /* 메목내용 */
   MEMBER_ID VARCHAR2(20) NOT NULL,    /* 회원ID */
   REGISTERED_DATE DATE NOT NULL,  /* 작성일 */
   CONSTRAINT MY_MEMO_MEMBER_ID_FK FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER
);
DROP SEQUENCE MEMO_ID;
CREATE SEQUENCE MEMO_ID INCREMENT BY 1 START WITH 1; 
--SELECT MEMO_ID.NEXTVAL FROM DUAL;

/* Q&A */
DROP TABLE BOARD_QNA;
DELETE FROM BOARD_QNA;
CREATE TABLE BOARD_QNA (
   BOARD_QNA_ID NUMBER PRIMARY KEY, /* Q&A ID */
   BOARD_QNA_TITLE VARCHAR2(300) NOT NULL, /* 제목 */
   BOARD_QNA_TXT VARCHAR2(3000) NOT NULL, /* 내용 */
   BOARD_QNA_DATE DATE DEFAULT SYSDATE NOT NULL, /* 작성일 */
   MEMBER_ID VARCHAR2(20) NOT NULL, /* 회원ID */
   CONSTRAINT BOARD_QNA_MEMBER_ID_FK FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER
);

INSERT INTO BOARD_QNA VALUES(1,'이거 어떻게 해요?','레시피등록하는 방법좀 알려주세요',to_date('20031201', 'yyyy-mm-dd'),'jang')

DROP SEQUENCE BOARD_QNA_ID;
CREATE SEQUENCE BOARD_QNA_ID INCREMENT BY 1 START WITH 1;  
--SELECT BOARD_QNA_ID.NEXTVAL FROM DUAL;

/* 자유게시판 */
DROP TABLE BOARD_FREE  CASCADE CONSTRAINT;
DELETE FROM BOARD_FREE;
CREATE TABLE BOARD_FREE (
   BOARD_FREE_ID NUMBER PRIMARY KEY, /* 자유게시판 ID */
   BOARD_FREE_HEAD VARCHAR2(20) NOT NULL, /* 말머리 */
   BOARD_FREE_TITLE VARCHAR2(300) NOT NULL, /* 제목 */
   BOARD_FREE_TXT VARCHAR2(3000) NOT NULL, /* 내용 */
   BOARD_FREE_DATE DATE NOT NULL, /* 작성일 */
   BOARD_FREE_HITS NUMBER NOT NULL, /* 조회수 */
   BOARD_FREE_STAR NUMBER, /* 별점 */
   MEMBER_ID VARCHAR2(20) NOT NULL, /* 회원ID */
   CONSTRAINT BOARD_FREE_MEMBER_ID_FK FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER
);
DROP SEQUENCE BOARD_FREE_ID;
CREATE SEQUENCE BOARD_FREE_ID INCREMENT BY 1 START WITH 1; 
--SELECT BOARD_FREE_ID.NEXTVAL FROM DUAL;

/* 자유게시판 사진 */
DROP TABLE BOARD_FREE_IMG  CASCADE CONSTRAINT;
DELETE FROM BOARD_FREE_IMG;
CREATE TABLE BOARD_FREE_IMG (
   BOARD_FREE_IMG_KEY NUMBER PRIMARY KEY, /* 자유게시판사진 번호 KEY */
   BOARD_FREE_IMG_URL VARCHAR2(1000) NOT NULL, /* 자유게시판 사진 */
   BOARD_FREE_ID NUMBER NOT NULL, /* 자유게시판 ID */
   CONSTRAINT IMG_BOARD_FREE_ID_FK FOREIGN KEY(BOARD_FREE_ID) REFERENCES BOARD_FREE
);

DROP SEQUENCE BOARD_FREE_IMG_KEY;
CREATE SEQUENCE BOARD_FREE_IMG_KEY INCREMENT BY 1 START WITH 1;  
--SELECT BOARD_FREE_IMG_KEY.NEXTVAL FROM DUAL;

/* 자유게시판댓글 */
DROP TABLE COMMENT_FREE  CASCADE CONSTRAINT;
DELETE FROM COMMENT_FREE;
CREATE TABLE COMMENT_FREE (
   COMMENT_FREE_ID NUMBER PRIMARY KEY, /* 자유게시판 댓글 ID */
   COMMENT_FREE_TXT VARCHAR2(500) NOT NULL, /* 자유게시판 댓글 내용 */
   COMMENT_FREE_DATE DATE NOT NULL, /* 자유게시판 댓글 작성일 */
   BOARD_FREE_ID NUMBER NOT NULL, /* 자유게시판 ID */
   MEMBER_ID VARCHAR2(20) NOT NULL, /* 회원ID */
   CONSTRAINT COMMENT_FREE_BOARD_FREE_ID_FK FOREIGN KEY(BOARD_FREE_ID) REFERENCES  BOARD_FREE,
   CONSTRAINT COMMENT_FREE_MEMBER_ID_FK FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER
);
DROP SEQUENCE COMMENT_FREE_ID;
CREATE SEQUENCE COMMENT_FREE_ID INCREMENT BY 1 START WITH 1; 
--SELECT COMMENT_FREE_ID.NEXTVAL FROM DUAL;


/* 레시피 공유 게시판 */
DROP TABLE BOARD_SHARE_RECIPE  CASCADE CONSTRAINT;
DELETE FROM BOARD_SHARE_RECIPE;
CREATE TABLE BOARD_SHARE_RECIPE (
   BOARD_SHARE_RECIPE_ID NUMBER PRIMARY KEY, /* 레시피 공유 ID */
   BOARD_SHARE_RECIPE_TITLE VARCHAR2(100) NOT NULL, /* 제목 */
   BOARD_SHARE_RECIPE_TXT VARCHAR2(3000) NOT NULL, /* 내용 */
   BOARD_SHARE_RECIPE_DATE DATE NOT NULL, /* 작성일 */
   BOARD_SHARE_RECIPE_RECOMMAND NUMBER NOT NULL, /* 추천수 */
   BOARD_SHARE_RECIPE_HITS NUMBER NOT NULL, /* 조회수 */
   BOARD_SHARE_IRDNT_ETC VARCHAR2(500), /* 기타재료 */
   MEMBER_ID VARCHAR2(20) NOT NULL, /* 회원ID */
   CONSTRAINT BSR_MEMBER_ID_FK FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER
);
DROP SEQUENCE BOARD_SHARE_RECIPE_ID;
CREATE SEQUENCE BOARD_SHARE_RECIPE_ID INCREMENT BY 1 START WITH 1;  
--SELECT BOARD_SHARE_RECIPE_ID.NEXTVAL FROM DUAL;

/* 레시피 공유 게시판 사진 */
DROP TABLE BOARD_SHARE_RECIPE_IMG;
DELETE FROM BOARD_SHARE_RECIPE_IMG;
CREATE TABLE BOARD_SHARE_RECIPE_IMG (
   BOARD_SHARE_RECIPE_IMG_KEY NUMBER PRIMARY KEY, /* 공유게시판사진 번호 KEY */
   BOARD_SHARE_RECIPE_IMG_URL VARCHAR2(1000) NOT NULL, /* 공유게시판 사진 */
   BOARD_SHARE_RECIPE_ID NUMBER NOT NULL, /* 레시피 공유 ID */
   CONSTRAINT IMG_BOARD_SHARE_RECIPE_ID_FK FOREIGN KEY(BOARD_SHARE_RECIPE_ID) REFERENCES  BOARD_SHARE_RECIPE
);
DROP SEQUENCE BOARD_SHARE_RECIPE_IMG_KEY;
CREATE SEQUENCE BOARD_SHARE_RECIPE_IMG_KEY INCREMENT BY 1 START WITH 1;  
--SELECT BOARD_SHARE_RECIPE_IMG_KEY.NEXTVAL FROM DUAL;

/* 회원별공유레시피추천현황 */
DROP TABLE MEMBER_RECIPE_RECOMMAND;
DELETE FROM MEMBER_RECIPE_RECOMMAND;
CREATE TABLE MEMBER_RECIPE_RECOMMAND (
   MEMBER_RECIPE_RECOMMAND_KEY NUMBER PRIMARY KEY, /* 회원별공유레시피추천현황 KEY */
   BOARD_SHARE_RECIPE_ID NUMBER NOT NULL, /* 레시피 공유 ID */
   MEMBER_ID VARCHAR2(20) NOT NULL, /* 회원ID */
   CONSTRAINT MRR_SHARE_RECIPE_ID_FK FOREIGN KEY(BOARD_SHARE_RECIPE_ID) REFERENCES  BOARD_SHARE_RECIPE,
   CONSTRAINT MRR_MEMBER_ID_FK FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER
);

DROP SEQUENCE MEMBER_RECIPE_RECOMMAND_KEY;
CREATE SEQUENCE MEMBER_RECIPE_RECOMMAND_KEY INCREMENT BY 1 START WITH 1;  
--SELECT MEMBER_RECIPE_RECOMMAND_KEY.NEXTVAL FROM DUAL;

/* 냉장고 */
DROP TABLE fridger CASCADE CONSTRAINT;
--ALTER TABLE fridger ADD(member_id VARCHAR2(20));
--ALTER TABLE fridger DROP CONSTRAINT member_id_fk;
ALTER TABLE fridger ADD CONSTRAINT member_id_fk FOREIGN KEY (member_id) REFERENCES member ON DELETE CASCADE;
DELETE FROM fridger;
CREATE TABLE fridger (
   fridger_ID NUMBER PRIMARY KEY, /* 냉장고ID */
   fridger_NAME VARCHAR2(30) NOT NULL, /* 냉장고애칭 */
   member_id	VARCHAR2(20) NOT NULL,  /* 냉장고 마스터 회원*/
   CONSTRAINT member_id_fk FOREIGN KEY (member_id) REFERENCES member ON DELETE CASCADE
);
DROP SEQUENCE fridger_ID;
CREATE SEQUENCE fridger_ID INCREMENT BY 1 START WITH 1;  
--SELECT fridger_ID.NEXTVAL FROM DUAL;

insert into fridger values(1, '215', 'id-1');
select * from fridger;

/* 냉장고공용그룹 */
DROP TABLE fridger_GROUP;
DELETE FROM fridger_GROUP;
CREATE TABLE fridger_GROUP (
   GROUP_KEY NUMBER PRIMARY KEY, /* 공용그룹KEY */
   GROUP_JOIN_SEQ NUMBER NOT NULL, /* 그룹가입순서 */
   GROUP_MEMBER_ID VARCHAR2(20) NOT NULL, /* 회원ID */
   FRIDGER_ID NUMBER, /* 냉장고ID */
   CONSTRAINT fridger_GROUP_MEMBER_ID_FK FOREIGN KEY(group_MEMBER_ID) REFERENCES MEMBER(member_id),
   CONSTRAINT fridger_GROUP_fridger_ID_FK FOREIGN KEY(fridger_ID) REFERENCES fridger
);
DROP SEQUENCE GROUP_KEY;
CREATE SEQUENCE GROUP_KEY INCREMENT BY 1 START WITH 1; 
--SELECT GROUP_KEY.NEXTVAL FROM DUAL;

/* 공지사항 */
DROP TABLE BOARD_NOTICE;
DELETE FROM BOARD_NOTICE;
CREATE TABLE BOARD_NOTICE (
   BOARD_NOTICE_ID NUMBER PRIMARY KEY, /* 공지사항 ID */
   BOARE_NOTICE_ITEMS VARCHAR2(30) NOT NULL, /*항목*/
   BOARD_NOTICE_TITLE VARCHAR2(300) NOT NULL, /* 제목 */
   BOARD_NOTICE_TXT VARCHAR2(3000) NOT NULL, /* 내용 */
   BOARD_NOTICE_IMG VARCHAR2(500), /* 사진 */
   BOARD_NOTICE_SAVE_IMG VARCHAR2(500), /* UUID로 생성한 사진 이름*/
   BOARD_NOTICE_DATE DATE DEFAULT SYSDATE NOT NULL /* 작성일 */
); 
DROP SEQUENCE BOARD_NOTICE_ID;
CREATE SEQUENCE BOARD_NOTICE_ID INCREMENT BY 1 START WITH 1;  
SELECT BOARD_NOTICE_ID.NEXTVAL FROM DUAL;
select * from BOARD_NOTICE
/* 쇼핑몰 */
DROP TABLE SHOP;
DELETE FROM SHOP;
CREATE TABLE SHOP (
   SHOP_ID NUMBER PRIMARY KEY, /* 쇼핑몰 번호 */
   SHOP_NAME VARCHAR2(200) NOT NULL, /* 쇼핑몰 이름 */
   SHOP_ADDRESS VARCHAR2(1000) NOT NULL, /* 쇼핑몰 주소 */
   SHOP_IMG VARCHAR2(500) /* 사진 */
);
DROP SEQUENCE SHOP_ID;
CREATE SEQUENCE SHOP_ID INCREMENT BY 1 START WITH 1;  
--SELECT SHOP_ID.NEXTVAL FROM DUAL;

/* 재료 관리 */
DROP TABLE IRDNT_MANAGE;
--ALTER TABLE IRDNT_MANAGE ADD(NOTE VARCHAR2(50));
DELETE FROM IRDNT_MANAGE;
CREATE TABLE IRDNT_MANAGE (
   IRDNT_ID NUMBER PRIMARY KEY, /* 재료ID */
   IRDNT_name VARCHAR2(280) NOT NULL, /* 재료명 */
   IRDNT_CATEGORY VARCHAR2(20), /* 재료분류 */
   ROOM_TEM_PERIOD NUMBER, /*상온보관기간*/
   COLD_TEM_PERIOD NUMBER, /*냉장보관기간*/
   FREEZE_TEM_PERIOD NUMBER, /*냉동보관기간*/
   NOTE VARCHAR2(50)
);
DROP SEQUENCE IRDNT_ID;
CREATE SEQUENCE IRDNT_ID INCREMENT BY 1000 START WITH 1;  
SELECT IRDNT_ID.NEXTVAL FROM DUAL;

--insert into irdnt_manage values (0,'테스트','가공식품',1,1,1,'테스트야~');
--select * from IRDNT_MANAGE;
--select distinct irdnt_category from irdnt_manage;
  
/* 나의 식재료 */
DROP TABLE MY_IRDNT;
DELETE FROM MY_IRDNT;
--ALTER TABLE fridger ADD(IRDNT_NAME VARCHAR2(280) NOT NULL);
CREATE TABLE MY_IRDNT (
   MY_IRDNT_KEY NUMBER PRIMARY KEY, /* 나의식재료KEY */
   START_DATE DATE NOT NULL, /* 보관시작일 */
   END_DATE DATE, /* 유통기한 */
   FRESH_LEVEL NUMBER NOT NULL, /* 신선도 */
   IRDNT_COUNT VARCHAR2(3000), /* 수량메모 */
   IRDNT_ID NUMBER NOT NULL, /* 재료ID */ 
   IRDNT_NAME VARCHAR2(280) NOT NULL,
   fridger_ID NUMBER NOT NULL, /* 냉장고ID */
   START_FRESH_LEVEL VARCHAR2(30) NOT NULL,
   STORGE_PLACE VARCHAR2(30) NOT NULL,
   CONSTRAINT MY_IRDNT_IRDNT_ID_FK FOREIGN KEY(IRDNT_ID) REFERENCES IRDNT_MANAGE,
   CONSTRAINT MY_IRDNT_fridger_ID_FK FOREIGN KEY(fridger_ID) REFERENCES fridger
);
DROP SEQUENCE MY_IRDNT_KEY;
CREATE SEQUENCE MY_IRDNT_KEY INCREMENT BY 1 START WITH 1; 
SELECT MY_IRDNT_KEY.NEXTVAL FROM DUAL;

--insert into MY_IRDNT values (1,'2017-05-01','2017-06-01',2,'5',2,'2',1,'좋음');
--select * from MY_IRDNT;

/* 공유레시피재료 */
DROP TABLE SHARE_RECIPE_IRDNT;
DELETE FROM SHARE_RECIPE_IRDNT;
CREATE TABLE SHARE_RECIPE_IRDNT (
   SHARE_RECIPE_IRDNT_KEY NUMBER PRIMARY KEY, /* 공유레시피재료KEY */
   BOARD_SHARE_RECIPE_ID NUMBER NOT NULL, /* 레시피 공유 ID */
   IRDNT_ID NUMBER NOT NULL, /* 재료ID */
   CONSTRAINT SEI_BOARD_SHARE_RECIPE_ID_FK FOREIGN KEY(BOARD_SHARE_RECIPE_ID) REFERENCES  BOARD_SHARE_RECIPE,
   CONSTRAINT SRI_IRDNT_ID_FK FOREIGN KEY(IRDNT_ID) REFERENCES IRDNT_MANAGE
);
DROP SEQUENCE SHARE_RECIPE_IRDNT_KEY;
CREATE SEQUENCE SHARE_RECIPE_IRDNT_KEY INCREMENT BY 1 START WITH 1;  
--SELECT SHARE_RECIPE_IRDNT_KEY.NEXTVAL FROM DUAL;

/* 개인기피재료 */
DROP TABLE MY_DISLIKE_IRDNT;
DELETE FROM MY_DISLIKE_IRDNT;
CREATE TABLE MY_DISLIKE_IRDNT (
   MY_DISLIKE_IRDNT_KEY NUMBER PRIMARY KEY, /* 기피재료KEY */
   MEMBER_ID VARCHAR2(20) NOT NULL, /* 회원ID */
   IRDNT_ID NUMBER NOT NULL, /* 재료ID */
   CONSTRAINT MY_DISLIKE_IRDNT_MEMBER_ID_FK FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER,
   CONSTRAINT MY_DISLIKE_IRDNT_IRDNT_ID_FK FOREIGN KEY(IRDNT_ID) REFERENCES IRDNT_MANAGE
);
DROP SEQUENCE MY_DISLIKE_IRDNT_KEY;
CREATE SEQUENCE MY_DISLIKE_IRDNT_KEY INCREMENT BY 1 START WITH 1; 
--SELECT MY_DISLIKE_IRDNT_KEY.NEXTVAL FROM DUAL;
select * from MY_DISLIKE_IRDNT;
insert into MY_DISLIKE_IRDNT values(1,'id',2);

/* 관리자  */
DROP TABLE ADMIN;
DELETE FROM ADMIN;
CREATE TABLE ADMIN (
   ADMIN_ID VARCHAR2(20) PRIMARY KEY, /* 관리자 ID */
   ADMIN_PW VARCHAR2(20) NOT NULL, /* 비밀번호 */
   ADMIN_NAME VARCHAR2(30) NOT NULL, /* 이름 */
   ADMIN_TEL VARCHAR2(20) NOT NULL, /* 핸드폰번호 */
   ADMIN_EMAIL VARCHAR2(100) NOT NULL, /* 이메일 */
   ADMIN_AUTHORITY VARCHAR2(50), /* 권한 */
   CONSTRAINT ADMIN_LOGIN_ID_FK FOREIGN KEY(ADMIN_ID) REFERENCES AUTHORITY(LOGIN_ID)
);
--관리자권한줄때 반드시 ROLE_**** 이런식으로 대문자!!
--SELECT * FROM ADMIN;
--DELETE FROM ADMIN WHERE ADMIN_ID='admin1';
--insert into admin values('admin1','1111','관리자1','01097029900','kite_90@naver.com','ROLE_ADMIN');

/* Q&A 댓글 */
DROP TABLE COMMENT_QNA;
DELETE FROM COMMENT_QNA;
CREATE TABLE COMMENT_QNA (
   COMMENT_QNA_ID NUMBER PRIMARY KEY, /* Q&A 댓글 번호 */
   COMMENT_QNA_TXT VARCHAR2(500) NOT NULL, /* Q&A 댓글 내용 */
   COMMENT_QNA_DATE DATE DEFAULT SYSDATE NOT NULL, /* Q&A 댓글 작성일 */
   ADMIN_ID VARCHAR2(20), /* 관리자 ID */
   MEMBER_ID VARCHAR2(20),/* 회원 ID */
   BOARD_QNA_ID NUMBER NOT NULL, /* Q&A ID */
   CONSTRAINT COMMENT_QNA_ADMIN_ID_FK FOREIGN KEY(ADMIN_ID) REFERENCES ADMIN ON DELETE CASCADE,
   CONSTRAINT COMMENT_QNA_MEMBER_ID_FK FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER ON DELETE CASCADE,
   CONSTRAINT COMMENT_QNA_BOARD_QNA_ID_FK FOREIGN KEY(BOARD_QNA_ID) REFERENCES BOARD_QNA ON DELETE CASCADE	
);
DROP SEQUENCE COMMENT_QNA_ID;
CREATE SEQUENCE COMMENT_QNA_ID INCREMENT BY 1 START WITH 1;  
--SELECT COMMENT_QNA_ID.NEXTVAL FROM DUAL;

/* 레시피 기본정보 */

DROP TABLE RECIPE_INFO cascade constraint;
DELETE FROM RECIPE_INFO;

CREATE TABLE RECIPE_INFO (
   RECIPE_ID NUMBER PRIMARY KEY, /* 레시피 코드 */
   RECIPE_name VARCHAR2(50) NOT NULL, /* 레시피 이름 */
   SUMRY VARCHAR2(400) NOT NULL, /* 간략(요약) 소개 */
   category_CODE NUMBER NOT NULL, /* 유형코드 */
   category_name VARCHAR2(50) NOT NULL, /* 유형분류 */
   type_CODE NUMBER NOT NULL, /* 음식분류코드 */
   type_name VARCHAR2(50) NOT NULL, /* 음식분류 */
   COOKING_TIME VARCHAR2(50) NOT NULL, /* 조리시간 */
   CALORIE VARCHAR2(20) NOT NULL, /* 칼로리 */
   QNT VARCHAR2(20) NOT NULL, /* 분량 */
   recipe_LEVEL VARCHAR2(20) NOT NULL, /* 난이도 */
   IRDNT_CODE VARCHAR2(50), /* 재료별 분류명 */
   price VARCHAR2(20), /* 가격별 분류 */
   IMG_URL VARCHAR2(300) NOT NULL, /* 대표이미지 URL */
   DET_URL VARCHAR2(300) NOT NULL, /* 상세 URL */
   RECIPE_HITS NUMBER NOT NULL /* 조회수 */
);

--select * from RECIPE_INFO
--select distinct category_name from RECIPE_INFO
--select category_name, type_name from RECIPE_INFO where category_name ='퓨전' group by category_name, type_name 
--select distinct recipe_level from RECIPE_INFO 

/* 레시피 과정정보 */
DROP TABLE RECIPE_CRSE;
DELETE FROM RECIPE_CRSE;
CREATE TABLE RECIPE_CRSE (
   RECIPE_ID NUMBER, /* 레시피 코드 */
   COOKING_NO NUMBER, /* 요리설명순서 */
   COOKING_DC VARCHAR2(400) NOT NULL, /* 요리설명 */
   STEP_IMAGE_URL VARCHAR2(300), /* 과정 이미지 URL */
   STEP_TIP VARCHAR2(400), /* 과정팁 */
   PRIMARY KEY(recipe_id, cooking_no),
   CONSTRAINT VTRC_RECIPE_ID_FK FOREIGN KEY(RECIPE_ID) REFERENCES RECIPE_INFO on delete cascade
);

/* 레시피 재료정보 */
DROP TABLE RECIPE_IRDNT CASCADE CONSTRAINT;
DELETE FROM RECIPE_IRDNT;
CREATE TABLE RECIPE_IRDNT (
   IRDNT_no NUMBER PRIMARY KEY, /* 재료순번 */
   IRDNT_name VARCHAR2(280) NOT NULL, /* 재료명 */
   IRDNT_amount VARCHAR2(280), /* 재료용량 */
   IRDNT_type_CODE NUMBER NOT NULL, /* 재료타입 코드 */
   IRDNT_type_name VARCHAR2(280) NOT NULL, /* 재료타입명 */
   RECIPE_ID NUMBER, /* 레시피 코드 */
   IRDNT_ID NUMBER, /* 재료ID */
   CONSTRAINT VTRI_RECIPE_ID_FK FOREIGN KEY(RECIPE_ID) REFERENCES RECIPE_INFO on delete cascade,
   CONSTRAINT VTRI_IRDNT_ID_FK FOREIGN KEY(IRDNT_ID) REFERENCES IRDNT_MANAGE 
);
select distinct irdnt_name from RECIPE_IRDNT order by irdnt_name;
select count(*) from recipe_crse;
select count(*) from recipe_info;
select count(*) from recipe_irdnt;

/* 즐겨찾기 */
DROP TABLE FAVORITE_RECIPE;
DELETE FROM FAVORITE_RECIPE;
CREATE TABLE FAVORITE_RECIPE (
   FAVORITE_RECIPE_KEY NUMBER PRIMARY KEY, /* 즐겨찾기 번호 */
   MEMBER_ID VARCHAR2(20) NOT NULL, /* 회원ID */
   RECIPE_ID NUMBER NOT NULL, /* 레시피 코드 */
   CONSTRAINT FAVORITE_RECIPE_MEMBER_ID_FK FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER,
   CONSTRAINT FAVORITE_RECIPE_RECIPE_ID_FK FOREIGN KEY(RECIPE_ID) REFERENCES RECIPE_INFO
);
DROP SEQUENCE FAVORITE_RECIPE_KEY;
CREATE SEQUENCE FAVORITE_RECIPE_KEY INCREMENT BY 1 START WITH 1;  
--SELECT FAVORITE_RECIPE_KEY.NEXTVAL FROM DUAL;





--------(6/28) 냉장고 그룹 가입 처리를 위한 테이블 BY은영---------------------------------
DROP TABLE join_process;
DELETE FROM join_process;
CREATE TABLE join_process (
	process_no		NUMBER	PRIMARY KEY,	/* 처리번호*/
	process_fridger_id	NUMBER	NOT NULL,	/*처리대상 냉장고 (그룹)*/
	process_state	NUMBER	NOT NULL,	/*처리상태: 10-가입승인대기,11-가입승인완료, 12-가입승인거절,20-초대승인대기,21-초대승인완료, 22-초대승인거절*/
	req_date	DATE	NOT NULL,	/*신청일*/
	resp_date	DATE,				/*승인일*/
	req_member_id	VARCHAR2(20)	NOT NULL,	/*요청회원*/
	resp_member_id	VARCHAR2(20)	NOT NULL,	/*응답회원*/
CONSTRAINT pprocess_fridger_id_fk FOREIGN KEY(process_fridger_id) REFERENCES FRIDGER(fridger_id),
CONSTRAINT req_member_id_fk FOREIGN KEY(req_member_id) REFERENCES MEMBER(member_id),
CONSTRAINT resp_member_id_fk FOREIGN KEY(resp_member_id) REFE	RENCES MEMBER(member_id)
);
DROP SEQUENCE process_no;
CREATE SEQUENCE process_no INCREMENT BY 1 START WITH 1;
SELECT * FROM JOIN_PROCESS





-------------------재로료 레시피 추출하기(원하는 재료포함, 기피재료 미포함)------------
SELECT * FROM RECIPE_IRDNT;

SELECT	COUNT(*), recipe_id
		recipe_id
FROM	recipe_irdnt
WHERE	recipe_id	NOT IN (
	SELECT	recipe_id
	FROM	recipe_irdnt
	WHERE	irdnt_id	IN ( 50 )
)
AND		irdnt_id	IN ( 702, 29, 169, 302, 303, 176)
GROUP BY	recipe_id
HAVING COUNT(*) >= 2
ORDER BY	COUNT(*) DESC, recipe_id;


