-- Khushkaranpreet khgrewal@calpoly.edu
-- Q1.
select f.Source, a.Name 
from flights f, airports a
where f.Source = a.Code
GROUP BY f.Source
Having Count(f.FlightNo) = 19
order by f.Source

-- Q2.
select Count(DISTINCT f1.Source)
from flights f1, flights f2
where f2.Destination = 'LTS' and
      f1.Destination = f2.Source and
      f1.Destination != 'LTS' and
      f1.Source != 'LTS'

-- Q3.
select Count(DISTINCT f1.Source)
from flights f1, flights f2
where f1.Destination = 'LTS' or
      (
      f2.Destination = 'LTS' and
      f1.Destination = f2.Source and
      f1.Destination != 'LTS' and
      f1.Source != 'LTS'
      )

-- Q4.
select DISTINCT a.Name, count(DISTINCT f1.Source) as Airport
from airlines a, flights f1, flights f2
where a.Id = f1.Airline and
      a.Id = f2.Airline and
      f1.Source = f2.Source and
      f1.Destination != f2.Destination
group by a.Name
order by Airport DESC