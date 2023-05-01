select * from activity;

select event_date
, count(distinct user_id) active_user
from activity group by event_date;
-------------------------------------

select 
DATEPART(WEEK, event_date)  week_no
, count(distinct USER_ID) active_user
from 
activity group by  DATEPART(WEEK, event_date);

--------------------------------------

with cte as (
select *
, case when
 ((event_name='app-installed' and lead(event_name) over( partition by user_id order by event_date)='app-purchase') 
 or (event_name='app-purchase' and lead(event_name) over( partition by user_id order by event_date)='app-installed'))
 and event_date=lead(event_date) over( partition by user_id order by event_date) then 1 else 0 end flg
from activity )

select 
event_date , sum(flg) count_same_day
from cte group by event_date;

with cte as(
select 
ai.user_id, ai.event_name, ai.event_date
,ap.user_id a, ap.event_name b, ap.event_date c
from
(select * from activity where event_name='app-installed') ai  join 
(select * from activity where event_name='app-purchase') ap on ai.user_id=ap.user_id
and ai.event_date=ap.event_date
)

select event_date  , count(USER_ID)
from cte group by event_date;
---------------------------------------------------
with cte as (
select case when country in ('India','USA') then country else 'others' end country, count(distinct user_id) users
 from activity 
where event_name='app-purchase' group by case when country in ('India','USA') then country else 'others' end )
, total_user as (select sum(users) total_usr from cte)

select country , users* 1.0/total_usr *100  from cte, total_user

----------------------------------------
with cte as(
select *
, case when DATEDIFF(DAY,
lag(event_date) over(partition by user_id order by event_date),event_date )=1 then 1  else 0 end flg
from activity)

select 
event_date , sum(flg) users
from 
cte group by event_date

 


 