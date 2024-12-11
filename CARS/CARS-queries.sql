-- Khushkaranpreet khgrewal@calpoly.edu
-- Q1.
select ma.Make, cd.Year, cd.Horsepower
from cardata cd, countries cu, carmakers cm, models mo, makes ma
where cd.Horsepower = (select MAX(Horsepower) from cardata) and
      cu.Id = cm.Country and
      cm.Id = mo.Maker and
      ma.Model = mo.Model and
      ma.Id = cd.Id

-- Q2.
select ma.Make, cd.Year
from cardata cd, countries cu, carmakers cm, models mo, makes ma
where cd.MPG = (select MAX(MPG) from cardata) and
      cd.Accelerate = (select MAX(cd.Accelerate) from cardata) and
      cu.Id = cm.Country and
      cm.Id = mo.Maker and
      ma.Model = mo.Model and
      ma.Id = cd.Id

-- Q3.
with CarCount as(
    select carmakers.Id, carmakers.Country, COUNT(cardata.Id) as count
    from cardata, carmakers, models, makes
    where cardata.Id = makes.Id
        and makes.Model = models.Model
        and carmakers.Id = models.Maker
    group by carmakers.Id, carmakers.Country
),
MaxCountry as(
    select Country, MAX(count) as count
    from CarCount
    group by Country
),
Final as(
    select CarCount.Country, CarCount.Id
    from CarCount, MaxCountry
    where CarCount.count = MaxCountry.count
        and CarCount.Country = MaxCountry.Country
)
select countries.Name, carmakers.Maker
from Final, carmakers, countries
where Final.Country = countries.Id
    and Final.Id = carmakers.Id
order by countries.Name;

-- Q4.
with Everything as(
    select cardata.Year, carmakers.Id, COUNT(cardata.Id) as count, AVG(cardata.Accelerate) as acc, AVG(cardata.Weight) as weight
    from cardata, makes, models, carmakers
    where cardata.Id = makes.Id
        and makes.Model = models.Model
        and models.Maker = carmakers.Id
    group by cardata.Year, carmakers.Id
    HAVING COUNT(cardata.Id) > 1
),
Heaviest as(
    select Year, MAX(weight) as weight
    from Everything
    group by Year
)
select Everything.Year, carmakers.Maker, Everything.count,Everything.acc
from Everything, Heaviest, carmakers
where Everything.weight = Heaviest.weight
    and Everything.Id = carmakers.Id
order by Everything.Year;

-- Q5.
select 
(select max(cd.MPG)
from cardata cd
where cd.Cylinders = 8)
-
(select min(cd.MPG)
from cardata cd
where cd.Cylinders = 4
) as Mileage_Difference;

-- Q6.
with CarCount as(
    select cardata.Year, countries.Name, COUNT(cardata.Id) as count
    from cardata, makes, models, carmakers, countries
    where cardata.Id = makes.Id
        and makes.Model = models.Model
        and models.Maker = carmakers.Id
        and cardata.Year BETWEEN 1972 and 1976
        and carmakers.Country = countries.Id
    group by cardata.Year, countries.Id
),
USACount as(
    select Year, Name, count
    from CarCount
    where CarCount.Name = 'usa'
),
OthersCount as(
    select Year, Name, count
    from CarCount
    where CarCount.Name != 'usa'
)
select DISTINCT USACount.Year,
    case
        WHEN USACount.count > OthersCount.count THEN 'us'
        ELSE 'rest of the world'
    END as Leader
from USACount, OthersCount
where USACount.Year = OthersCount.Year;