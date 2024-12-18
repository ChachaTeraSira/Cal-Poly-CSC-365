-- Khushkaranpreet khgrewal@calpoly.edu
-- Q1.
select rm.RoomName, rm.RoomCode, Count(rm.RoomCode) as nReservations
from rooms rm, reservations re
where rm.Roomcode = re.Room
group by rm.RoomCode, rm.RoomName
having Count(rm.RoomCode) = (select MAX(r_count.max_re)
                            from (
                            select count(*) as max_re
                            from reservations
                            group by Room
                            ) r_count)

-- Q2.
select rm.RoomName, rm.RoomCode, SUM(DATEDIFF(Checkout, CheckIn)) as Occupancy
from rooms rm, reservations re
where rm.Roomcode = re.Room
group by rm.RoomCode, rm.RoomName
having SUM(DATEDIFF(Checkout, CheckIn)) = (select MAX(r_count.max_re)
                            from (
                            select SUM(DATEDIFF(Checkout, CheckIn)) as max_re
                            from reservations
                            group by Room
                            ) r_count)

-- Q3.
with ReservationTotals as (
    select rm.RoomCode, rm.RoomName, re.CODE, re.CheckIn, re.Checkout, re.LastName, re.Rate, datediff(re.Checkout, re.CheckIn) * re.Rate as TotalAmount
    from rooms rm join reservations re on rm.RoomCode = re.Room
),
MaxReservations as (
    select RoomCode, max(TotalAmount) as MaxAmount
    from ReservationTotals
    group by RoomCode
)
select rt.RoomName, rt.CheckIn, rt.Checkout, rt.LastName, rt.Rate, rt.TotalAmount
from ReservationTotals rt join MaxReservations mr on rt.RoomCode = mr.RoomCode and rt.TotalAmount = mr.MaxAmount
order by rt.TotalAmount desc;

-- Q4.
WITH rpm AS(
    select DATE_FORMAT(CheckIn, '%M') AS Month, SUM(Rate * DATEDIFF(Checkout, CheckIn)) AS Revenue
    from reservations
    group by Month
),
respm AS(
    select DATE_FORMAT(CheckIn, '%M') AS Month, COUNT(CODE) AS Reservation
    from reservations
    group by Month
)
select rpm.Month, rpm.Revenue, respm.Reservation
from rpm, respm
WHERE rpm.Month = respm.Month
    AND rpm.Revenue = (select MAX(rpm.Revenue) from rpm);

-- Q5.
select rooms.RoomName, rooms.RoomCode,
CASE
    WHEN MAX(reservations.CheckIn <= '2010-08-10' AND reservations.Checkout > '2010-08-10') THEN 'Occupied'
    ELSE 'Empty'
END AS Status
from reservations, rooms
WHERE reservations.Room = rooms.RoomCode
group by rooms.RoomCode
ORDER BY rooms.RoomCode;