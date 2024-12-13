-- user: sooljura
-- password: 1234

drop table tbl_product;

drop sequence seq_dinner;

create table tbl_product
(

);

-- 'p' || to_char(sysdate, 'yymmdd') || lpad (seq_dinner.nextval, 4, '0')
create sequence seq_product maxvalue 9999 cycle;

commit;
