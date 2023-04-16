with cte as (
select 
dep_id, case when salary=max(salary) over(partition by dep_id ) then emp_name else null end max_sal_emp, 
case when salary=min(salary) over(partition by dep_id ) then emp_name else null end min_sal_emp
 from employee )

 select  dep_id , max(max_sal_emp) max_sal_emp, max(min_sal_emp) min_sal_emp from cte group by dep_id;


 -----------------

with cte1 as(
select *, row_number() over(partition by phone_number order by start_time) rnum_start from call_start_logs)
, cte2 as(
select *, row_number() over(partition by phone_number order by end_time) rnum_end from call_end_logs)

select a.phone_number, a.start_time, b.end_time, datediff(minute, a.start_time, b.end_time  ) duration
 from cte1 a join cte2 b on a.phone_number+cast(rnum_start as char)=b.phone_number+cast(rnum_end as char)