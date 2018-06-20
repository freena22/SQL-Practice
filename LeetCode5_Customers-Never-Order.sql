# LeetCode5_Customers-Never-Order

# <EASY>

# Suppose that a website contains two tables, the Customers table and the Orders table. 
# Write a SQL query to find all customers who never order anything.
# 
# Table: Customers.
# 
# +----+-------+
# | Id | Name  |
# +----+-------+
# | 1  | Joe   |
# | 2  | Henry |
# | 3  | Sam   |
# | 4  | Max   |
# +----+-------+
# Table: Orders.
# 
# +----+------------+
# | Id | CustomerId |
# +----+------------+
# | 1  | 3          |
# | 2  | 1          |
# +----+------------+
# Using the above tables as example, return the following:
# 
# +-----------+
# | Customers |
# +-----------+
# | Henry     |
# | Max       |
# +-----------+
#

# Option 1: subquery as filter in WHERE

SELECT Name AS Customers
FROM Customers 
WHERE id NOT IN 
(SELECT CustomerId FROM Orders);

# Option 2: JOIN and filter the NULL
SELECT Customers.Name AS Customers
FROM Customers
LEFT JOIN Orders
ON Customers.Id = Orders.Id
WHERE Order.CustomerId IS NULL

# Coding Test: Active but not payers: Create a table to display people who were active but did not pay on each day

SELECT User.Date AS Date, User.memberID AS memberID
FROM User
LEFT JOIN Payment
ON User.memberID = Payment.memberID
WHERE Payment.Amount IS NULL;

SELECT Date, memberID
FROM User
WHERE memberID NOT IN 
(SELECT memberID FROM Orders);




