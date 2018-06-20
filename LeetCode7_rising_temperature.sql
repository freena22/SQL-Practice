# LeetCode6_rising_temperature

# Easy

# Given a Weather table, write a SQL query to find all dates'Ids 
# with higher temperature compared to its previous (yesterday's) dates.
# 
# +---------+------------+------------------+
# | Id(INT) | Date(DATE) | Temperature(INT) |
# +---------+------------+------------------+
# |       1 | 2015-01-01 |               10 |
# |       2 | 2015-01-02 |               25 |
# |       3 | 2015-01-03 |               20 |
# |       4 | 2015-01-04 |               30 |
# +---------+------------+------------------+
# For example, return the following Ids for the above Weather table:
# +----+
# | Id |
# +----+
# |  2 |
# |  4 |
# +----+
#

# Option 1: 
SELECT w1.id AS Id
FROM Weather w1, Weather w2
WHERE w1.Temperature > w2.Temperature 
AND TO_DAYS(w1.DATE)- TO_DAYS(w2.DATE)=1;

# My answer 
SELECT a.Id
FROM Weather a
JOIN Weather b
ON a.Temperature > b.Temperature
AND TO_DAYS(a.RecordDate) = TO_DAYS(b.RecordDate) + 1;

# 1. Need use TO_DATE to transform the date format
# 2. OPTION 1 has no join thus more effecient 