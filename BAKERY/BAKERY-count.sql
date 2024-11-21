-- Khushkaranpreet khgrewal@calpoly.edu
-- Q1.
select c.FirstName, c.LastName, Count(r.RNumber)
from receipts r, customers c
where c.Cid = r.Customer
group by r.Customer
having Count(r.RNumber) >= 15
order by Count(r.RNumber) DESC

-- Q2.
select g.Flavor, count(i.Item) as NCookies, Count(DISTINCT r.Customer) as Purchasers, SUM(g.Price) as Revenue
from goods g, items i, receipts r
where g.Food = 'cookie' and
      g.Gid = i.Item and
      i.Receipt = r.RNumber
group by g.Flavor
order by g.Flavor

-- Q3.
select DAYNAME(r.SaleDate) as DAY, r.SaleDate, Count(DISTINCT i.Receipt) as Purchases, Count(i.Item) as Items, Sum(g.Price) as Revenue
from receipts r, items i, goods g
where r.SaleDate >= '2007-10-15' and
      r.SaleDate <= '2007-10-21' and
      r.RNumber = i.Receipt and
      i.Item = g.Gid
group by r.SaleDate
order by r.SaleDate

-- Q4.
select c.FirstName, c.LastName, i.Receipt, SUM(g.Price) as Amount
from items i, receipts r, goods g, customers c
where i.Receipt = r.RNumber and
      i.Item = g.GId and
      r.Customer = c.CId
group by i.Receipt
having SUM(g.Price) >= 30
order by Amount DESC

-- Q5.
select c.FirstName, c.LastName, count(r.RNumber) as Num_Large_Purchases
from items i, receipts r, customers c
where i.Receipt = r.RNumber and
      r.Customer = c.CId and
      i.Ordinal = 5
group by r.Customer
order by MAX(r.SaleDate), c.LastName