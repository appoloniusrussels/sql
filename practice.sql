

with cte as (
select 
hall_id, start_date, end_date
from 
hall_events 

union ALL
select 
h.hall_id, h.start_date, h.end_date
from 
hall_events h join cte on cte.hall_id=h.hall_id
and h.start_date BETWEEN cte.start_date and cte.end_date
)

