with cte1 as(
select *, ROW_NUMBER() Over(order by trade_id, trade_timestamp) rnum
from trade_tbl),

r_cte as 
(
    select trade_id, trade_timestamp, trade_stock, quantity, Price,rnum, 0 as flg
    , cast(0 as decimal) as price_diff, cast(trade_id as varchar) as lineage
    , cast(Price as varchar) trade_price
     from cte1 where rnum=1
    union ALL
    select c.trade_id, c.trade_timestamp, c.trade_stock, c.quantity, c.Price, c.rnum
    ,case when DATEDIFF(SECOND, r.Trade_Timestamp, c.Trade_Timestamp) <=10 then 0 else flg+1 end flg
    , cast(abs(r.price-c.Price)/r.Price *100 as decimal) as price_diff
    , cast(r.TRADE_ID+'.'+c.TRADE_ID as varchar) as lineage 
    , convert(varchar,concat(r.Price,'.',c.price) ) as trade_price
    from cte1 c inner join r_cte r on c.trade_stock=r.trade_stock 
    and c.rnum>r.rnum

)
select Trade1 = PARSENAME(lineage, 2) 
,Trade2 = PARSENAME(lineage, 1) 
,Trade1_price = PARSENAME(REPLACE(trade_price, ',', '.'), 2) 
,Trade2_price = PARSENAME(REPLACE(trade_price, ',', '.'), 1) 
, price_diff from r_cte where flg=0
and price_diff>10


 
