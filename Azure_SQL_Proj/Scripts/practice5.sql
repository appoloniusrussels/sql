--average salary lower than overall avg. sal 
--exclude the avg sal of dep. you are comaring with 
with cte as(
select department_id, avg(salary) avg_sal_dep 
,sum(salary) dep_sum
,count(*) emp_count
from emp group by department_id)
select * from (
select e.department_id, e.avg_sal_dep, sum(c.dep_sum)  / sum(c.emp_count) emp_sal_avg
,sum(c.dep_sum) sal_sum  , sum(c.emp_count) emp_count
 from cte e join cte c on e.department_id!=c.department_id
 group by e.department_id, e.avg_sal_dep) a 
 where a.avg_sal_dep<a.emp_sal_avg

