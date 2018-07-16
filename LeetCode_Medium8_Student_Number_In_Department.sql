# LeetCode_Medium8_Student_Number_In_Department

# Medium -- Twitter

/*
A university uses 2 data tables, student and department, to store data about its students and the departments associated with each major.

Write a query to print the respective department name and number of students majoring in each department for all departments in the department table (even ones with no current students).

Sort your results by descending number of students; if two or more departments have the same number of students, then sort those departments alphabetically by department name.

student table:

| student_id | student_name | gender | dept_id |
|------------|--------------|--------|---------|
| 1          | Jack         | M      | 1       |
| 2          | Jane         | F      | 1       |
| 3          | Mark         | M      | 2       |

department table:

| dept_id | dept_name   |
|---------|-------------|
| 1       | Engineering |
| 2       | Science     |
| 3       | Law         |

he Output should be:

| dept_name   | student_number |
|-------------|----------------|
| Engineering | 2              |
| Science     | 1              |
| Law         | 0              |
*/

SELECT 
    department.dept_name AS dept_name, 
    COUNT(student.student_id) AS student_number
FROM student
RIGHT JOIN department
ON student.student_id = department.dept_id
GROUP BY 1
ORDER BY student_number DESC, dept_name;

# USE right join for all departments even with 0 students in their


