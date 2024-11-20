-- Khushkaranpreet khgrewal@calpoly.edu
-- Q1.
select cm.Maker, AVG(MPG), STD(MPG)
from continents co, countries cu, carmakers cm, models mo, makes ma, cardata cd
where co.Name = 'europe' and
      co.Id = cu.Continent and
      cu.Id = cm.Country and
      cm.Id = mo.Maker and
      ma.Model = mo.Model and
      ma.Id = cd.Id and
      cd.MPG IS NOT NULL
group by cm.Maker
order by MAX(cd.MPG) ASC

-- Q2.
select cm.Maker, Count(mo.Maker) as FAST
from countries cu, carmakers cm, models mo, makes ma, cardata cd
where cu.Name = 'usa' and
      cu.Id = cm.Country and
      cm.Id = mo.Maker and
      ma.Model = mo.Model and
      ma.Id = cd.Id and
      cd.Cylinders = 4 and
      cd.Weight < 4000 and
      cd.Accelerate < 14
group by cm.Maker
order by Count(mo.Maker) DESC

-- Q3.
select cd2.Year, MAX(cd2.MPG), MIN(cd2.MPG), AVG(cd2.MPG)
from cardata cd1, makes mk1, cardata cd2, makes mk2
where mk1.Model = 'honda' and
      mk2.Model = 'toyota' and
      cd1.Id = mk1.Id and
      cd2.Id = mk2.Id and
      cd1.Year = cd2.Year
group by cd1.Year
having count(DISTINCT mk1.Id) > 2
order by cd1.Year

-- Q4.
select cd.year, count(*)
from countries cu, carmakers cm, models mo, makes ma, cardata cd
where cd.Year >= 1975 and
      cd.Year <= 1979 and
      cd.Horsepower < 150 and
      cu.Name = 'japan' and
      cu.Id = cm.Country and
      cm.Id = mo.Maker and
      ma.Model = mo.Model and
      ma.Id = cd.Id
group by cd.Year
order by cd.Year ASC