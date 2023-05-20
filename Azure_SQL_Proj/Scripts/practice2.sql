with cte1 as (
select *, ROW_NUMBER() over(order by (select null)) rn
from brands)
, cte2 as (
select *, lead(rn,1,99) over(order by rn) end_rnge from cte1 where category is not null)

select case when  ct1.category is null then ct2.category else ct1.category end category
, ct1.brand_name

 from cte1 ct1 left join  cte2 ct2 on ct1.rn>=ct2.rn and ct1.rn<=ct2.end_rnge-1