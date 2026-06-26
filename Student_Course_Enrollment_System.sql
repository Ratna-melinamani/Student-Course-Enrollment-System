show databases;
use student_project;
show tables;
desc students;
select * from students;
desc courses;
select * from courses;
desc enrollment;
select * from enrollment;
desc exams;
select * from exams;
desc results;
select * from results;

SELECT s.student_id,
       s.name,
       c.course_name
FROM students s
JOIN enrollment e
ON s.student_id = e.student_id
JOIN courses c
ON e.course_id = c.course_id
WHERE c.course_name = 'Database Systems'; 

SELECT c.course_name,
       COUNT(e.student_id) AS total_students
FROM courses c
LEFT JOIN enrollment e
ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;



SELECT s.name,
       c.course_name,
       r.marks,
       r.grade
FROM results r
JOIN exams e
ON r.exam_id = e.exam_id
JOIN students s
ON e.student_id = s.student_id
JOIN courses c
ON e.course_id = c.course_id;


SELECT s.name,
       r.marks
FROM results r
JOIN exams e
ON r.exam_id = e.exam_id
JOIN students s
ON e.student_id = s.student_id
WHERE r.marks = (
    SELECT MAX(marks)
    FROM results
);

SELECT s.student_id,
       s.name
FROM students s
LEFT JOIN enrollment e
ON s.student_id = e.student_id
WHERE e.student_id IS NULL;

SELECT c.course_name
FROM courses c
LEFT JOIN exams e
ON c.course_id = e.course_id
WHERE e.exam_id IS NULL;


SELECT c.course_name,
       AVG(r.marks) AS average_marks
FROM courses c
JOIN exams e
ON c.course_id = e.course_id
JOIN results r
ON e.exam_id = r.exam_id
GROUP BY c.course_id, c.course_name;


SELECT s.name,
       r.grade
FROM students s
JOIN exams e
ON s.student_id = e.student_id
JOIN results r
ON e.exam_id = r.exam_id
WHERE r.grade = 'A';


SELECT exam_id,
       student_id,
       course_id,
       exam_date
FROM exams
WHERE MONTH(exam_date) = 2;


SELECT result_id,
       marks,
       CASE
           WHEN marks >= 90 THEN 'A+'
           WHEN marks >= 80 THEN 'A'
           WHEN marks >= 70 THEN 'B'
           WHEN marks >= 60 THEN 'C'
           ELSE 'F'
       END AS Auto_Grade
FROM results;


SELECT s.student_id,
       s.name,
       COUNT(e.course_id) AS total_enrollments
FROM students s
JOIN enrollment e
ON s.student_id = e.student_id
GROUP BY s.student_id, s.name
ORDER BY total_enrollments DESC
LIMIT 1;