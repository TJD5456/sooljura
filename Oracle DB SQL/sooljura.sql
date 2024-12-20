-- user: sooljura
-- password: 1234

drop table tbl_user_type cascade constraint;
drop table tbl_user cascade constraint;
drop table tbl_user_addr cascade constraint;
drop table tbl_post_type cascade constraint;
drop table tbl_post cascade constraint;
drop table tbl_comment cascade constraint;
drop table tbl_chat cascade constraint;
drop table tbl_product_category cascade constraint;
drop table tbl_product cascade constraint;
drop table tbl_product_image cascade constraint;
drop table tbl_youtube cascade constraint;
drop table tbl_discount_info cascade constraint;
drop table tbl_discount_history cascade constraint;
drop table tbl_basket_type cascade constraint;
drop table tbl_basket cascade constraint;
drop table tbl_order_history cascade constraint;

drop sequence seq_user;
drop sequence seq_addr;
drop sequence seq_post;
drop sequence seq_comment;
drop sequence seq_chat;
drop sequence seq_product_category;
drop sequence seq_product;
drop sequence seq_product_image;
drop sequence seq_discount_info;
drop sequence seq_discount_histstory;
drop sequence seq_basket;
drop sequence seq_order_history;
drop sequence seq_refund_key;

create table tbl_user_type (
   user_cd number primary key,
   user_nm varchar2(30) not null
);

insert into tbl_user_type values ( 0, '관리자' );
insert into tbl_user_type values ( 1, '레벨 1 회원' );
insert into tbl_user_type values ( 2, '레벨 2 회원' );
insert into tbl_user_type values ( 3, '레벨 3 회원' );
insert into tbl_user_type values ( 4, '레벨 4 회원' );
insert into tbl_user_type values ( - 1, '관리대상' );

create table tbl_user (
   user_key    char(12) primary key,
   user_cd     number not null references tbl_user_type ( user_cd ),
   user_id     varchar2(30) not null,
   user_pw     varchar2(60) not null,
   user_email  varchar2(100) not null,
   user_nm     varchar2(50) not null,
   user_phone  char(11) not null,
   user_nicknm varchar2(50) not null,
   user_point  number default 0,
   adult_chk   number default 0,
   enroll_date date default sysdate
);

-- 'us' || lpad(seq_user.nextval, 4, '0')
create sequence seq_user maxvalue 9999 cycle;

create table tbl_user_addr (
   addr_key    char(12) primary key,
   user_key    char(12) not null references tbl_user ( user_key ) on delete cascade,
   addr_nm     char(30) not null,
   addr_code   char(5) not null,
   addr        varchar2(300) not null,
   addr_detail varchar2(100) not null,
   addr_ref    varchar2(50) not null,
   rcpt_nm     varchar2(50) not null,
   rcpt_phone  varchar2(11) not null,
   default_yn  number default 0
);

-- 'ad' || lpad(seq_user_addr.nextval, 4, '0')
create sequence seq_addr maxvalue 9999 cycle;

create table tbl_post_type (
   post_cd number primary key,
   post_nm varchar2(30)
);

insert into tbl_post_type values ( 1, '게시글' );
insert into tbl_post_type values ( 2, '후기' );

create table tbl_post (
   post_key        char(12) primary key,
   post_cd         number not null references tbl_post_type ( post_cd ) on delete cascade,
   user_key        char(12) not null references tbl_user ( user_key ) on delete set null,
   comment_content varchar2(2000) not null,
   post_date       date default sysdate,
   confirm_yn      number default 0,
   delete_yn       number default 0,
   delete_reason   varchar2(200)
);

-- 'po' || lpad(seq_post .nextval, 4, '0')
create sequence seq_post maxvalue 9999 cycle;

create table tbl_comment (
   comment_key     char(12) primary key,
   post_key        char(12) not null references tbl_post ( post_key ) on delete set null,
   user_key        char(12) not null references tbl_user ( user_key ) on delete set null,
   comment_content varchar2(2000) not null,
   comment_date    date default sysdate
);

-- 'cm' || lpad(seq_comment.nextval, 4, '0')
create sequence seq_comment maxvalue 9999 cycle;

create table tbl_chat (
   chat_key      char(12) primary key,
   chat_room_key char(12) not null,
   sender        char(12) not null references tbl_user ( user_key ) on delete set null,
   receiver      char(12) not null references tbl_user ( user_key ) on delete set null,
   chat_content  varchar2(1000) not null,
   sent_date     date default sysdate,
   check_yn      number default 0
);

-- 'ch' || lpad(seq_chat.nextval, 4, '0')
create sequence seq_chat maxvalue 9999 cycle;

create table tbl_product_category (
   category_key   char(5) primary key,
   category_level number,
   category_nm    varchar2(50),
   higher_category references tbl_product_category ( category_key )
);

-- 'c' || lpad(seq_product_category.nextval, 4, '0')
create sequence seq_product_category maxvalue 9999 cycle;

insert into tbl_product_category values ( 'c' || lpad( seq_product_category.nextval, 4, '0'), 1, '증류주/소주', null );
insert into tbl_product_category values ( 'c' || lpad( seq_product_category.nextval, 4, '0'), 1, '맥주', null );
insert into tbl_product_category values ( 'c' || lpad( seq_product_category.nextval, 4, '0'), 1, '전통주', null );
insert into tbl_product_category values ( 'c' || lpad( seq_product_category.nextval, 4, '0'), 1, '와인/샴페인', null );
insert into tbl_product_category values ( 'c' || lpad( seq_product_category.nextval, 4, '0'), 1, '위스키/리큐르', null );
insert into tbl_product_category values ( 'c' || lpad( seq_product_category.nextval, 4, '0'), 1, '기타', null );

create table tbl_product (
   prod_key     char(12) primary key,
   prod_name    varchar2(100) not null,
   prod_price   number not null,
   prod_maker   varchar2(100) not null,
   prod_origin  varchar2(100) not null,
   prod_intro   varchar2(4000) not null,
   prod_cnt     number not null,
   upload_date  date default sysdate,
   category_key char(12) references tbl_product_category ( category_key )
);

-- 'pr' || to_char(sysdate, 'yymmdd') || lpad(seq_product.nextval, 4, '0')
create sequence seq_product maxvalue 9999 cycle;

create table tbl_product_image (
   img_key  char(12) primary key,
   img_nm   varchar2(100),
   img_path varchar2(100),
   prod_key references tbl_product ( prod_key ) on delete cascade
);

-- 'im' || to_char(sysdate, 'yymmdd') || lpad(seq_product_image.nextval, 4, '0')
create sequence seq_product_image maxvalue 9999 cycle;

create table tbl_youtube (
   youtube_url varchar2(100) primary key,
   content     varchar2(1000) not null,
   prod_key    char(12) not null references tbl_product ( prod_key ) on delete cascade
);

create table tbl_discount_info (
   event_cd         char(12) primary key,
   event_nm         varchar2(200),
   discount_percent number,
   discount_amount  number
);

-- 'di' || to_char(sysdate, 'yymmdd') || lpad(seq_discount_info.nextval, 4, '0')
create sequence seq_discount_info maxvalue 9999 cycle;

create table tbl_discount_history (
   hist_cd    char(12) primary key,
   prod_key   char(12) not null references tbl_product ( prod_key ) on delete set null,
   event_cd   char(12) not null references tbl_discount_info ( event_cd ) on delete set null,
   start_date date,
   end_date   date
);

-- 'dh' || to_char(sysdate, 'yymmdd') || lpad(seq_discount_histstory.nextval, 4, '0')
create sequence seq_discount_histstory maxvalue 9999 cycle;

create table tbl_basket_type (
   basket_cd number primary key,
   basket_nm varchar2(30)
);

insert into tbl_basket_type values ( 1, '장바구니' );
insert into tbl_basket_type values ( 2, '찜하기' );

create table tbl_basket (
   basket_key char(12) primary key,
   basket_cd  number not null references tbl_basket_type ( basket_cd ),
   prod_key   char(12) not null references tbl_product ( prod_key ) on delete cascade,
   user_key   char(12) not null references tbl_user ( user_key ) on delete cascade,
   basket_cnt number not null
);

-- 'bk' || lpad(seq_basket.nextval, 4, '0')
create sequence seq_basket maxvalue 9999 cycle;

create table tbl_order_history (
   imp_uid       varchar2(255) primary key,
   order_no      char(12) unique not null,
   prod_key      char(12) not null references tbl_product ( prod_key ) on delete set null,
   user_key      char(12) not null references tbl_user ( user_key ) on delete cascade,
   addr_key      char(12) not null references tbl_user_addr ( addr_key ) on delete set null,
   card_company  varchar2(50) not null,
   order_price   number,
   order_cnt     number,
   ordered_date  date default sysdate,
   refund_yn     number default 0,
   refund_reason varchar2(100) default '맛없음',
   refund_key    char(12),
   refund_date   date
);

-- 'oh' || lpad(seq_order_history.nextval, 4, '0')
create sequence seq_order_history maxvalue 9999 cycle;

-- 'rf' || lpad(seq_refund_key.nextval, 4, '0')
create sequence seq_refund_key maxvalue 9999 cycle;

commit;