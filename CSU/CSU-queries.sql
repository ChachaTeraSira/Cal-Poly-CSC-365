-- Khushkaranpreet khgrewal@calpoly.edu
-- Q1.
select c1.Campus, c1.County, SUM(d1.degrees) as total
from campuses c1, degrees d1
where d1.Year between 1990 and 2004 and
      d1.CampusId = c1.Id
group by c1.Campus, c1.County
having SUM(d1.degrees) = (
                select MAX(max_degree)
                from (
                    select SUM(d.degrees) as max_degree
                    from degrees d, campuses c2
                    where d.CampusId = c2.Id and
                          (d.Year between 1990 and 2004)
                    group by c2.Id
                    ) dc
                )

-- Q2.
select (max_table.max_d/min_table.min_d) as RATIO
from    
    (select MAX(tot_degrees) as max_d
    from (
        select SUM(d.degrees) as tot_degrees
        from campuses c, degrees d
        where c.Id = d.CampusId and
              d.Year BETWEEN 1990 and 2004
        group by c.Id
        ) counter
    ) max_table,
    (select MIN(tot_degrees) as min_d
    from (
        select SUM(d.degrees) as tot_degrees
        from campuses c, degrees d
        where c.Id = d.CampusId and
              d.Year BETWEEN 1990 and 2004
        group by c.Id
        ) counter
    ) min_table

-- Q3.
select c1.Campus, subquery.Year, subquery.ratio
from campuses c1, 
    (select e1.CampusId, e1.Year, (e1.FTE / f1.FTE) as ratio
    from enrollments e1, faculty f1
    where e1.CampusId = f1.CampusId and 
          e1.Year = f1.Year
    ) subquery
where c1.Id = subquery.CampusId and
      subquery.ratio =  (select MIN(e2.FTE / f2.FTE)
                        from enrollments e2, faculty f2
                        where e2.CampusId = subquery.CampusId and
                              e2.CampusId = f2.CampusId and
                              e2.Year = f2.Year
      )
order by subquery.ratio ASC;

-- Q4.
WITH CampusMinRatios as (
    select e.CampusId, MIN(e.FTE / f.FTE) as min_ratio
    from enrollments e
    INNER JOIN faculty f on e.CampusId = f.CampusId and e.Year = f.Year
    group by e.CampusId
),
BestYearPerCampus as (
    select e.CampusId, e.Year, (e.FTE / f.FTE) as ratio
    from enrollments e
    INNER JOIN faculty f on e.CampusId = f.CampusId and e.Year = f.Year
    INNER JOIN CampusMinRatios cmr on e.CampusId = cmr.CampusId and (e.FTE / f.FTE) = cmr.min_ratio
),
YearCounts as (
    select b.Year, COUNT(*) as num_campuses
    from BestYearPerCampus b
    group by b.Year
),
MaxYear as (
    select yc.Year, yc.num_campuses
    from YearCounts yc
    where yc.num_campuses = (select MAX(num_campuses) from YearCounts)
),
TotalCampuses as (
    select COUNT(DISTINCT Id) as total_campuses from campuses
)
select m.Year, (m.num_campuses / t.total_campuses) * 100 as percent
from MaxYear m
JOIN TotalCampuses t;

-- Q5.
select c.Campus, AVG(f.FTE) as avg_faculty
from campuses c, faculty f,
    (select de.CampusId
    from disciplines d, discEnr de
    where d.Id = de.Discipline and
          de.Year = 2004
    group by de.CampusId
    EXCEPT
    select de.CampusId
    from disciplines d, discEnr de
    where d.Id = de.Discipline and
          d.Name = 'Engineering' and
          de.Year = 2004
    group by de.CampusId
    ) non_engr
where non_engr.CampusId = c.Id and
      c.Id = f.CampusId and
      f.Year between 2002 and 2004 
group by c.Id
order by avg_faculty DESC

-- Q6.
select campus,
    (case when year <= 1955 then 'existed'
         else 'did not exist'
    end) status
from campuses
order by campus