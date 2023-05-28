WITH  Trips  AS (
  -- Anchor member: Direct flights
  SELECT flights.origin, flights.destination, flights.cost total_cost, 0 AS stops
  FROM flights
  
  UNION ALL
  
  -- Recursive member: One-stop flights
  SELECT t1.origin, flights.destination, t1.total_cost + flights.cost total_cost, t1.stops + 1
  FROM Trips t1
  JOIN flights ON t1.destination = flights.origin
  
  WHERE t1.stops < 2 -- Limit to two stops
)
-- Final query to retrieve the cheapest trips
SELECT origin, destination, total_cost
FROM Trips
WHERE stops <= 2 -- Include two or fewer stops
--GROUP BY origin, destination --,total_cost
--HAVING total_cost = MIN(total_cost)  -- Filter out higher-cost trips for each origin-destination pair
ORDER BY origin, destination;

select * from flights;