select * from Ameriprise_LLC;

with cte as(
select teamID
, case when sum(case when (upper(Criteria1)='Y') and (Upper(Criteria2)='Y') then 1 else 0 end) >=2 then 'Y' else 'N' end
final_output
from 
Ameriprise_LLC group by teamID)

select a.*
, case when (upper(Criteria1)='Y') and (Upper(Criteria2)='Y') then isnull(b.final_output,'N') else 'N' end
from Ameriprise_LLC a left join cte b on a.teamID=b.teamID
and b.final_output='Y'