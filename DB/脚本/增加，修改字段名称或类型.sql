--查询包含某字段（COMPCODE）的所有表
select table_name, owner  from DBA_TAB_COLUMNS 
where COLUMN_NAME='COMPCODE' and INSTR(table_name, '$')=0

select table_name, owner  from DBA_TAB_COLUMNS 
where COLUMN_NAME='COMP_CODE' and INSTR(table_name, '$')=0

--字段修改
alter table 表名 rename column 现列名 to 新列名;
alter table tb modify (name nvarchar2(20));
--名称修改
select 'alter table ' || owner || '.' || table_name || ' rename column COMPCODE to ORGCODE;'   
from DBA_TAB_COLUMNS 
where COLUMN_NAME='COMPCODE' and INSTR(table_name, '$')=0
--类型修改
select 'alter table ' || owner || '.' || table_name || ' MODIFY (ORGCODE VARCHAR2(32));'   
from DBA_TAB_COLUMNS 
where COLUMN_NAME='COMPCODE' and INSTR(table_name, '$')=0

--增加字段
select 'alter table ' || owner || '.' || table_name || ' add(ORGID NUMBER(10) not null);'   
from DBA_TAB_COLUMNS 
where COLUMN_NAME='COMPCODE' and INSTR(table_name, '$')=0

增加字段语法：alter table tablename add (column datatype  [null/not null],….);

说明：alter table 表名 add (字段名 字段类型 默认值 是否为空);



