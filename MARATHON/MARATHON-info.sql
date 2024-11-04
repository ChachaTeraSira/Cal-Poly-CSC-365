-- Khushkaranpreet khgrewal@calpoly.edu
-- Q1.
select Place, Runtime, FirstName, LastName, TIME_FORMAT(Pace, "%i:%s") as Pace
from marathon
where Town = 'LITTLE FERRY' and State = 'NJ'
order by Runtime

-- Q2.
select DISTINCT FirstName, LastName, Place, Runtime, GroupPlace
from marathon
where Town = 'QUNICY' and
      State = 'MA' and
      Sex = 'F'
order by Place

-- Q3.
select DISTINCT FirstName, LastName, Town, Place, GroupPlace, Runtime
from marathon
where State = 'RI' and
      Sex = 'F' and
      Age = 27
order by Runtime

-- DOESNT WORK Q4.
select *
from marathon m1, marathon m2
where m1.BibNumber = m2.BibNumber
order by m1.BibNumber

-- DOESNT WORK Q5.
select DISTINCT *
from marathon m1, marathon m2
where (m1.GroupPlace = 1 or m2.GroupPlace = 2) and 
      m1.GroupPlace = m2.GroupPlace and
      m1.FirstName = m2.FirstName
order by m1.Sex, m1.AgeGroup