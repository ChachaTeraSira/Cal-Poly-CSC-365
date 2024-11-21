-- Khushkaranpreet khgrewal@calpoly.edu
-- Q1.
select rm.Roomname, SUM(DATEDIFF(re.Checkout,re.CheckIn)*re.Rate) as REVENUE, AVG(DATEDIFF(re.Checkout, re.CheckIn) * re.Rate) as AverageRevenue
from rooms rm, reservations re
where rm.RoomCode = re.Room and
      re.CheckIn >= '2010-06-01' and
      re.CheckIn <= '2010-08-31' 
group by rm.RoomName
order by REVENUE DESC 

-- Q2.
select Count(*) as Tot_res, SUM(DATEDIFF(Checkout, CheckIn)*Rate) as Revenue
from reservations
where YEAR(CheckIn) IN (2010) and
      DAYNAME(CheckIn) = 'MONDAY' and
      DAYNAME(Checkout) = 'SATURDAY'

-- Q3.
select DAYNAME(MIN(CheckIn)) as weekday, Count(*) as stays, SUM(DATEDIFF(Checkout, CheckIn)*Rate) as revenue
from reservations
where DATEDIFF(Checkout, CheckIn) > 5
group by MOD(DAYNAME(CheckIn) - 2, 7)
order by MOD(DAYNAME(CheckIn) - 2, 7)

-- Q4.
select RoomName, SUM(Adults)+SUM(Kids) as Total
from reservations re, rooms rm
where CheckIn >= '2010-01-01' and
      CheckIn <= '2010-12-31' and
      re.Room = rm.RoomCode
group by RoomName
order by Total DESC

-- Q5.
select rm.RoomCode, rm.RoomName, SUM(DATEDIFF(LEAST(Checkout, '2010-12-31'), GREATEST(CheckIn, '2010-01-01'))) as days
from rooms rm, reservations re
where rm.RoomCode = re.Room and
      (
      (YEAR(CheckIn) = 2010 and YEAR(Checkout) = 2010) or
      (YEAR(CheckIn) = 2010 and YEAR(Checkout) > 2010) or
      (YEAR(CheckIn) < 2010 and YEAR(Checkout) >= 2010)
      )
group by rm.RoomCode
order by days DESC