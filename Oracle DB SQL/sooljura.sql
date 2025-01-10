-- user: sooljura
-- password: 1234

drop table tbl_basket;
drop table tbl_order_history;
drop table tbl_basket_type;
drop table tbl_discount_history;
drop table tbl_discount_info;
drop table tbl_youtube;
drop table tbl_product_image;
drop table tbl_product;
drop table tbl_product_category ;
drop table tbl_chat;
drop table tbl_room;
drop table tbl_comment;
drop table tbl_post;
drop table tbl_post_type;
drop table tbl_user_addr;
drop table tbl_user;
drop table tbl_user_type;

drop sequence seq_user;             -- us
drop sequence seq_addr;             -- ad
drop sequence seq_post;             -- po
drop sequence seq_comment;          -- cm
drop sequence seq_product_category; -- c
drop sequence seq_product;          -- pr
drop sequence seq_product_image;    -- im
drop sequence seq_discount_info;    -- di
drop sequence seq_discount_history; -- dh
drop sequence seq_basket;           -- bk
drop sequence seq_order_history;    -- oh
drop sequence seq_refund_key;       -- rf
drop sequence seq_room_key;         -- ro
drop sequence seq_chat_key;         -- ch

create table tbl_user_type (
   user_cd number primary key,
   user_nm varchar2(30) not null
);

insert into tbl_user_type values ( 0, '관리자' );
insert into tbl_user_type values ( 1, '신규가입' );
insert into tbl_user_type values ( 2, '일반회원' );
insert into tbl_user_type values ( 3, '열심회원' );
insert into tbl_user_type values ( 4, '단골회원' );
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
   addr_cd     char(5) not null,
   addr        varchar2(300) not null,
   addr_detail varchar2(100),
   addr_ref    varchar2(50),
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

insert into tbl_post_type values ( 1, '공지사항' );
insert into tbl_post_type values ( 2, '자유게시판' );
insert into tbl_post_type values ( 3, '후기' );

create table tbl_post (
    post_key      char(12) primary key,
    post_cd       number not null references tbl_post_type (post_cd) on delete cascade,
    user_key      char(12) not null references tbl_user (user_key) on delete set null,
    post_content  clob not null,
    post_title    varchar2(225) not null,
    post_date     date default sysdate,
    post_view     number default 0,
    confirm_yn    number default 0,
    delete_yn     number default 0,
    delete_reason varchar2(200)
);

-- 'po' || lpad(seq_post .nextval, 4, '0')
create sequence seq_post maxvalue 9999 cycle;

create table tbl_comment (
    comment_key     char(12) primary key,
    post_key        char(12) not null references tbl_post (post_key) on delete cascade,
    user_key        char(12) not null references tbl_user (user_key) on delete set null,
    comment_content varchar2(2000) not null,
    comment_date    date default sysdate
);

-- 'cm' || lpad(seq_comment.nextval, 4, '0')
create sequence seq_comment maxvalue 9999 cycle;

create table tbl_product_category (
   category_key   char(5) primary key,
   category_level number,
   category_nm    varchar2(50),
   higher_category references tbl_product_category ( category_key )
);

-- 'c' || lpad(seq_product_category.nextval, 4, '0')
create sequence seq_product_category maxvalue 9999 cycle;

insert into tbl_product_category values ( 'c' || lpad( seq_product_category.nextval, 4, '0'), 1, '와인/샴페인', null );
insert into tbl_product_category values ( 'c' || lpad( seq_product_category.nextval, 4, '0'), 1, '위스키/리큐르', null );
insert into tbl_product_category values ( 'c' || lpad( seq_product_category.nextval, 4, '0'), 1, '브랜디/꼬냑', null );
insert into tbl_product_category values ( 'c' || lpad( seq_product_category.nextval, 4, '0'), 1, '보드카/스피릿', null );
insert into tbl_product_category values ( 'c' || lpad( seq_product_category.nextval, 4, '0'), 1, '전통주/민속주', null );
insert into tbl_product_category values ( 'c' || lpad( seq_product_category.nextval, 4, '0'), 1, '기타주류', null );

insert into tbl_product_category values ( 'c' || lpad( seq_product_category.nextval, 4, '0'), 2, '프랑스 와인', 'c0001' );
insert into tbl_product_category values ( 'c' || lpad( seq_product_category.nextval, 4, '0'), 2, '이탈리아 와인', 'c0001' );
insert into tbl_product_category values ( 'c' || lpad( seq_product_category.nextval, 4, '0'), 2, '칠레 와인', 'c0001' );
insert into tbl_product_category values ( 'c' || lpad( seq_product_category.nextval, 4, '0'), 2, '미국 와인', 'c0001' );
insert into tbl_product_category values ( 'c' || lpad( seq_product_category.nextval, 4, '0'), 2, '호주 와인', 'c0001' );

insert into tbl_product_category values ( 'c' || lpad( seq_product_category.nextval, 4, '0'), 2, '아메리칸 위스키', 'c0002' );
insert into tbl_product_category values ( 'c' || lpad( seq_product_category.nextval, 4, '0'), 2, '스카치 위스키', 'c0002' );
insert into tbl_product_category values ( 'c' || lpad( seq_product_category.nextval, 4, '0'), 2, '아이리쉬 위스키', 'c0002' );
insert into tbl_product_category values ( 'c' || lpad( seq_product_category.nextval, 4, '0'), 2, '캐나다 위스키', 'c0002' );
insert into tbl_product_category values ( 'c' || lpad( seq_product_category.nextval, 4, '0'), 2, '일본 위스키', 'c0002' );
insert into tbl_product_category values ( 'c' || lpad( seq_product_category.nextval, 4, '0'), 2, '리큐르', 'c0002' );

insert into tbl_product_category values ( 'c' || lpad( seq_product_category.nextval, 4, '0'), 2, '브랜디', 'c0003' );
insert into tbl_product_category values ( 'c' || lpad( seq_product_category.nextval, 4, '0'), 2, '꼬냑', 'c0003' );
insert into tbl_product_category values ( 'c' || lpad( seq_product_category.nextval, 4, '0'), 2, '알마냑', 'c0003' );

insert into tbl_product_category values ( 'c' || lpad( seq_product_category.nextval, 4, '0'), 2, '진', 'c0004' );
insert into tbl_product_category values ( 'c' || lpad( seq_product_category.nextval, 4, '0'), 2, '럼', 'c0004' );
insert into tbl_product_category values ( 'c' || lpad( seq_product_category.nextval, 4, '0'), 2, '보드카', 'c0004' );
insert into tbl_product_category values ( 'c' || lpad( seq_product_category.nextval, 4, '0'), 2, '테킬라', 'c0004' );

insert into tbl_product_category values ( 'c' || lpad( seq_product_category.nextval, 4, '0'), 2, '민속주', 'c0005' );
insert into tbl_product_category values ( 'c' || lpad( seq_product_category.nextval, 4, '0'), 2, '중국술', 'c0006' );
insert into tbl_product_category values ( 'c' || lpad( seq_product_category.nextval, 4, '0'), 2, '대만술', 'c0006' );

insert into tbl_product_category values ( 'c' || lpad( seq_product_category.nextval, 4, '0'), 3, '테네시 위스키', 'c0012' );

create table tbl_product (
   prod_key     char(12) primary key,
   prod_nm      varchar2(400) not null,
   prod_price   number not null,
   prod_maker   varchar2(400),
   prod_origin  varchar2(400),
   prod_intro   varchar2(4000),
   prod_cnt     number not null,
   prod_vol     varchar2(30),
   prod_proof   varchar2(30),
   trading_yn   number default 0,
   category_key char(5) references tbl_product_category ( category_key ),
   upload_date  date default sysdate
);

-- 'pr' || to_char(sysdate, 'yymmdd') || lpad(seq_product.nextval, 4, '0')
create sequence seq_product maxvalue 9999 cycle;

create table tbl_product_image (
   img_key  char(12) primary key,
   img_nm   varchar2(400),
   img_path varchar2(400),
   prod_key references tbl_product ( prod_key ) on delete cascade
);

-- 'im' || to_char(sysdate, 'yymmdd') || lpad(seq_product_image.nextval, 4, '0')
create sequence seq_product_image maxvalue 9999 cycle;

create table tbl_youtube (
   youtube_url varchar2(100) primary key,
   content     varchar2(1000) not null,
   prod_key1   char(12) not null references tbl_product ( prod_key ) on delete cascade,
   prod_key2   char(12) references tbl_product ( prod_key ) on delete set null,
   prod_key3   char(12) references tbl_product ( prod_key ) on delete set null
);

insert into tbl_youtube  values ( 'empty', 'empty', ( select prod_key from tbl_product where prod_key like '%0001'), null, null);

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

-- 'dh' || to_char(sysdate, 'yymmdd') || lpad(seq_discount_history.nextval, 4, '0')
create sequence seq_discount_history maxvalue 9999 cycle;

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

-- 'bk' || to_char(sysdate, 'yymmdd') || lpad(seq_basket.nextval, 4, '0')
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
   order_date    date default sysdate,
   refund_yn     number default 0,
   refund_reason varchar2(100) default '맛없음',
   refund_key    char(12),
   refund_date   date
);

-- 'oh' || to_char(sysdate, 'yymmdd') || lpad(seq_order_history.nextval, 4, '0')
create sequence seq_order_history maxvalue 9999 cycle;

-- 'rf' || to_char(sysdate, 'yymmdd') || lpad(seq_refund_key.nextval, 4, '0')
create sequence seq_refund_key maxvalue 9999 cycle;

create table tbl_room (
   room_key    char(12) primary key,
   room_title  varchar2(200) not null,
   user_key    char(12) references tbl_user ( user_key ) on delete set null,
   admin_key   char(12) references tbl_user ( user_key ) on delete set null,
   create_date date default sysdate,
   read_yn     number default 0
);

-- 'ro' || to_char(sysdate, 'yymmdd') || lpad(seq_room_key.nextval, 4, '0')
create sequence seq_room_key maxvalue 9999 cycle;

create table tbl_chat (
   chat_key   char(12) primary key,
   room_key   char(12) references tbl_room ( room_key ) on delete cascade,
   sender_key char(12) references tbl_user ( user_key ) on delete set null,
   msg        varchar2(1000) not null,
   sent_date  date default sysdate
);

-- 'ch' || to_char(sysdate, 'yymmdd') || lpad(seq_chat_key.nextval, 4, '0')
create sequence seq_chat_key maxvalue 9999 cycle;

commit;

-- 자동 생성된 레벨1 회원 장바구니
insert into tbl_basket values ( 'bk' || to_char( sysdate, 'yymmdd') || lpad( seq_basket.nextval, 4, '0'), 1, 
                                ( select prod_key from tbl_product where '%0001'), ( select user_key from tbl_user where '%0001'), 1 );
insert into tbl_basket values ( 'bk' || to_char( sysdate, 'yymmdd') || lpad( seq_basket.nextval, 4, '0'), 1, 
                                ( select prod_key from tbl_product where '%0002'), ( select user_key from tbl_user where '%0001'), 1 );


select * from TBL_YOUTUBE;