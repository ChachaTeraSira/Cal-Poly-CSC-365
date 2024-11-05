-- Khushkaranpreet khgrewal@calpoly.edu
-- Q1.
select DISTINCT a.Name, a.Abbr
from airlines a, flights f
where f.Source = 'APN' and
      f.Airline = a.Id
order by a.Name ASC

-- Q2.
select DISTINCT f.FlightNo, ap.Code, ap.Name
from flights f, airlines al, airports ap
where f.Source = 'KQA' and
      al.Abbr = 'Delta' and
      f.Destination = ap.Code and
      al.Id = f.Airline
order by f.FlightNo ASC

-- Q3.
select f1.FlightNo, f2.FlightNo, ap.Code, ap.Name
from airlines a, flights f1, flights f2, airports ap
where a.Abbr = 'Delta' and
      a.Id = f1.Airline and
      a.Id = f2.Airline and
      f1.Source = 'KQA' and
      f2.Destination != 'KQA' and
      f1.Destination = f2.Source and
      f2.Destination = ap.Code

-- Q4.
select DISTINCT ap1.Name, ap1.Code, ap2.Name, ap2.Code
from airlines a1, airlines a2, airports ap1, airports ap2, flights f1, flights f2
where a1.Abbr = 'Delta' and
      a2.Abbr = 'JetBlue' and
      a1.Id = f1.Airline and
      a2.Id = f2.Airline and
      ap1.Code = f1.Source and
      ap2.Code = f2.Destination and
      f1.Source = f2.Source and
      f1.Destination = f2.Destination and
      f1.Source != f2.Destination  and
      ap1.Code < ap2.Code

-- Q5.
select DISTINCT ap.code
from airports ap, 
     airlines a1, airlines a2, airlines a3, airlines a4, airlines a5, 
     flights f1, flights f2, flights f3, flights f4, flights f5
where a1.abbr = 'Delta'     and ap.code = f1.source and f1.airline = a1.Id and
      a2.abbr = 'Frontier'  and ap.code = f2.source and f2.airline = a2.Id and
      a3.abbr = 'USAir'     and ap.code = f3.source and f3.airline = a3.Id and
      a4.abbr = 'UAL'       and ap.code = f4.source and f4.airline = a4.Id and
      a5.abbr = 'Southwest' and ap.code = f5.source and f5.airline = a5.Id
order by ap.code