with cte as(
select 
section, number, row_number() over(partition by section order by number desc) num
from 
section_data )
, cte2 as(
select section, number, sum(number) over(partition by section) sum
,max(number) over(partition by section)  max_num
from cte
where num in (1,2)
)
, cte3 as(
select 
*,dense_rank() over( order by sum desc, max_num desc) rnk 
from cte2 )

select * from cte3 where rnk<=2


