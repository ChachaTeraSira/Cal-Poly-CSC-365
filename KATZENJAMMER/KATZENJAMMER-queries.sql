-- Khushkaranpreet khgrewal@calpoly.edu
-- Q1.
select b.Firstname
from Band b
EXCEPT
select b.Firstname
from Band b, (
select Bandmate
from Instruments
where Instrument = 'accordion'
group by Bandmate
) ins
where b.Id = ins.Bandmate

-- Q2.
WITH instrumental_comp_songid (Song_ID) AS (
select SongId
from Songs
EXCEPT
select Song
from Vocals
group by Song
)
select s1.Title
from Songs s1, instrumental_comp_songid s2
where s1.SongId = s2.Song_ID
order by s1.Title ASC

-- Q3.
select s.Title
from Songs s
join Instruments i on s.SongId = i.Song
group by s.SongId, s.Title
having count(distinct i.Instrument) = (
    select max(instrument_count)
    from (
        select count(distinct i.Instrument) as instrument_count
        from Instruments i
        group by i.Song
    ) as max_instruments
)
order by s.Title;

-- Q4.
WITH PlayCount AS(
    SELECT Instrument, Bandmate, COUNT(Song) AS count
    FROM Instruments
    GROUP BY Instrument, Bandmate
),
MostPlayed AS(
    SELECT Bandmate, MAX(count) AS count
    FROM PlayCount
    GROUP BY Bandmate
),
FINAL AS(
    SELECT PlayCount.Bandmate, PlayCount.count, PlayCount.Instrument
    FROM PlayCount, MostPlayed
    WHERE PlayCount.Bandmate = MostPlayed.Bandmate
        AND PlayCount.count = MostPlayed.count
)
SELECT Band.Firstname, FINAL.Instrument, FINAL.count AS num
FROM FINAL, Band
WHERE FINAL.Bandmate = Band.Id
ORDER BY Band.Firstname, FINAL.Instrument;

-- Q5.
SELECT Instruments.Instrument
FROM Instruments, Band
WHERE Band.Id = Instruments.Bandmate
    AND Band.Firstname = 'Anne-Marit'
GROUP BY Instruments.Instrument
EXCEPT
SELECT Instruments.Instrument
FROM Instruments, Band
WHERE Band.Id = Instruments.Bandmate
    AND Band.Firstname != 'Anne-Marit'
GROUP BY Instruments.Instrument;

-- Q6.
select b.firstname
from Band b
join Instruments i on b.id = i.bandmate
group by b.id
having count(distinct i.instrument) = (
    select max(instrument_count)
    from (
        select count(distinct i.instrument) as instrument_count
        from Band b
        join Instruments i on b.id = i.bandmate
        group by b.id
    ) as max_instruments
)
order by b.firstname DESC;

-- Q7.
select s.title as song_title, b.firstname as lead_singer
from Songs s
join Tracklists t on s.songid = t.song
join Albums a on t.album = a.aid
left join Vocals v on s.songid = v.song and v.vocaltype = 'lead'
left join Band b on v.bandmate = b.id
where a.title = 'Le Pop'
order by t.position, b.firstname;

-- Q8.
select i.instrument
from Instruments i
join ( 
    select i.instrument, count(distinct i.song) as song_count
    from Instruments i
    group by i.instrument
) instrument_counts on i.instrument = instrument_counts.instrument
where instrument_counts.song_count = (
    select max(song_count)
    from ( 
        select i.instrument, count(distinct i.song) as song_count
        from Instruments i
        group by i.instrument
    ) max_counts
)
group by i.instrument
order by i.instrument;