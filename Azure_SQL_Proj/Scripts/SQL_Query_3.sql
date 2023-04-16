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


-----------------

with cte1 as (
select user_id, created_at
,case when min(created_at) over(partition by user_id order by created_at) = created_at then 1 else 0 end initial_flg
, product_id from marketing_campaign
where user_id in (11,14,25, 19)
group by user_id,product_id,created_at
)
 ,cte2 as(
select * from cte1 where initial_flg=1)

select * from cte1 left join cte2 on cte1.user_id=cte2.user_id and cte1.product_id=cte2.product_id
where cte1.initial_flg=0 and cte2.user_id is null
group by cte1.user_id
;


select user_id, count(1) from marketing_campaign
group by user_id
having count(distinct created_at) =1


