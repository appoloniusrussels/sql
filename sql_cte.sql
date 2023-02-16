select * from Employee;

with cte as (
    select emp_id, emp_name, reportsto  from employee where reportsto =2
    union ALL
    select e.emp_id, e.emp_name, e.reportsto from employee e join cte c on e.reportsto=c.emp_id
    where e.reportsto is not null 

)
select * from cte