-- Khushkaranpreet khgrewal@calpoly.edu
-- Q1.
select DISTINCT r.SaleDate
from customers c, receipts r, goods g, items i
where (c.LastName = 'TOUSSAND' and
      c.FirstName = 'SHARRON' and
      c.CId = r.Customer and
      g.Gid = i.Item and
      i.Receipt = r.RNumber and
      i.Ordinal = 5) or
      (g.Flavor = 'Gongolais' and
      g.Food = 'Cookie' and
      c.CId = r.Customer and
      g.Gid = i.Item and
      i.Receipt = r.RNumber)
order by r.SaleDate

-- Q2.
select SUM(g.Price) as Total
from customers c, receipts r, items i, goods g
where c.LastName = 'LOGAN' and
      c.FirstName = 'JULIET' and
      c.CId = r.Customer and
      r.SaleDate >= '2007-10-01' and 
      r.SaleDate <= '2007-10-10' and
      r.RNumber = i.Receipt and
      i.Item = g.Gid

-- Q3.
select Count(DISTINCT r.RNumber)
from receipts r, items i, goods g
where g.Flavor = 'Chocolate' and
      g.GId = i.Item and
      i.Receipt = r.RNumber

-- Q4.
select Count(r.RNumber)
from goods g, items i, receipts r
where g.Flavor = 'Chocolate' and
      g.Gid = i.Item and
      i.Receipt = r.RNumber and
      r.SaleDate >= '2007-10-01' and
      r.SaleDate <= '2007-10-31'