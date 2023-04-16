select * from airbnb_searches;

select 
value, count(1)

from airbnb_searches CROSS APPLY STRING_SPLIT(filter_room_types, ',')
group by value order by 2 desc