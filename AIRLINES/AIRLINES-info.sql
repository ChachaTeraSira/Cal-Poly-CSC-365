-- Khushkaranpreet khgrewal@calpoly.edu
-- Q1.
select DISTINCT a.Name, a.Abbr
from airlines a, flights f
where f.Source = 'APN' and
      f.Airline = a.Id
order by a.Name ASC

