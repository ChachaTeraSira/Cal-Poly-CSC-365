-- Khushkaranpreet khgrewal@calpoly.edu
-- Q1.
WITH WinePerGrape AS(
    SELECT grapes.Grape, COUNT(wine.WineId) AS count
    FROM grapes, wine, appellations
    WHERE wine.Grape = grapes.Grape
        AND grapes.Color = 'Red'
        AND wine.Appellation = appellations.Appellation
        AND appellations.County = 'San Luis Obispo'
    GROUP BY grapes.Grape
),
MaxCount AS(
    SELECT MAX(count) AS count
    FROM WinePerGrape
)
SELECT Grape
FROM WinePerGrape, MaxCount
WHERE WinePerGrape.count = MaxCount.count;

-- Q2.
select g.Grape as grape_name
from grapes g
join wine w on w.Grape = g.Grape
where w.Score >= 93
group by g.Grape
having count(w.WineId) = (
    select max(high_ranked_count)
    from (
        select count(w1.WineId) as high_ranked_count
        from wine w1
        where w1.Score >= 93
        group by w1.Grape
    ) as max_high_ranked_count
)
order by g.Grape;

-- Q3.
select w.Winery, w.Name as wine_name, w.Cases
from wine w
where (
    select count(*)
    from wine w1
    where w1.Cases > w.Cases
) = 36
order by w.Cases desc;

-- Q4.
select w.Winery, w.Name as wine_name, w.Appellation, w.Score, w.Price
from wine w
where w.Vintage = 2008
  and w.Grape = 'Zinfandel'
  and w.Score >= (
      select max(w1.Score)
      from wine w1
      where w1.Vintage = 2007
        and w1.Grape = 'Grenache'
  );

-- Q5.
select
    sum(case when dry_creek.max_score > carneros.max_score then 1 else 0 end) as DryCreek,
    sum(case when carneros.max_score > dry_creek.max_score then 1 else 0 end) as Carneros
from
    (
    select w.Vintage, max(w.Score) as max_score
    from wine w
    join appellations a on w.Appellation = a.Appellation
    where a.State = 'California' and a.Appellation = 'Carneros'
      and w.Vintage between 2005 and 2009
    group by w.Vintage
    ) as carneros
join
    (
    select w.Vintage, max(w.Score) as max_score
    from wine w
    join appellations a on w.Appellation = a.Appellation
    where a.State = 'California' and a.Appellation = 'Dry Creek Valley'
      and w.Vintage between 2005 and 2009
    group by w.Vintage
    ) as dry_creek
on carneros.Vintage = dry_creek.Vintage;

-- Q6.
select a.Area, count(distinct w.Winery) as num_wineries
from appellations a
left join wine w on w.Appellation = a.Appellation and w.Grape = 'Grenache'
where a.Area not in ('N/A', 'California')
group by a.Area
order by a.Area;