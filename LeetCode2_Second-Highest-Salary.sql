
# <EASY> 

# Write a SQL query to get the second highest salary from the Employee table.
#
# +----+--------+
# | Id | Salary |
# +----+--------+
# | 1  | 100    |
# | 2  | 200    |
# | 3  | 300    |
# +----+--------+
# For example, given the above Employee table, the second highest salary is 200. 
# If there is no second highest salary, then the query should return null.

# Write your MySQL query statement below


SELECT MAX(Salary) AS SecondHighestSalary 
FROM Employee 
WHERE Salary NOT IN 
(
	SELECT MAX(Salary) 
	FROM Employee
);

SELECT MAX(Salary) AS SecondHighestSalary
FROM Employee
WHERE Salary < (
    SELECT MAX(Salary)
    FROM Employee
    );

######### Error ########

SELECT MAX(Salary) AS SecondHighestSalary 
FROM Employee 
WHERE MAX(Salary) NOT IN   # not need to use MAX() and more important no aggregation in WHERE!
(
	SELECT MAX(Salary) 
	FROM Employee
);




# Other Option with LIMIT
SELECT (
	SELECT Salary FROM Employee GROUP BY Salary ORDER BY Salary DESC LIMIT 1,1
	   ) SecondHighestSalary;

# or
SELECT (
    SELECT DISTINCT salary FROM Employee
    ORDER BY salary DESC
    LIMIT 1 OFFSET 1) AS SecondHighestSalary;

    