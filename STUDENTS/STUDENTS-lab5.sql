-- Khushkaranpreet khgrewal@calpoly.edu
-- Q1.
select DISTINCT l1.FirstName, l1.LastName, l1.grade, l2.FirstName, l2.LastName, l2.grade 
from list l1, list l2
where l1.FirstName = l2.FirstName and
      l1.LastName != l2.LastName and
      l1.LastName < l2.LastName

-- Q2.
select l.FirstName, l.LastName
from list l, teachers t
where l.grade = 4 and
      l.classroom = t.classroom and
      (t.First != 'GORDON' and t.Last != 'KAWA')
order by l.LastName

-- Q3.
select Count(grade)
from list
where grade = 1 or grade = 2

-- Q4.
select Count(l2.classroom)
from list l1, list l2
where l1.FirstName = 'ELTON' and l1.LastName = 'FULVIO' and
      l1.FirstName != l2.FirstName and l1.lastName != l2.lastName and
      l1.classroom = l2.classroom