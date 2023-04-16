with cte as(
select 
dep_id
,case when salary=max(salary) over(partition by dep_id order by salary desc) then emp_name  end emp_max_sal
,case when salary=min(salary) over(partition by dep_id order by salary )  then emp_name  end emp_mix_sal

from employees
group by dep_id,emp_name,salary)

select dep_id, max(emp_max_sal), max(emp_mix_sal) from cte group by dep_id

select * from Employees