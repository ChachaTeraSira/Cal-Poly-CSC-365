-- Khushkaranpreet khgrewal@calpoly.edu
-- Q1.
select f.Source, a.Name 
from flights f, airports a
where f.Source = a.Code
GROUP BY f.Source
Having Count(f.FlightNo) = 19
order by f.Source