create schema deduplication;
drop table deduplication.orders
create table deduplication.orders(
	id bigint,
	order_id bigint,
	amount int,
	updated_at timestamp
)
insert into deduplication.orders(id,order_id,amount,updated_at)
values
(1,1001,99,'2026/03/12 10:00:00'),(2,1002,250,' 2026/03/15 10:05:00'),(3,1001,99,'2026/03/12 10:00:04'),
(4,1002,250,'2026/03/15 10:05:00'),(5,1001,109,'2026/03/12 10:20:00')

insert into deduplication.orders(id,order_id,amount,updated_at)
values (6,1001,270,'2026/03/12 10:00:00');

select * from deduplication.orders;

with cte_deduplication as (
	select
		*,
		row_number() over(partition by order_id order by updated_at desc) as rnk
	from deduplication.orders
)