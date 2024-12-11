-- Khushkaranpreet khgrewal@calpoly.edu
-- Q1.
select c.FirstName, c.LastName
from customers c, (
  select c.CId as id, SUM(g.Price) as tot_sum
  from customers c, receipts r, items i, goods g
  where c.CId = r.Customer and
        r.RNumber = i.Receipt and
        i.Item = g.GId
  group by c.CId
  ) S
where S.id = c.CId and
      S.tot_sum = (
  select MAX(tot_sum)
  from    (select SUM(g.Price) as tot_sum
          from customers c
          join receipts r on c.CId = r.Customer
          join items i on r.RNumber = i.Receipt
          join goods g on i.Item = g.GId
          group by c.CId 
          ) Subquery
            )

-- Q2.
select c.FirstName, c.LastName
from customers c
EXCEPT
select c.FirstName, c.LastName
from goods g, items i, receipts r, customers c
where (Food = 'Eclair' and
      SaleDate LIKE '2007-10%' and
      g.GId = i.Item and
      i.Receipt = r.RNumber and
      r.Customer = c.CId)
group by r.Customer
order by LastName

-- Q3.
select 
    c.firstname,
    c.lastname
from customers c
join receipts r on c.cid = r.customer
join items i on r.rnumber = i.receipt
join goods g on i.item = g.gid
where r.saledate between '2007-10-01' and '2007-10-31'
group by c.cid, c.firstname, c.lastname
having count(case when g.food = 'cake' then 1 end) > 
       count(case when g.food = 'cookie' then 1 end)
order by c.lastname, c.firstname;

-- Q4.
WITH max_item as (
select i.Item as item_ID, Count(i.Ordinal) as max_q
from items i
group by i.Item
)
select g.Flavor, g.Food, max_q
from goods g, max_item mx
where g.GId = mx.item_ID and
      mx.max_q = (select MAX(max_q) from max_item)

-- Q5.
WITH total_sum AS (
    select r.SaleDate, SUM(i.Ordinal * g.Price) as high_rev
    from receipts r, items i, goods g
    where r.SaleDate <= '2007-10-31' and r.SaleDate >= '2007-10-1' and
          r.RNumber = i.Receipt and
          i.Item = g.GId
    group by r.SaleDate
)
select r1.SaleDate
from receipts r1, total_sum ts
where r1.SaleDate = ts.SaleDate and
      ts.high_rev = (select MAX(high_rev) from total_sum)
group by r1.SaleDate


-- Q6.
with revenue_per_day as (
    select r.saledate, sum(g.price) as total_revenue
    from receipts r
    join items i on r.rnumber = i.receipt
    join goods g on i.item = g.gid
    where r.saledate between '2007-10-01' and '2007-10-31'
    group by r.saledate
),
highest_revenue_day as (
    select saledate
    from revenue_per_day
    where total_revenue = (select max(total_revenue) from revenue_per_day)
)
select g.food, g.flavor, count(i.item) as total_purchases
from receipts r
join items i on r.rnumber = i.receipt
join goods g on i.item = g.gid
where r.saledate = (select saledate from highest_revenue_day)
group by g.flavor, g.food
having count(i.item) = (
    select max(total_purchases)
    from (
        select g.food, g.flavor, count(i.item) as total_purchases
        from receipts r
        join items i on r.rnumber = i.receipt
        join goods g on i.item = g.gid
        where r.saledate = (select saledate from highest_revenue_day)
        group by g.flavor, g.food
    ) as subquery
)
order by total_purchases desc;

-- Q7.
with cake_purchases as (
    select g.flavor, g.food, c.firstname, c.lastname, count(i.item) as total_purchases
    from receipts r
    join items i on r.rnumber = i.receipt
    join goods g on i.item = g.gid
    join customers c on r.customer = c.cid
    where g.food = 'cake'
      and r.saledate between '2007-10-01' and '2007-10-31'
    group by g.flavor, g.food, c.firstname, c.lastname
),
max_purchases as (
    select 
        flavor,
        food,
        max(total_purchases) as max_purchase
    from cake_purchases
    group by flavor, food
)
select cp.flavor, cp.food, cp.firstname, cp.lastname, cp.total_purchases
from cake_purchases cp
join max_purchases mp 
    on cp.flavor = mp.flavor 
    and cp.food = mp.food
    and cp.total_purchases = mp.max_purchase
order by cp.total_purchases desc, cp.flavor asc, cp.lastname asc;

-- Q8.
select 
    c.firstname,
    c.lastname
from customers c
left join receipts r on c.cid = r.customer 
    and r.saledate between '2007-10-19' and '2007-10-23'
where r.rnumber is null

-- Q9.
select c.firstname, c.lastname,
    case 
        when count(case when g.food = 'Eclair' then 1 end) = 0 then NULL 
        else count(case when g.food = 'Eclair' then 1 end) 
    end as num_tarts,
    case 
        when count(case when g.food = 'danish' then 1 end) = 0 then NULL 
        else count(case when g.food = 'danish' then 1 end) 
    end as num_danishes,
    case 
        when count(case when g.food = 'pie' then 1 end) = 0 then NULL 
        else count(case when g.food = 'pie' then 1 end) 
    end as num_pies
from customers c
join receipts r on c.cid = r.customer
join items i on r.rnumber = i.receipt
join goods g on i.item = g.gid
where g.food in ('Eclair', 'danish', 'pie')
group by c.cid, c.firstname, c.lastname
order by c.lastname

-- Q10.
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
    Case
        when SumChoc.Revenue > CroissantRevenue.Revenue then 'Chocolate'
        when SumChoc.Revenue < CroissantRevenue.Revenue then 'Croissant'
        else 'Tied'
    end as HigherRevenue
from SumChoc, CroissantRevenue;