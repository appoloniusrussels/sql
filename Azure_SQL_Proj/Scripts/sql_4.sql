select * from emp;
with cte as (
select *, rank() over(partition by dep_id order by salary desc) rnk 
, count(emp_id) over(partition by dep_id ) dep_cnt
from emp) 

select * from cte 
where rnk=3 or (rnk<3 and dep_cnt=rnk)