-- Khushkaranpreet khgrewal@calpoly.edu
-- Q1.
select t.Last, t.First, count(l.FirstName) as num_students
from teachers t
join list l on t.classroom = l.classroom
group by t.First, t.Last
having count(l.FirstName) = (
    select min(num_students)
    from (
        select count(l.FirstName) as num_students
        from teachers t
        join list l on t.classroom = l.classroom
        group by t.First, t.Last
    ) min_students
);

-- Q2.
WITH NumStudents AS(
    SELECT classroom, COUNT(*) AS count
    FROM list
    GROUP BY classroom
),
AvgNum AS(
    SELECT list.grade, AVG(NumStudents.count) AS count
    FROM NumStudents, list
    WHERE NumStudents.classroom = list.classroom
    GROUP BY list.grade
)
SELECT AvgNum.grade, AvgNum.count
FROM AvgNum
WHERE AvgNum.count = (SELECT MAX(AvgNum.count) FROM AvgNum);

-- Q3.
select l.grade, l.FirstName, l.LastName
from list l
where LENGTH(CONCAT(l.FirstName, ' ', l.LastName)) = (
    select max(LENGTH(CONCAT(l2.FirstName, ' ', l2.LastName)))
    from list l2
)
order by l.grade;

-- Q4.
WITH StudentCount AS(
    SELECT classroom, COUNT(*) AS count
    FROM list
    GROUP BY classroom
)
SELECT s1.classroom, s2.classroom, s1.count
FROM StudentCount s1, StudentCount s2
WHERE s1.count = s2.count
    AND s1.classroom != s2.classroom
    AND s1.classroom < s2.classroom
ORDER BY s1.count ASC;

-- Q5.
select student_counts.grade, t.Last
from (
    select l.grade, l.classroom, count(l.FirstName) as student_count
    from list l
    group by l.grade, l.classroom
) as student_counts
join teachers t on t.classroom = student_counts.classroom
where student_counts.grade in (
    select grade
    from list
    group by grade
    having count(distinct classroom) > 1
)
and student_counts.student_count = (
    select max(student_count)
    from (
        select count(l2.FirstName) as student_count
        from list l2
        where l2.grade = student_counts.grade
        group by l2.classroom
    ) as max_student_count
)
order by student_counts.grade;