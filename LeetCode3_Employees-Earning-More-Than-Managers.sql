# LeetCode3_Employees-Earning-More-Than-Managers

# Easy

# The Employee table holds all employees including their managers. Every employee has an Id, and there is also a column for the manager Id.
#
# +----+-------+--------+-----------+
# | Id | Name  | Salary | ManagerId |
# +----+-------+--------+-----------+
# | 1  | Joe   | 70000  | 3         |
# | 2  | Henry | 80000  | 4         |
# | 3  | Sam   | 60000  | NULL      |
# | 4  | Max   | 90000  | NULL      |
# +----+-------+--------+-----------+

# Given the Employee table, write a SQL query that finds out employees who earn more than their managers. For the above table, Joe is the only employee who earns more than his manager.

# +----------+
# | Employee |
# +----------+
# | Joe      |
# +----------+



############ STEP 1 ###########

SELECT *
FROM Employee AS a, Employee AS b;

/*  Cartesian product 4*4 = 16 records

Id	Name	Salary	ManagerId	Id	Name	Salary	ManagerId
1	Joe	    70000	3	        1	Joe	    70000	3
2	Henry	80000	4	        1	Joe	    70000	3
3	Sam	    60000		        1	Joe	    70000	3
4	Max	    90000		        1	Joe	    70000	3
1	Joe	    70000	3	        2	Henry	80000	4
2	Henry	80000	4	        2	Henry	80000	4
3	Sam	    60000		        2	Henry	80000	4
4	Max	    90000		        2	Henry	80000	4
1	Joe	    70000	3	        3	Sam	    60000	
2	Henry	80000	4	        3	Sam	    60000	
3	Sam	    60000		        3	Sam	    60000	
4	Max	    90000		        3	Sam	    60000	
1	Joe	    70000	3	        4	Max	    90000	
2	Henry	80000	4	        4	Max	    90000	
3	Sam	    60000		        4	Max	    90000	
4	Max	    90000		        4	Max	    90000	
> The first 3 columns are from a and the last 3 ones are from b.	

*/						


SELECT
    *
FROM
    Employee AS a,
    Employee AS b
WHERE
    a.ManagerId = b.Id
AND a.Salary > b.Salary;


/*
Id	Name	Salary	ManagerId	Id	Name	Salary	ManagerId
1	Joe	     70000	 3	        3 	Sam	    60000	
*/


# Option 1: double the table and set the link to filter
SELECT a.Name AS 'Employee'
FROM Employee AS a
     Employee As b
WHERE a.ID = b.ManagerId
AND a.Salary > b.Salary;

# Option 2: self-join 

SELECT a.Name AS Employee
FROM Employee AS a 
JOIN Employee AS b
ON a.ManagerId = b.Id. # the order should be a.ManagerID = b.ID not vice versa
AND a.Salary > b.Salary

# Find employees who are managers
SELECT DISTINCT a.Id, a.Name
FROM Employee a
JOIN Employee bon a.Id = b.ManagerId
