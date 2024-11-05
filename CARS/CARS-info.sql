-- Khushkaranpreet khgrewal@calpoly.edu
-- Q1.
select DISTINCT m.Make, cd.Year
from models mo, cardata cd, makes m, carmakers cm
where m.Model = 'pontiac' and
      cd.Year < 1977 and
      cd.Id = m.Id and
      m.Model = mo.Model and
      mo.Maker = cm.Id
order by cd.Year

-- Q2.
select DISTINCT m.Make, cd.Year
from carmakers cm, cardata cd, makes m, models mo
where (cd.Year = 1976 or cd.Year = 1977) and
      cm.Maker = 'chrysler' and
      cd.Id = m.Id and
      m.Model = mo.Model and
      mo.Maker = cm.Id
order by cd.Year, m.Make ASC

-- Q3.
select cm.FullName, c.Name
from countries c, carmakers cm
where (c.Name = 'france' or c.Name = 'sweden') and
      c.Id = cm.Country
order by c.Name, cm.Fullname

-- Q4.
select cm.Maker, m.Make 
from cardata cd, models mo, carmakers cm, makes m
where cd.Cylinders != 4 and
      cd.Year = 1979 and
      cd.MPG > 20 and
      Accelerate < 18 and
      cd.Id = m.Id and
      m.Model = mo.Model and
      mo.Maker = cm.Id
order by cd.MPG DESC

-- Q5.
select DISTINCT cm.FullName, c.Name
from countries c, cardata cd, carmakers cm, makes m, models mo
where c.Name = 'usa' and
      cd.weight < 2000 and
      cd.Year >= 1977 and cd.Year <= 1979 and
      c.Id = cm.Country and
      cd.Id = m.Id and
      m.Model = mo.Model and
      mo.Maker = cm.Id
order by cm.FullName

-- Q6.
select m.make, cd.Year, (cd.weight / cd.HorsePower) as RATIO
from carmakers cm, cardata cd, makes m, models mo
where cm.maker = 'volvo' and
      cd.Year > 1971 and
      cm.Id = mo.Maker and
      mo.Model = m.Model and
      cd.Id = m.Id
order by RATIO DESC