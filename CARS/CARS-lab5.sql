-- Khushkaranpreet khgrewal@calpoly.edu
-- Q1.
select mk2.Make, cd2.Year, cm.Maker
from cardata cd1, cardata cd2, makes mk1, makes mk2, models md, carmakers cm
where mk1.Make = 'honda civic' and
      mk1.Id = cd1.Id and
      cd1.Year = 1982 and
      cd2.Year > 1980 and
      cd2.MPG > cd1.MPG and 
      cd2.Id = mk2.Id and
      mk2.Model = md.Model and
      md.Maker = cm.Id
order by cd2.MPG DESC

-- Q2.
select Avg(cd.Horsepower) as AVERAGE, Max(cd.Horsepower) as MAXIMUM, Min(cd.Horsepower) as MINIMUM
from countries c, carmakers cm, models md, makes mk, cardata cd
where c.Name = 'france' and
      c.Id = cm.Country and
      cm.Id = md.Maker and
      md.Model = mk.Model and
      mk.Id = cd.Id and
      cd.Cylinders = 4 and
      cd.Year >= 1971 and cd.Year <= 1976

-- Q3. ===========everything looks good, but answer doesn't match

-- Q4.
select count(Weight)
from cardata cd, carmakers cm, models md, makes mk
where cd.Weight >= 5000 and
      cd.Id = mk.Id and
      mk.Model = md.Model and
      md.Maker = cm.Id