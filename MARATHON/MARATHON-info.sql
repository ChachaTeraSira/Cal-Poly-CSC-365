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

-- Q4.
select DISTINCT m1.BibNumber
from marathon m1, marathon m2
where m1.BibNumber = m2.BibNumber and
      m1.Place != m2.Place
order by m1.BibNumber

-- Q5.
select DISTINCT m1.Sex, m1.AgeGroup, m1.FirstName, m1.LastName, m1.Age, m2.FirstName, m2.LastName, m2.Age
from marathon m1, marathon m2
where (m1.GroupPlace = 1 and m2.GroupPlace = 2) and 
      m1.AgeGroup = m2.AgeGroup and
      m1.Sex = m2.Sex
order by m1.Sex, m1.AgeGroup