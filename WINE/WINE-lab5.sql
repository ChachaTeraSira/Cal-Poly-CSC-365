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

-- Q3.
select SUM(Cases * Price * 12) as Revenue
from wine
where vintage = 2009 and
      Grape = 'Sauvignon Blanc' and
      Score >= 89

-- Q4.
select Avg(Cases)
from wine w, appellations a
where w.Grape = 'Zinfandel' and
      a.Area = 'Central Coast' and
      a.Appellation = w.Appellation

-- Q5.
select count(*)
from grapes g, wine w1, wine w2
where w1.Appellation = 'Russian River Valley' and
      w2.Appellation = w1.Appellation and
      g.Grape = w2.Grape and
      w1.Vintage = w2.Vintage and
      w1.Score = 98 and
      g.Color = 'Red'