with cte as(
select 
*, ROW_NUMBER() over(order by hall_id) event_id
from 
hall_events )

,cte1 as(
    select 
    hall_id, start_date, end_date,event_id, 1 as flg
    from cte where event_id=1
    union ALL
    select 
    cte.hall_id, cte.start_date, cte.end_date,cte.event_id
    ,case when cte.hall_id=cte1.hall_id and (cte.start_date  between cte1.start_date and cte1.end_date
    or cte1.start_date  between cte.start_date and cte.end_date) then 0 else 1 end + flg as flg
    from 
    cte1 join cte on cte1.event_id+1=cte.event_id 
)

select hall_id, min(start_date), max(end_date) from cte1 
group by hall_id, flg


