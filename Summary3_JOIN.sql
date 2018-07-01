
######### Summary3_JOIN ##########


### 1. Multiple Joins

# Three Tables Join
SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
ORDER BY a.name;

# Four Tables Join
SELECT r.name region, a.name account, 
       o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id;


### 2. JOIN Using WHERE or ON

# a. Filtering in the ON clause

/*
the conditional statement AND... is evaluated before the join occurs. 
You can think of it as a WHERE clause that only applies to one of the tables. 
You can tell that this is only happening in one of the tables because the 1000memories permalink is still displayed 
in the column that pulls from the other table.

*/

SELECT companies.permalink AS companies_permalink,
       companies.name AS companies_name,
       acquisitions.company_permalink AS acquisitions_permalink,
       acquisitions.acquired_at AS acquired_date
FROM tutorial.crunchbase_companies companies
LEFT JOIN tutorial.crunchbase_acquisitions acquisitions
ON companies.permalink = acquisitions.company_permalink
AND acquisitions.company_permalink != '/company/1000memories'
ORDER BY 1



 # b. Filtering in the WHERE clause

SELECT companies.permalink AS companies_permalink,
       companies.name AS companies_name,
       acquisitions.company_permalink AS acquisitions_permalink,
       acquisitions.acquired_at AS acquired_date
FROM tutorial.crunchbase_companies companies
LEFT JOIN tutorial.crunchbase_acquisitions acquisitions
ON companies.permalink = acquisitions.company_permalink
WHERE acquisitions.company_permalink != '/company/1000memories'
OR acquisitions.company_permalink IS NULL
ORDER BY 1

/*
If move the same filter to the WHERE clause, the filter happens after the tables are joined.
The result is that the 1000memories row is joined onto the original table, 
but then it is filtered out entirely (in both tables) in the WHERE clause before displaying results.
*/



### 3. Self Join


/*
-- In somem cases, where you want to join a table to it's self
For instance to find pairs of entries that have something in common. 
Example:
There is a table Residences
+-------------+-----------+--------+
| id          | building  | room   |         
+-------------+-----------+--------+
| 4130001     | Crosby    | 10     |
| 1161282     | Dolliver  | 7      |
| 881256      | Crosby    | 10     |
| 231742      | kedrick   | 3B     |
| 104131      | Dolliver  | 14     |
| 612412      | Crosby    | 31     |
+-------------+-----------+--------+
To find out which students are roommates; find pairs of roommates? 
*/

# The basic query but with some bugs
SELECT a.id, b.id, a.building, a.room
FROM Residences a, Residences b
WHERE a.building = b.building
AND a.room = b.room
ORDER BY a.building, a.room;

/* Output
+--------+--------+----------+------+
|     id |     id | building | room |
+========+========+==========+======+
| 413001 | 413001 |   Crosby |   10 |
| 413001 | 881256 |   Crosby |   10 |
| 881256 | 413001 |   Crosby |   10 |
| 881256 | 881256 |   Crosby |   10 |
| 496747 | 496747 |   Crosby |   19 |
| 496747 | 741532 |   Crosby |   19 |
| 741532 | 496747 |   Crosby |   19 |
| 741532 | 741532 |   Crosby |   19 |
| 410315 | 410315 |   Crosby |   20 |
| 498446 | 498446 |   Crosby |   21 |
| 851866 | 851866 |   Crosby |   22 |
| 612413 | 612413 |   Crosby |   31 |
| 612413 | 931027 |   Crosby |   31 |
# bug: it lists each pair of roommates twice in alternating order
*/


SELECT a.id, b.id, a.building, a.room
FROM Residences a, Residences b
WHERE a.building = b.building
AND a.room = b.room
AND a.id > b.id # eliminate the rows where they're equal, the same student
ORDER BY a.building, a.room;

/* Output
+--------+--------+----------+------+
|     id |     id | building | room |
+========+========+==========+======+
| 881256 | 413001 |   Crosby |   10 |
| 741532 | 496747 |   Crosby |   19 |
| 931027 | 612413 |   Crosby |   31 |
| 958827 | 170267 | Dolliver |    1 |
| 707536 | 104131 | Dolliver |   14 |
| 505241 | 477801 | Dolliver |    8 |
| 824292 | 118199 | Kendrick |   1A |
| 231742 | 105540 | Kendrick |   3B |
+--------+--------+----------+------+
*/


           ###### Practice #########

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


SELECT a.Name AS Employee
FROM Employee AS a 
JOIN Employee AS b
ON a.ManagerId = b.Id.
AND a.Salary > b.Salary
