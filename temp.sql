-- Bakery Query 10
with ChocRevenue as(
    select goods.Food, SUM(goods.PRICE) as Revenue
    from goods, items
    where goods.Flavor = 'Chocolate'
        and goods.GId = items.Item
    group by goods.Food
),
SumChoc as(
    select SUM(Revenue) as Revenue
    from ChocRevenue
),
CroissantRevenue as(
    select SUM(goods.PRICE) as Revenue
    from goods, items
    where goods.Food = 'Croissant'
        and goods.GId = items.Item
)
select
    CasE
        when SumChoc.Revenue > CroissantRevenue.Revenue then 'Chocolate'
        when SumChoc.Revenue < CroissantRevenue.Revenue then 'Croissant'
        else 'Tied'
    end as HigherRevenue
from SumChoc, CroissantRevenue;