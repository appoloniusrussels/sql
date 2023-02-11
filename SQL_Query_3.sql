with cte as(
select *, rank() over(partition by user_id order by created_at asc)  as rn
from marketing_campaign --where USER_ID in (25,11)
)
, cte2 as 
(select * from cte where rn =1)
, cte3 as 
(select * from cte where rn>1)

select distinct
a.user_id--, a.product_id, a.created_at, b.user_id, b.product_id, b.created_at
from cte3 a left join cte2 b on a.user_id=b.user_id
and a.product_id=b.product_id 
where  b.product_id is null