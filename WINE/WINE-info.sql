-- Khushkaranpreet khgrewal@calpoly.edu
-- Q1
select Name, Winery, Score
from wine
where Grape = 'Zinfandel' and
      Vintage = 2008 and
      Appellation = 'Napa Valley'
order by Score DESC

-- Q2
select DISTINCT g.Grape
from grapes g, wine w
where g.Color = 'White' and
      g.Grape = w.Grape and
      Vintage = 2009 and
      Score >= 90

-- Q3
select DISTINCT a.Appellation, a.County
from appellations a, grapes g, wine w
where a.County = 'Sonoma' and
      g.Grape = 'Grenache' and
      g.Grape = w.Grape and
      a.Appellation = w.Appellation

-- Q4
select Name, Vintage, Score, (Cases * 12 * Price) as Revenue
from wine
where Winery = 'Altamura'
order by Revenue DESC


-- ============ IN PROGESS ================
show tables
select * from appellations
select * from grapes
select * from wine

select Price
from wine
where (Winery = 'Kosta Browne' and Name = 'Koplen Vineyard' and Vintage = 2008 and Grape = 'Pinot Noir') or
      (Winery = 'Darioush' and Name = 'Darius II' and Vintage = 2007 and Grape = 'Cabernet Sauvingnon') or
      (Winery = 'Kistler' and Name = 'McCrea Vineyard' and Vintage = 2006 and Grape = 'Chardonnay')

