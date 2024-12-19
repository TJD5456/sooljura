/*
순서 대로 drop하면 전체 테이블 삭제 가능.
DROP TABLE tbl_discount_hist;
DROP TABLE tbl_discount;
DROP TABLE tbl_basket;
DROP TABLE tbl_basket_type;
DROP TABLE tbl_youtube;
DROP TABLE tbl_product_image;
DROP TABLE tbl_order_history;
DROP TABLE tbl_product;
DROP TABLE tbl_product_category;
DROP TABLE tbl_user_addr;
DROP TABLE tbl_comment;
DROP TABLE tbl_post;
DROP TABLE tbl_post_type;
DROP TABLE tbl_chat;
DROP TABLE tbl_user;
DROP TABLE tbl_user_type;
*/
--ReadMe: 주석처리된 테이블 (tbl_order_history, table tbl_youtube, tbl_basket, tbl_discount_hist) 는 tbl_product 미존재로 인해 생성 대기.

create table tbl_user_type (
   user_cd number primary key,
   user_nm varchar2(20) not null
);

create table tbl_user (
   user_key      char(11) primary key,
   user_cd       number not null
      references tbl_user_type ( user_cd ),
   user_id       varchar2(30) not null,
   user_pw       varchar2(60) not null,
   user_email    varchar2(100) not null,
   user_nm     varchar2(50) not null,
   user_phone    char(11) not null,
   user_nicknm varchar2(50) not null,
   user_point    number default 0,
   adult_chk     number default 0,
   enroll_date   date default sysdate
);
--user의 u
-- 'u' || lpad(seq_user.nextval, 4, '0')
create sequence seq_user maxvalue 9999 cycle;
--insert into tbl_user values ( 'u' || lpad (seq_user.nextval, 4, '0'), ...);

create table tbl_post_type (
   post_cd number primary key,
   post_nm varchar2(30)
);

create table tbl_post (
   post_key        char(11) primary key,
   post_cd         number not null
      references tbl_post_type ( post_cd ),
   user_key        char(11) not null
      references tbl_user ( user_key )
         on delete cascade,
   comment_content varchar2(2000) not null,
   post_date       date default sysdate,
   confirm_yn      number default 0,
   delete_yn       number default 0,
   delete_reason   varchar2(200)
);
--게시글 코드 product랑 겹쳐서 's'로 생성.
-- 's' || lpad(seq_post .nextval, 4, '0')
create sequence seq_post maxvalue 9999 cycle;
--insert into tbl_post values ( 's' || lpad (seq_post .nextval, 4, '0'), ...);


create table tbl_comment (
   comment_key     char(11) primary key,
   post_key        char(11) not null
      references tbl_post ( post_key ),
   user_key        char(11) not null
      references tbl_user ( user_key )
         on delete cascade,
   comment_content varchar2(2000) not null,
   comment_date    date default sysdate
);
-- 'c' || lpad(seq_comment.nextval, 4, '0')
create sequence seq_comment maxvalue 9999 cycle;
--insert into tbl_comment values ( 'c' || lpad (seq_comment.nextval, 4, '0'), ...);

create table tbl_user_addr (
   addr_key    char(11) primary key,
   user_key    char(11) not null
      references tbl_user ( user_key )
         on delete cascade,
   addr_nm     char(30) not null,
   addr_code   char(5) not null,
   addr        varchar2(300) not null,
   addr_detail varchar2(100) not null,
   addr_ref    varchar2(50) not null,
   rcpt_nm     varchar2(50) not null,
   rcpt_phone  varchar2(11) not null,
   default_yn  number default 0
);
--address의 a
-- 'a' || lpad(seq_user_addr.nextval, 4, '0')
create sequence seq_user_addr maxvalue 9999 cycle;
--insert into tbl_user_addr values ( 'a' || lpad (seq_user_addr.nextval, 4, '0'), ...);

/*채팅 테이블 미존재*/

/*상품 카테고리 테이블 필요*/

/*상품 테이블 필요*/

/*
create table tbl_order_history (
   imp_uid       varchar2(255) primary key,
   order_no      char(11) UNIQUE NOT NULL,
   prod_key      char(11) not null
      references tbl_product ( prod_key ),
   user_key      char(11) not null
      references tbl_user ( user_key )
         on delete cascade,
   addr_key   char(11) not null
      references tbl_user_addr ( addr_key ),
   card_company  varchar2(50) not null,
   order_price   number,
   order_cnt     number,
   ordered_date  date default sysdate,
   refund_yn     number default 0,
   refund_reason varchar2(100) default 'Not satisfied',
   refund_key    char(11),
   refund_date   date
);
*/
-- 'o' || lpad(seq_order_history.nextval, 4, '0')
create sequence seq_order_history maxvalue 9999 cycle;
--insert into tbl_order_history values ( 'o' || lpad (seq_order_history.nextval, 4, '0'), ...);

/*상품 이미지 테이블  필요*/

/*상품 카테고리 테이블  필요*/

/*
create table tbl_youtube (
   youtube_url varchar2(100) primary key,
   content     varchar2(1000) not null,
   prod_key    char(11) not null
     references tbl_product ( prod_key )
        on delete cascade
);
*/

create table tbl_basket_type (
   basket_cd number primary key,
   basket_nm varchar2(30)
);
/*
create table tbl_basket (
   basket_key char(11) primary key,
   basket_cd  number not null
      references tbl_basket_type ( basket_cd ),
   prod_key   char(11) not null
      references tbl_product ( prod_key ),
   user_key   char(11) not null
      references tbl_user ( user_key )
         on delete cascade,
   basket_cnt number default 0
);
*/
-- 'b' || lpad(seq_basket.nextval, 4, '0')
create sequence seq_basket maxvalue 9999 cycle;
--insert into tbl_basket values ( 'b' || lpad (seq_basket.nextval, 4, '0'), ...);


create table tbl_discount (
   event_cd         number primary key,
   event_nm         varchar2(200),
   discount_percent number,
   discount_amount  number
);
/*
create table tbl_discount_hist (
   hist_cd    number primary key,
   prod_key   char(11) not null
      references tbl_product ( prod_key )
         on delete cascade,
   event_cd   number not null
      references tbl_discount ( event_cd ),
   start_date date,
   end_date   date
);
*/

