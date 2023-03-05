select tbl1.trade_id
, tbl2.TRADE_ID 
,tbl1.price
,tbl2.price
,abs(tbl1.price-tbl2.price)*1.0/tbl1.price*100 per_diff
from Trade_tbl tbl1 cross join Trade_tbl tbl2 
where tbl1.trade_id!=tbl2.trade_id
and tbl1.Trade_Timestamp<tbl2.Trade_Timestamp
and DATEDIFF(SECOND,tbl1.Trade_Timestamp,tbl2.Trade_Timestamp)<=10
and abs(tbl1.price-tbl2.price)*1.0/tbl1.price*100>10
order by tbl1.trade_id;


---------------------
with cte as(
select * 
,rank() over(partition by dep_id order by salary desc) rnk
, count(1) over(partition by dep_id) cnt
from emp)

select emp_id, emp_name
, dep_id, dep_name from cte

where rnk=3 or (cnt<3 and cnt=rnk)