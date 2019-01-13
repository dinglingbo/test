

SELECT * from c_wz


SELECT * from b_benz



update c_wz set oem_code = replace(oem_code, ' ', ''), code = replace(code, ' ', '')


update b_benz set CODE = CONCAT('A',CODE)


SELECT a.code, a.carplate, a.brand, a.brand_id, b.id, b.name from a_bmw a
inner join com_part_brand b
on a.brand = b.name

update a_bmw a
inner join com_part_brand b
on a.brand = b.name
set a.brand_id = b.id


SELECT a.code, a.carplate, a.brand, a.brand_id, b.id, b.name from b_benz a
inner join com_part_brand b
on a.brand = b.name

update b_benz a
inner join com_part_brand b
on a.brand = b.name
set a.brand_id = b.id

SELECT a.code, a.carplate, a.brand, a.brand_id, b.id, b.name from c_wz a
inner join com_part_brand b
on a.brand = b.name

update c_wz a
inner join com_part_brand b
on a.brand = b.name
set a.brand_id = b.id

SELECT DISTINCT brand from a_bmw where brand_id is null
union
SELECT DISTINCT brand from b_benz where brand_id is null
union
SELECT DISTINCT brand from c_wz where brand_id is null

/*
ELRING
品牌
拆车
改
下线
CORTECO
BS
仿
BEHR
副厂
猫
ZF
BG
博格
品牌带标
国外翻新
迈乐
威巴克
ZKW
防
贝洱海拉
标士顿
ACM
BILSTEIN
SWAG
Z
MOB
斯泰必鲁

*/

update a_bmw set brand = '其他', brand_id = 240 where brand_id is null

update b_benz set brand = '其他', brand_id = 240 where brand_id is null

update c_wz set brand = '其他', brand_id = 240 where brand_id is null

SELECT * from a_bmw a
where not exists(
	SELECT 1 from st_part b where a.code = b.code
)


SELECT a.*, b.name, b.fullname from a_bmw a
inner join st_part b
on a.code = b.code


update c_wz a
inner join st_part b
on a.code = b.code
set a.std_name = b.name, a.full_name = b.fullname


SELECT * from com_part_brand  /*查询品牌为其他的品牌*/

/*更新名称ID*/

select a.*, b.*
from a_bmw a
inner join com_part_name b
on a.std_name = b.name

update a_bmw a
inner join com_part_name b
on a.std_name = b.name
set a.std_name_id = b.id

update b_benz a
inner join com_part_name b
on a.std_name = b.name
set a.std_name_id = b.id

update c_wz a
inner join com_part_name b
on a.std_name = b.name
set a.std_name_id = b.id




DELETE a from a_bmw a
inner join com_attribute b
on a.code = b.code and a.brand_id = b.part_brand_id


DELETE a from b_benz a
inner join com_attribute b
on a.code = b.code and a.brand_id = b.part_brand_id


insert into c_wz_copy
SELECT a.* from c_wz a
inner join com_attribute b
on a.code = b.code and a.brand_id = b.part_brand_id

DELETE from c_wz where code = '117218' and brand = '法雷奥';
DELETE from c_wz where code = '95811014700' and brand = '原厂';
DELETE from c_wz where code = '00004330136' and brand = '原厂';
DELETE from c_wz where code = '00004330147' and brand = '原厂';
DELETE from c_wz where code = '31372212' and brand = '原厂';
DELETE from c_wz where code = '31372212' and brand = '原厂';
DELETE from c_wz where code = '51717199752' and brand = '原厂';
DELETE from c_wz where code = '95811024700' and brand = '原厂';
DELETE from c_wz where code = '95811090101' and brand = '原厂';
DELETE from c_wz where code = '95860640501' and brand = '原厂';
DELETE from c_wz where code = '980156013' and brand = '原厂';
DELETE from c_wz where code = '00004320689' and brand = '原厂';
DELETE from c_wz where code = '311401' and brand = '原厂';
DELETE from c_wz where code = '311401' and brand = '原厂';
DELETE from c_wz where code = '95810722200' and brand = '原厂';
DELETE from c_wz where code = '94610732275' and brand = '原厂';
DELETE from c_wz where code = '95811012801' and brand = '原厂';
DELETE from c_wz where code = '64119266899' and brand = '原厂';
DELETE from c_wz where code = '670005173' and brand = '原厂';
DELETE from c_wz where code = '119502' and brand = '法雷奥';

insert into 20190113part
SELECT * from c_wz


SELECT code, brand_id, brand, max(id), count(1) from 20190113part
group by code, brand_id, brand
having count(1) >= 1

/*删除编码和品牌重复的信息*/


DELETE
FROM
   20190113part
WHERE
 id NOT IN (
    SELECT  max(id) as id from 20190113part
		group by code, brand_id
)


SELECT count(1)
FROM
   aa_part as m
WHERE m.id NOT IN (
    SELECT  max(n.id) 
    from aa_part as n
		group by n.code, n.brand_id
)


SELECT *
from aa_part a
inner join 
(
    SELECT  id = max(n.id) 
    from aa_part as n
		group by n.code, n.brand_id
) b
on a.id = b.id

CREATE TABLE tmp_table (
      id int not null PRIMARY key
 );

insert into tmp_table(id)
SELECT  max(id) 
from aa_part as n
group by n.code, n.brand_id;


SELECT count(1)
FROM aa_part as m
WHERE 1 = 1 and not  exists ( SELECT  1 from tmp_table n where m.id = n.id);


drop TABLE tmp_table

DELETE m
FROM aa_part as m
WHERE 1 = 1 and not  exists ( SELECT  1 from tmp_table n where m.id = n.id);



SELECT * FROM 
aa_part m
inner join tmp_table n
on m.id = n.id


SELECT * from aa_part a 
inner join com_attribute b
on a.code = b.code and a.brand_id = b.part_brand_id

SELECT * from aa_part where ifnull(std_name, '') = ''

update aa_part set remark = name 

update aa_part set std_name = name, full_name = name where ifnull(std_name, '') = ''

alter table aa_part add car_type_id_f int;
alter table aa_part add car_type_id_s int;
alter table aa_part add car_type_id_t int;

SELECT *
from aa_part a
inner join com_part_name b
on a.std_name_id = b.id

update aa_part a
inner join com_part_name b
on a.std_name_id = b.id
set a.car_type_id_f = b.cartypef, a.car_type_id_s = b.cartypes, a.car_type_id_t = b.cartypet


SELECT * from aa_part

SELECT * from com_car_brand where car_brand_zh = '所有'

INSERT into com_attribute(id, orgid, code, name, full_name, brand_code, oem_code, 
query_code, part_name_id, part_brand_id, apply_carbrand_id,
apply_car_model, car_type_id_f, car_type_id_s, car_type_id_t, remark, recorder, record_date, modifier, modify_date)
SELECT @rownum:=@rownum+1, 0, a.code, a.std_name, a.full_name, a.code, a.code, a.code,
       a.std_name_id, a.brand_id, case when a.carplate = '奔驰' then 'b022' when a.carplate = '宝马' then 'b023' else 'b00' end,
       a.carmodel, a.car_type_id_f, a.car_type_id_s, car_type_id_t, a.remark, '系统管理员', SYSDATE(), '系统管理员', SYSDATE()
from aa_part a inner join (select @rownum:=115109) b
on 1 = 1

SELECT max(id) from com_attribute

/*拼音同意更新*/

SELECT F_GETPY(REPLACE(full_name,' ','')), name_py from com_attribute limit 100

update com_attribute set name_py = F_GETPY(REPLACE(full_name,' ','')) where ifnull(name_py,'') = ''
