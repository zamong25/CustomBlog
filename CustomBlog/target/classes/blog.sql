DROP TABLE menu;
DROP TABLE board;
DROP TABLE member;
DROP TABLE reply;

DROP SEQUENCE menu_seq;
DROP SEQUENCE board_seq;
DROP SEQUENCE reply_seq;

-- menu
CREATE TABLE menu
(
	menu_id           number primary key
	, menu_name  varchar2(30) not null unique
	, menu_order number not null unique
);

CREATE SEQUENCE menu_seq;

-- board
CREATE TABLE board
(	
	boardnum       number primary key
	, menu_name    varchar2(30) not null references menu(menu_name)
	, title        varchar2(200)  not null
	, text         varchar2(4000) not null
	, hitcount     number default 0
	, regdate      date default sysdate
	, originalfile varchar2(300)
	, savedfile    varchar2(300)
);

CREATE SEQUENCE board_seq;

-- member
CREATE TABLE member
(
	userid   varchar2(50) primary key
	, userpwd  varchar2(50) not null
	, username varchar2(50) not null
);

-- reply
CREATE TABLE reply
(
	replynum  number primary key
	, boardnum  number not null references board(boardnum), -- 참조하는 본문글번호
	, userid    varchar2(50)   not null,	-- 댓글 작성자 아이디
	, replytext varchar2(1000) not null,	-- 댓글 내용
	 ,regdate   date default sysdate		-- 댓글 작성일
);

CREATE SEQUENCE reply_seq;