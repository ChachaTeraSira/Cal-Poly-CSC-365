-- Khushkaranpreet khgrewal@calpoly.edu
-- Q1.
select firstname, count(Song)
from Band b, Vocals v
where b.Id = v.Bandmate and
      v.VocalType = 'lead'
group by firstname
order by Count(Song) DESC

-- Q2.
select Firstname, count(DISTINCT i.Instrument) as unique_intrument
from Albums a, Tracklists t, Instruments i, Band b
where a.Title = 'Rockland' and
      a.AId = t.Album and
      t.Song = i.Song and
      i.Bandmate = b.Id
group by Firstname

-- Q3.
select p.StagePosition, Count(p.StagePosition) as n_times
from Band b, Performance p
where b.Firstname = 'Solveig' and
      b.Id = p.Bandmate
group by p.StagePosition
order by n_times

-- Q4.
select b2.Firstname, count(i.Bandmate) as bass
from Instruments i, Band b1, Band b2, Performance p
where b1.Firstname = 'Anne-Marit' and
      b1.Id != i.Bandmate and
      b2.Firstname != b1.Firstname and
      b2.Id = i.Bandmate and
      i.Instrument = 'bass balalaika' and
      b1.Id = p.Bandmate and
      p.StagePosition = 'left' and
      i.Song = p.Song
group by i.Bandmate
order by b2.Firstname

-- Q5.
select i.Instrument
from Instruments i, Band b
where i.Bandmate = b.Id
group by i.Instrument
having count(DISTINCT b.Id) = 4
order by i.Instrument

-- Q6.
select Firstname, Count(DISTINCT i1.Song) as n_count
from Instruments i1, Instruments i2, Band b
where i1.Bandmate = i2.Bandmate and
      i1.Bandmate = b.Id and
      i1.Song = i2.Song and
      i1.Instrument != i2.Instrument
group by Firstname
order by Firstname