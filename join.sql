create schema practice;
create table practice.tb1(
	id int
)

create table practice.tb2(
	id int
)

insert into practice.tb1(id)
values
(1),(1),(0),(0),(0),(null),(null),(1);

insert into practice.tb2(id)
values
(1),(1),(0),(0),(null),(1),(0),(null)

select * from practice.tb1;
select * from practice.tb2;

select tbl1.id as table_1, tbl2.id as table_2
from practice.tb1 tbl1
join practice.tb2 tbl2
on tbl1.id = tbl2.id;

select tbl1.id as table_1, tbl2.id as table_2
from practice.tb1 tbl1
left join practice.tb2 tbl2
on tbl1.id = tbl2.id;