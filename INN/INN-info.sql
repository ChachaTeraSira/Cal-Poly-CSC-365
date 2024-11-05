-- Khushkaranpreet khgrewal@calpoly.edu
-- Q1.
select RoomCode, RoomName
from rooms
where decor = 'traditional' and
      basePrice > 170 and
      Beds = 2
order by RoomCode ASC

-- Q2.
select DISTINCT  re.CODE, re.LastName, re.CheckIn
from rooms rm, reservations re
where rm.RoomName = 'Mendicant with cryptic' and
      rm.RoomCode = re.Room and
      DATEDIFF(re.Checkout, re.CheckIn) = 5
order by CheckIn ASC

-- Q3.
select re.LastName, re.CheckIn, re.Checkout, (re.Adults + re.Kids) as Guest, ((Checkout - CheckIn) * re.Rate) as Cost
from reservations re, rooms rm
where rm.RoomName = 'Frugal not apropos' and
      rm.RoomCode = re.Room and
      MONTH(CheckIn) = '07' and MONTH(Checkout) = '07'
order by re.CheckIn, re.Checkout

-- Q4.
select DISTINCT rm.RoomName, re.CheckIn, re.Checkout
from reservations re, rooms rm
where re.CheckIn < '2010-11-01' and re.Checkout > '2010-11-01' and
      re.Room = rm.RoomCode
order by rm.RoomName

-- Q5.
select re.CODE, rm.RoomName, DATE_FORMAT(re.CheckIn, '%M %e') as CheckIn, DATE_FORMAT(re.Checkout, '%M %e') as Checkout, (Checkout-CheckIn)*Rate as PAID
from reservations re, rooms rm
where FirstName = 'BO' and
      LastName = 'DURAN' and
      re.Room = rm.RoomCode
order by CheckIn

-- Q6.
select rm.RoomName, re2.LastName, re2.CheckIn, DATEDIFF(re2.Checkout,re2.CheckIn) as DAYS
from reservations re1, reservations re2, rooms rm
where rm.decor = 'modern' and
      rm.RoomCode = re2.Room and
      re1.FirstName = 'FRITZ' and
      re2.FirstName != 'FRITZ' and
      re1.CheckIn < re2.Checkout and re2.CheckIn < re1.Checkout
order by re2.CheckIn, rm.RoomName

-- Q7
select re.CODE, re.Room, rm.RoomName, DATE_FORMAT(CheckIn, "%e %b") as CheckIn, DATE_FORMAT(Checkout, "%e %b") as Checkout
from reservations re, rooms rm
where rm.bedType = 'Double' and
      re.Adults = 4 and
      rm.RoomCode = re.Room
order by re.Room ASC