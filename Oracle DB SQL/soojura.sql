-- user: sooljura
-- password: 1234

drop table tbl_product_category;
drop table tbl_product cascade constraint;
drop table tbl_product_image;

drop sequence seq_product_category;
drop sequence seq_product;
drop sequence seq_product_image;


create table
  tbl_product_category (
    category_cd char(11) primary key,
    category_level number,
    category_nm varchar2 (50),
    higher_category references tbl_product_category (category_cd)
  );

-- 'c' || lpad (seq_product_category.nextval, 4, '0')
create sequence seq_product_category maxvalue 9999 cycle;

insert into tbl_product_category values ( 'c' || lpad (seq_product_category.nextval, 4, '0'), 1, '증류주/소주', null);
insert into tbl_product_category values ( 'c' || lpad (seq_product_category.nextval, 4, '0'), 1, '맥주', null);
insert into tbl_product_category values ( 'c' || lpad (seq_product_category.nextval, 4, '0'), 1, '전통주', null);
insert into tbl_product_category values ( 'c' || lpad (seq_product_category.nextval, 4, '0'), 1, '와인/샴페인', null);
insert into tbl_product_category values ( 'c' || lpad (seq_product_category.nextval, 4, '0'), 1, '위스키/리큐르', null);
insert into tbl_product_category values ( 'c' || lpad (seq_product_category.nextval, 4, '0'), 1, '기타', null);

create table
  tbl_product (
    prod_key char(11) primary key,
    prod_name varchar2 (100) not null,
    prod_price number not null,
    prod_maker varchar2 (100) not null,
    prod_origin varchar2 (100) not null,
    prod_intro varchar2 (4000) not null,
    prod_cnt number not null,
    upload_date date default sysdate,
    category_level number
  );

  select * from TBL_PRODUCT;

-- 'p' || to_char(sysdate, 'yymmdd') || lpad (seq_product.nextval, 4, '0')
create sequence seq_product maxvalue 9999 cycle;

create table
  tbl_product_image (
    img_key char(11) primary key,
    img_nm varchar2 (100),
    img_path varchar2 (100),
    prod_key references tbl_product (prod_key)
  );

-- 'i' || to_char(sysdate, 'yymmdd') || lpad (seq_prod_image.nextval, 4, '0')
create sequence seq_product_image maxvalue 9999 cycle;

commit;
