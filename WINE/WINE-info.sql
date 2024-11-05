-- Khushkaranpreet khgrewal@calpoly.edu
-- Q1.
select Name, Winery, Score
from wine
where Grape = 'Zinfandel' and
      Vintage = 2008 and
      Appellation = 'Napa Valley'
order by Score DESC

-- Q2.
select DISTINCT g.Grape
from grapes g, wine w
where g.Color = 'White' and
      g.Grape = w.Grape and
      Vintage = 2009 and
      Score >= 90
order by g.Grape

-- Q3.
select DISTINCT a.Appellation, a.County
from appellations a, grapes g, wine w
where a.County = 'Sonoma' and
      g.Grape = 'Grenache' and
      g.Grape = w.Grape and
      a.Appellation = w.Appellation
order by a.County, a.Appellation

-- Q4.
select Name, Vintage, Score, (Cases * 12 * Price) as Revenue
from wine
where Winery = 'Altamura'
order by Revenue DESC

-- Q5.
select ((1*w1.Price) + (2*w2.Price) + (3*w3.Price)) as TOTAL
from wine w1, wine w2, wine w3
where (w1.Winery = 'Kosta Browne' and w1.Name = 'Koplen Vineyard' and w1.Vintage = 2008 and w1.Grape = 'Pinot Noir') and
      (w2.Winery = 'Darioush' and w2.Name = 'Darius II' and w2.Vintage = 2007 and w2.Grape = 'Cabernet Sauvingnon') and
      (w3.Winery = 'Kistler' and w3.Name = 'McCrea Vineyard' and w3.Vintage = 2006 and w3.Grape = 'Chardonnay')
