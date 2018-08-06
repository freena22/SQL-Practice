

################# 50 Most Common SQL Questions ###################
/*
TABLE 1: Student (s_id, s_name, s_birth, s_sex)
TABLE 2: Course (c_id, c_name, t_id)
TABLE 3: Teacher (t_id, t_name)
TABLE 4: Score (s_id, c_id, s_score)
*/

######## 1. the students(s_id) who has higher score in C001 than C002

# Key:First get the s_id and score of Course 001 and then get the same of Course 002
#     Then Join A and B with same s_id and condition of A's score  greater than B's score.

# Answer 1:
SELECT A.s_id
FROM 
(SELECT s_id, s_score FROM Score WHERE c_id = '001') As A,
(SELECT s_id, s_score FROM Score WHERE c_id = '002') AS B
WHERE A.s_score > B.s_score
AND A.s_id = B.s_id;

# Answer 2:
SELECT A.s_id
FROM 
(SELECT s_id, s_score FROM Score WHERE c_id = '001') As A
JOIN 
(SELECT s_id, s_score FROM Score WHERE c_id = '002') AS B
ON A.s_id = B.s_id
WHERE A.s_score > B.score;

######## 2. Get all the students whose average score is greater than 60 (s_id and score)

# Algorithm: First get the average score of each student based on s_id grouping and then use having filter the scores. 
# Once using aggregation, think the groupby colomn first.

SELECT s_id, AVG(s_score) AS Average_Score
FROM Score
GROUP BY s_id
HAVIND Average_Score > 60;

######## 3. Get all the students' id, name, no. of courses, and total score

SELECT Student.s_id, Student.s_name, COUNT(Score.c_id) AS Num, SUM(Score.s_score) AS Total_Score
FROM Student
JOIN Score
On Student.s_id = Score.s_id
GROUP BY 1, 2;

######## 4. get th number of teachers whose Last name starting with 'hou'

SELECT COUNT(t_id) AS num
FROM Teacher
WHERE t_name LIKE 'hou%';

######## 5. get the students' id and name who didn't take teacher 'hou zi' course

SELECT Student.s_id, Student.s_name
FROM Student
WHERE s_id NOT IN
(SELECT DISTINCT(Score.s_id) FROM Score, Course, Teacher
 WHERE Score.c_id = Course.c_id 
 AND Teacher.t_id = Course.t_id
 AND Teacher.t_name = 'hou zi');

######## 6. get students' id and name who have taken all the course by teacher 'hou zi'


SELECT Student.s_id, Student.s_name
FROM Student
WHERE s_id IN
(SELECT s_id FROM Score, Course, Teacher
 WHERE Score.c_id = Course.c_id
 AND Course.t_id = Teacher.t_id
 AND Teacher.t_name = 'hou zi'
 GROUP BY s_id
 HAVIND COUNT(Score.c_id) = 
    (SELECT COUNT(c_id) FROM Course, Teacher
     WHERE Teacher.t_id = Course.t_id 
     AND t_name = 'hou zi')
);

######## 7. get students' name and if who has taken both course 001 and 002

SELECT Student.s_id, Student.s_name
FROM Student
JOIN Score
ON Student.s_id = Score.s_id
AND Score.c_id = '001'
AND EXISTS(SELECT * FROM Score as Score_2
           WHERE Score_2.s_id = Score.s_id
           AND Score_2.c_id = '002');

######## 8. get the total score for Course 002

SELECT SUM(s_score) AS Total_score 
FROM Score
WHERE c_id = '002';

######## 9. get all the students' id and name whose score is less than 60 in any courses

SELECT s_id, s_name
FROM Student
WHERE s_id NOT IN
(SELECT Student.s_id FROM Student,Score 
 WHERE Student.s_id = Score.s_id 
 AND s_score > 60);


######## 10. get students' id and name who hadn't taken all the courses

SELECT Student.s_id, Student.s_name
FROM Student, Score
WHERE Student.s_id = Score.s_id
GROUP BY 1, 2
HAVIND COUNT(c_id) < 
(SELECT COUNT(c_id) FROM Course);


