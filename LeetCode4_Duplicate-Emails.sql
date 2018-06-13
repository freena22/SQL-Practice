# LeetCode4_Duplicate-Emails

# Easy

# Write a SQL query to find all duplicate emails in a table named Person.
#
# +----+---------+
# | Id | Email   |
# +----+---------+
# | 1  | a@b.com |
# | 2  | c@d.com |
# | 3  | a@b.com |
# +----+---------+
# For example, your query should return the following for the above table:
#
# +---------+
# | Email   |
# +---------+
# | a@b.com |
# +---------+
# Note: All emails are in lowercase.


# Select the count > 1, can see the difference between WHERE and HAVING here

# Option 1
SELECT Email
FROM (
	SELECT Email, COUNT(Email) as num
	FROM Person
	GROUP BY Email) as statistic
WHERE num > 1;




# Option 2
SELECT Email 
FROM Person
GROUP BY Email
HAVING COUNT(Email) > 1;
