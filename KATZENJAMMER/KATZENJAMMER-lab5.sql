-- Khushkaranpreet khgrewal@calpoly.edu
-- Q1.
-- ====================IN PROGESS======================
-- b.Firstname doesn't wokr with Count/aggregated operation

-- Q2.
select Count(*)
from Band b1, Band b2, Performance p, Vocals v
where (b1.Firstname = 'Solveig' and b1.Id = p.Bandmate and p.StagePosition = 'center') and
      (b2.Firstname = 'Turid' and b2.Id = v.Bandmate and v.VocalType = 'lead') and
      p.Song = v.Song

-- Q3.
select count(*)
from Band b, Instruments i, Vocals v, Performance p
where b.Firstname = 'Anne-Marit' and
      b.Id = i.Bandmate and
      i.Instrument = 'banjo' and
      b.Id = v.Bandmate and
      v.VocalType = 'lead' and
      b.Id = p.Bandmate and
      p.StagePosition = 'center' and
      i.Song = v.Song and
      i.Song = p.Song

-- Q4.
select Count(DISTINCT i.Instrument)
from Band b, Instruments i
where b.Firstname = 'Turid' and
      b.Id = i.Bandmate

-- Q5.
select DISTINCT i1.Instrument
from Band b1, Band b2, Instruments i1, Instruments i2
where b1.Firstname = 'Solveig' and
      b1.Id = i1.Bandmate and
      b2.Firstname = 'Turid' and
      b2.Id = i2.Bandmate and
      i1.Song != i2.Song and
      i1.Instrument = i2.Instrument
order by i1.Instrument ASC

-- Q6.
select GROUP_CONCAT(DISTINCT i1.Instrument SEPARATOR ' or ')
from Band b1, Band b2, Instruments i1, Instruments i2
where b1.Firstname = 'Solveig' and
      b1.Id = i1.Bandmate and
      b2.Firstname = 'Turid' and
      b2.Id = i2.Bandmate and
      i1.Song != i2.Song and
      i1.Instrument = i2.Instrument
order by i1.Instrument ASC

-- Q7.     
select count(DISTINCT s.SongId) - count(DISTINCT i.Song)
from Instruments i, Songs s
where i.Instrument = 'guitar' and
      i.Song != s.SongId

-- Q8.
select count(*)
from Instruments i1, Instruments i2, Band b1, Band b2
where i1.Bandmate != i2.Bandmate and
      i1.Bandmate = b1.Id and
      i2.Bandmate = b2.Id and
      i1.song = i2.song and
      i1.Instrument = i2.Instrument and
      b1.Firstname < b2.Firstname