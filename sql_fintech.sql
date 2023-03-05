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
order by tbl1.trade_id