# LeetCode14_Classes_More_Than_5_Students

# Easy







SELECT class 
FROM courses
GROUP BY class
HAVING COUNT(DISTINCT student) >= 5;

# Tick point: Use DISTINCT here since the student name may duplicated in a class