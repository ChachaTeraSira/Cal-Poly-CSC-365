-- Khushkaranpreet khgrewal@calpoly.edu
-- Q1.
select c.Campus, AVG(e.FTE)
from fees f, campuses c, enrollments e
where f.Year >= 2000 and
      f.Year <= 2004 and
      f.CampusId = c.Id and
      f.CampusId = e.CampusId and
      f.Year = e.Year
group by c.Campus
having AVG(f.fee) > 2300
order by AVG(e.FTE) DESC

-- Q2.
select c.Campus, MIN(e.Enrolled) as MINIMUM, AVG(e.Enrolled) as AVERAGE, MAX(e.Enrolled) as MAXIMUM, STD(e.Enrolled) as STDev
from campuses c, enrollments e
where c.Id = e.CampusId
group by c.Campus
having Count(e.year) > 60
order by AVG(e.Enrolled) DESC

-- Q3.
select c.Campus, (SUM(f.fee*e.Enrolled)) as TotalRevenue
from campuses c, fees f, enrollments e
where (c.County = 'Los Angeles' or c.County = 'Orange') and
      c.Id = f.CampusId and
      c.Id = e.CampusId and
      f.Year >= 2001 and
      e.Year = f.Year
group by c.Campus
order by TotalRevenue DESC

-- Q4.
select c.Campus, Count(de.Discipline)
from campuses c, enrollments e, discEnr de
where e.FTE > 20000 and
      e.CampusId = c.Id and
      de.CampusId = e.CampusId and
      e.Year = 2004 and
      de.Year = 2004 and
      de.Gr != 0
group by c.Campus
order by c.Campus ASC