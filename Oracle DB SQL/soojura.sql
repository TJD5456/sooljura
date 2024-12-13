-- user: sooljura
-- password: 1234

-- 코드 관리 예시
create table
    tbl_code_2 (
        group_cd varchar2 (10), -- 대분류 코드
        group_cd_nm varchar2 (100), -- 대분류 코드명
        src_cd varchar2 (10), -- 중분류 코드
        src_cd_nm varchar2 (100), -- 중분류 코드명
        tar_cd varchar2 (10), -- 소분류 코드
        tar_cd_nm varchar2 (100) -- 소분류 코드명
    );

insert into tbl_code_2 values ('A0001', '제품관리', 'B1', '주종관리', '1', '위스키');
insert into tbl_code_2 values ('A0001', '제품관리', 'B1', '주종관리', '2', '소주');
insert into tbl_code_2 values ('A0001', '제품관리', 'B1', '주종관리', '3', '증류주');
insert into tbl_code_2 values ('A0001', '제품관리', 'B1', '주종관리', '4', '맥주');

insert into tbl_code_2 values ('A0001', '제품관리', 'B2', '제조사관리', '1', '삼성');
insert into tbl_code_2 values ('A0001', '제품관리', 'B2', '제조사관리', '2', '엘지');
insert into tbl_code_2 values ('A0001', '제품관리', 'B2', '제조사관리', '3', '카카오');
insert into tbl_code_2 values ('A0001', '제품관리', 'B2', '제조사관리', '4', '네이버');

insert into tbl_code_2 values ('B0001', '게시글관리', 'A1', '글종류', '1', '공지사항');
insert into tbl_code_2 values ('B0001', '게시글관리', 'A1', '글종류', '2', 'FAQ');
insert into tbl_code_2 values ('B0001', '게시글관리', 'A1', '글종류', '3', '자유게시판');
insert into tbl_code_2 values ('B0001', '게시글관리', 'A1', '글종류', '4', '질문게시판');

commit;

select * from tbl_code_2
order by group_cd, src_cd, tar_cd;
