-- Khushkaranpreet khgrewal@calpoly.edu
-- Q1.
select DISTINCT rm.RoomCode, rm.RoomName
from reservations re1, reservations re2, reservations re3, rooms rm
where (re1.CheckIn <= '2010-02-16' and re1.Checkout >= '2010-02-16') and
      (re2.CheckIn <= '2010-07-12' and re2.Checkout >= '2010-07-12') and
      (re3.CheckIn <= '2010-10-20' and re3.Checkout >= '2010-10-20') and
      re1.Room = re2.Room and
      re1.Room = re3.Room and
      re1.Room = rm.RoomCode
order by rm.RoomName

-- Q2.
select Count(re.Room)
from rooms rm, reservations re
where rm.decor = 'modern' and
      rm.RoomCode = re.Room and
      DATEDIFF(re.Checkout,re.CheckIn) = 7

-- Q3.
select count(CODE)
from reservations
where (checkIn >= '2010-08-01' and Checkout <= '2010-08-31') and
      Adults = 2 and Kids = 2

-- Q4.
select avg(DATEDIFF(re.Checkout,re.CheckIn)) as avg_stay
from rooms rm, reservations re
where rm.RoomName = 'Interim but salutary' and
      rm.RoomCode = re.Room and
      CheckIn > '2010-05-01' and Checkout < '2010-08-31'

-- Q5.
select count(re.CODE)
from rooms rm, reservations re
where rm.RoomName = 'Interim but salutary' and
      rm.RoomCode = re.Room and
      CheckIn >= '2010-07-01' and Checkout <= '2010-07-31'
  
-- Q6.
select GROUP_CONCAT(DISTINCT rm.RoomName order by rm.RoomName SEPARATOR ' and ')
from rooms rm, reservations re
where LastName = 'DONIGAN' and FirstName = 'GLEN' and
      re.Room = rm.RoomCode