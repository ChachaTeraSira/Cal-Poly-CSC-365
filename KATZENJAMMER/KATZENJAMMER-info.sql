-- Khushkaranpreet khgrewal@calpoly.edu
-- Q1.
select s.Title
from Albums a, Tracklists t, Songs s
where a.Title = 'Le Pop' and
      a.AId = t.Album and
      t.Song = s.SongId
order by s.SongId

-- Q2.
select DISTINCT b.Firstname , i.Instrument
from Instruments i, Songs s, Performance p, Band b
where s.Title = 'Cherry Pie' and
      s.SongId = p.Song and
      s.SongId = i.Song and
      i.Bandmate = p.Bandmate and
      i.Bandmate = b.Id
order by b.Firstname, i.Instrument ASC

-- Q3.
select DISTINCT i.Instrument
from Instruments i, Band b, Performance p
where b.Firstname = 'Turid' and
      b.Id = i.Bandmate and 
      b.Id = p.Bandmate and
      i.Song = p.Song
order by i.Instrument ASC

-- Q4.
select s.Title, b.Firstname
from Instruments i, Songs s, Band b
where i.Instrument = 'toy piano' and
      i.Song = s.SongId and
      i.Bandmate = b.Id
order by s.Title ASC

-- Q5.
select DISTINCT i.Instrument
from Instruments i, Band b, Vocals v
where b.Firstname = 'Turid' and
      b.Id = i.Bandmate and
      b.Id = v.Bandmate and
      VocalType = 'lead' and
      i.Song = v.Song
order by i.Instrument ASC

-- Q6.
select s.Title, b.Firstname, p.StagePosition
from Songs s, Vocals v, Performance p, Band b
where v.VocalType = 'lead' and p.StagePosition != 'center' and
      s.SongId = v.Song and
      s.SongId = p.Song and
      v.Bandmate = p.Bandmate and
      v.Bandmate = b.Id
order by s.Title ASC

-- Q7.
select DISTINCT s.Title
from Band b, Instruments i1, Instruments i2, Instruments i3, Songs s
where b.Firstname = 'Anne-Marit'     and b.Id = i1.Bandmate and
      i1.Bandmate = i2.Bandmate      and i1.Bandmate = i3.Bandmate and
      i3.Song = s.SongId             and i2.Song = i1.Song         and i3.Song = i1.Song and
      i1.Instrument != i2.Instrument and i1.Instrument != i3.Instrument

-- Q8.
select b1.FirstName as Right_side, b2.FirstName as Center, b3.FirstName as Back, b4.FirstName as Left_side
from Songs s, Performance p1, Performance p2, Performance p3, Performance p4, Band b1, Band b2, Band b3, Band b4
where s.Title = 'Johnny Blowtorch' and
      p1.StagePosition = 'right' and
      p2.StagePosition = 'center' and
      p3.StagePosition = 'back' and
      p4.StagePosition = 'left' and
      s.SongId = p1.Song and
      s.SongId = p2.Song and
      s.SongId = p3.Song and
      s.SongId = p4.Song and
      b1.Id = p1.Bandmate and
      b2.Id = p2.Bandmate and
      b3.Id = p3.Bandmate and
      b4.Id = p4.Bandmate