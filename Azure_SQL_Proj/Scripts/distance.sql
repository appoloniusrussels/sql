with cte as (
select
	*,
	row_number() over(
order by
	(
	select
		null)) cnt ,
	greatest ("source",
	destination) source1 ,
	least ("source",
	destination) destination1
from
	city_distance)

,
cte2 as(
select
	*,
	row_number () over(partition by source1,
	destination1,
	distance
order by
	cnt) rn
from
	cte
order by
	cnt)

select
	distance,
	source,
	destination
from
	cte2
where
	rn = 1