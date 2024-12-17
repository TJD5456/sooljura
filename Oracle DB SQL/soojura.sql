-- user: sooljura
-- password: 1234

drop table tbl_product;
drop table tbl_product_image;

drop sequence seq_product;
drop sequence seq_product_image;

create table
  tbl_product (
    prod_key char(11) primary key,
    prod_name varchar2 (100) not null,
    prod_price number not null,
    prod_maker varchar2 (100) not null,
    prod_origin varchar2 (100) not null,
    prod_intro varchar2 (4000) not null,
    prod_cnt number not null,
    upload_date date default sysdate
  );

-- 'p' || to_char(sysdate, 'yymmdd') || lpad (seq_product.nextval, 4, '0')
create sequence seq_product maxvalue 9999 cycle;

create table
  tbl_product_image (
    img_key char(11),
    img_nm varchar2 (100),
    img_path varchar2 (100),
    prod_key references tbl_product(prod_key)
  );

-- 'i' || to_char(sysdate, 'yymmdd') || lpad (seq_prod_image.nextval, 4, '0')
create sequence seq_product_image maxvalue 9999 cycle;

commit;
