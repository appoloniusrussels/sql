with cte1 as 
(select *, ROW_NUMBER() over(partition by type order by type) rnum from family
where type='Adult'),
cte2 as
(select *, ROW_NUMBER() over(partition by type order by type) rnum from family
where type='child')

select a.person, b.person
from cte1 a  left join  cte2 b on a.rnum=b.rnum

