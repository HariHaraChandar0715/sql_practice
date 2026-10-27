drop table deduplication.orders

create table deduplication.orders(
	id bigint,
	order_id bigint,
	amount int,
	updated_at timestamp
)
insert into deduplication.orders(id,order_id,amount,updated_at)
values
(1,1001,99,'2026/03/12 10:00:00'),(2,1002,250,' 2026/03/15 10:05:00'),
(3,1001,99,'2026/03/12 10:00:04'),(4,1002,250,'2026/03/15 10:05:00'),
(5,1001,109,'2026/03/12 10:20:00')

insert into deduplication.orders(id,order_id,amount,updated_at)
values (6,1001,270,'2026/03/12 10:00:00');

select * from deduplication.orders;

with cte_deduplication as (
	select
		*,
		row_number() over(partition by order_id order by updated_at desc) as rnk
	from deduplication.orders
)
select * from cte_deduplication where rnk=1;

select distinct * from deduplication.orders;

/*
  DISTINCT
    Using distinct will fail to identify and remove duplicates because
	distinct takes the combination of all cloumns to identify the duplicates
	so even if there is any duplicated records present it will fail to remove it.

  ROW_NUMBER
    using window function like ROW_NUKBER() will help us to identify the
	duplicates based on the business logic of which it uniquely identifes 
	the record by partitioning it through the order_id and ordering it
	by the updated_at timestamp column in descending order.

*/