select * from flights a left join flights b on a.origin=b.origin left join flights c on b.destination=c.origin;
select * from flights a left join flights b on a.destination=b.origin
select * from flights