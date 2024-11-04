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
order by b.Firstname ASC

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
where v.VocalType = 'lead' and 
      p.StagePosition != 'center' and
      s.SongId = v.Song and
      s.SongId = p.Song and
      v.Bandmate = p.Bandmate and
      v.Bandmate = b.Id
order by s.Title ASC

