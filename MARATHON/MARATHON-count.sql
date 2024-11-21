-- Khushkaranpreet khgrewal@calpoly.edu
-- Q1.
select AgeGroup, Sex, Count(*), MIN(Place) as BEST_PLACE, MAX(Place) as WORST_PLACE
from marathon
group by AgeGroup, Sex
order by AgeGroup, Sex

-- Q2.
select Count(*)
from marathon m1, marathon m2
where m1.State = m2.State and
      m1.AgeGroup = m2.AgeGroup and
      m1.Sex = m2.Sex and
      m1.GroupPlace = 1 and
      m2.GroupPlace = 2

-- Q3.
select TIME_FORMAT(Pace, '%i') as time, count(*) as total
from marathon
group by TIME_FORMAT(Pace, '%i')

-- Q4.
select State, Count(*) as n_top10
from marathon
where GroupPlace < 11
group by State
order by n_top10 DESC