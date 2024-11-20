-- Khushkaranpreet khgrewal@calpoly.edu
-- Q1.
select score, AVG(Price) as AVG_price, MIN(Price) as Cheapest, MAX(Price) as Expensiev, Count(*) as Num_wines, SUM(Cases) as CASES
from wine
where score > 88
group by score
order by score

-- Q2.
select w.grape, 12*MAX(Price) as Max_case
from grapes g, wine w
where g.Color = 'Red' and
      g.Grape = w.Grape
group by w.Grape
having Count(w.Grape) > 10
order by Max_case DESC

-- Q3.
select Winery, GROUP_CONCAT(DISTINCT Name order by Name SEPARATOR ', ') as sonoma_valley_zins
from wine
where grape = 'Zinfandel' and
      Appellation = 'Sonoma Valley'
group by Winery

-- Q4.
select County, MAX(w.Score) as score
from appellations a, wine w, grapes g
where a.Appellation = w.Appellation and
      w.Vintage = 2009 and
      a.County != 'N/A' and
      g.Color = 'Red' and
      g.grape = w.grape
group by County
order by score DESC