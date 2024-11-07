-- Khushkaranpreet khgrewal@calpoly.edu
-- Q1.
select AVG(d.degrees) as Avg_degree
from campuses c, degrees d
where c.Campus = 'California Polytechnic State University-San Luis Obispo' and
      c.Id = d.CampusId and
      d.year >= 1995 and d.year <= 2000

-- Q2.
select MIN(f.fee) as Smallest_fee, AVG(f.fee) as Avg_fee, MAX(f.fee) as Largest_fee
from fees f
where f.Year = 2002

-- Q3.
select Avg(e.FTE/f.FTE) as Avg_RATIO
from enrollments e, faculty f
where e.Year = 2004 and
      f.Year = e.Year and
      e.FTE > 15000 and
      e.CampusId = f.CampusId

-- Q4.
select e.Year
from campuses c, enrollments e
where (c.Campus = 'California Polytechnic State University-San Luis Obispo' and
      c.Id = e.CampusId and
      e.Enrolled > 17000)
UNION
select d.year
from campuses c, degrees d
where (c.Campus = 'California Polytechnic State University-San Luis Obispo' and
      c.Id = d.CampusId and
      d.degrees > 3500)
order by year

-- Q5.
select e.Year
from campuses c, enrollments e
where c.Campus = 'California Polytechnic State University-San Luis Obispo' and
      c.Id = e.CampusId and
      e.FTE > 15000
EXCEPT
select d.Year
from campuses c, degrees d
where c.Campus = 'San Jose State University' and
      c.Id = d.CampusId and
      d.degrees < 4000
order by year