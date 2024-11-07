-- Khushkaranpreet khgrewal@calpoly.edu
-- Q1.
select w1.Grape, w1.Winery, w1.Name, w1.Score, (w1.Cases * 12 * w1.Price) as Revenue
from appellations a, wine w1, wine w2
where w1.vintage = 2006 and
      a.County = 'Napa' and
      a.Appellation = w1.Appellation and
      (w2.vintage = 2006 and
      w2.Grape = 'Zinfandel' and
      w2.Winery = 'Rosenblum' and
      w2.Appellation = 'Paso Robles' and
      w2.Name = 'Appelation Series') and
      (w1.Cases * 12 * w1.Price) > (w2.Cases * 12 * w2.Price)
order by Revenue DESC

-- Q2.
select Avg(Score)
from wine
where Appellation = 'Sonoma Valley' and
      Grape = 'Zinfandel'

-- Q3.========code looks perfect, but answer doesn't match

-- Q4.
select Avg(Cases)
from wine w, appellations a
where w.Grape = 'Zinfandel' and
      a.Area = 'Central Coast' and
      a.Appellation = w.Appellation

-- Q5. ========= can't understand the question