# LeetCode14_Classes_More_Than_5_Students

# Easy
/*
There is a table courses with columns: student and class

Please list out all classes which have more than or equal to 5 students.

For example, the table:

+---------+------------+
| student | class      |
+---------+------------+
| A       | Math       |
| B       | English    |
| C       | Math       |
| D       | Biology    |
| E       | Math       |
| F       | Computer   |
| G       | Math       |
| H       | Math       |
| I       | Math       |
+---------+------------+
Should output:

+---------+
| class   |
+---------+
| Math    |
+---------+

*/



SELECT class 
FROM courses
GROUP BY class
HAVING COUNT(DISTINCT student) >= 5;

# Tick point: Use DISTINCT here since the student name may duplicated in a class

# complex answer of mine

SELECT class
FROM
(SELECT class, COUNT(DISTINCT student) as num
FROM courses
GROUP BY class
HAVING num >= 5 ) sub;