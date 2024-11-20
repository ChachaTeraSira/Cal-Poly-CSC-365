-- Khushkaranpreet khgrewal@calpoly.edu
-- Q1.
select t.Last, t.First
from teachers t, list l
where t.classroom = l.classroom
group by t.Last, t.First
having count(grade) = 2 or
       count(grade) = 3
order by t.Last

-- Q2.
select grade, GROUP_CONCAT(DISTINCT classroom order by classroom SEPARATOR ', ') as AllClassrooms
from list
group by grade

-- Q3.

-- Q4.
select classroom, MIN(LastName)
from list
where grade = 1
group by classroom
order by classroom

-- Q5.
select t.First, t.Last
from teachers t, list l
where t.classroom = l.classroom
group by l.classroom
having count(l.LastName) > 5
order by t.Last