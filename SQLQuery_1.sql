with cte as(
select *, lead(productid, 1) over(partition by userid order by productid, purchasedate) lead_product,
lead(purchasedate, 1) over(partition by userid order by productid, purchasedate) lead_date
 from purchase_history)
, cte2 as(
 select case when productid=lead_product and purchasedate!=lead_date then 0 else 1 end as cnt, * from cte )

 select userid from cte2 group by userid having count(userid) = sum(cnt) and count(distinct purchasedate) >=2


