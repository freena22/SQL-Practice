
### Basic SQL Practice

## < Intro to SQL >

# SELECT FROM / WHERE

SELECT Major, Major_category, Median, ShareWomen FROM recent_grads
WHERE ShareWomen >= 0.5 AND Median > 50000;
 
# SELECT FROM / WHERE / AND / OR
SELECT Major, Major_category, ShareWomen, Unemployment_rate FROM recent_grads
WHERE (Major_category = 'Engineering') AND (ShareWomen > 0.5 OR Unemployment_rate < 0.051);

# SELECT FROM / WHERE / OR / ORDER BY 
SELECT Major_category, Major, Unemployment_rate FROM recent_grads
WHERE Major_category='Engineering' OR Major_category='Physical Sciences'
ORDER BY Unemployment_rate ASC;

## < Summary Statistics >

# COUNT() / SUM() 
SELECT COUNT(Major), SUM(Total) FROM recent_grads WHERE ShareWomen < 0.5;

# AVG() / MIN() / MAX()
SELECT AVG(Total), MIN(Men), MAX(Women) FROM recent_grads;

# COUNT(DISTINCT())
SELECT COUNT(DISTINCT (Major)) unique_majors, COUNT(DISTINCT(Major_code)) unique_major_codes 
FROM recent_grads;

# Aliases
SELECT COUNT(*) "Number of Students", MAX(Unemployment_rate) "Highest Unemployment Rate" FROM recent_grads;

# Largest Spread between 25th and 75th percentile
SELECT Major, Major_category, (P75th - P25th) quartile_spread
FROM recent_grads ORDER BY quartile_spread LIMIT 20;

## < Group Summary Statistics >


# Group By

SELECT Major_category, AVG(Employed) / AVG(Total) share_employed
FROM recent_grads
GROUP BY Major_category;

# Having and Where

# The HAVING clause was added to SQL because the WHERE keyword could not be used with aggregate functions. 
# that is, to the rows in the result set representing groups, whereas the WHERE clause applies to individual rows
# WHERE comes before GROUP BY; SQL evaluates the WHERE clause before it groups records.

SELECT Major_category, AVG(Low_wage_jobs) / AVG(Total) AS share_low_wage FROM recent_grads
GROUP BY Major_category
HAVING share_low_wage > 0.1;

# Round
SELECT ROUND(ShareWomen, 2), Major_category
FROM recent_grads
LIMIT 10;

# Nesting Function
SELECT Major_category, ROUND(AVG(College_jobs) / AVG(Total), 3) AS share_degree_jobs
FROM recent_grads
GROUP BY Major_category
HAVING share_degree_jobs < 0.3;

# Casting -- transfer the interger to float
SELECT CAST(Women as Float) / CAST(Total as Float) FROM recent_grads limit 5

## < Subqueries >

SELECT Major, Unemployment_rate FROM recent_grads
WHERE Unemployment_rate < (SELECT AVG(Unemployment_rate) FROM recent_grads)
ORDER BY Unemployment_rate;

# computes the proportion (as a float value) of rows that contain above average values for the ShareWomen.
SELECT CAST(COUNT(*) as float)/ CAST((SELECT COUNT(*) FROM recent_grads) as float) proportion_abv_avg
FROM recent_grads
WHERE ShareWomen > (SELECT AVG(ShareWomen) FROM recent_grads);

# Major_category is one of the 5 highest group level sums for the Total column
SELECT Major, Major_category FROM recent_grads
WHERE Major_category IN (select Major_category from recent_grads
group by Major_category
order by SUM(Total) DESC
limit 5);


## < JOIN >


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



## < CASE WHEN >

SELECT id, account_id, standard_amt_usd/standard_qty AS unit_price
FROM orders
LIMIT 10;

# -- transfer to this kind query

SELECT account_id, CASE WHEN standard_qty = 0 OR standard_qty IS NULL THEN 0
                        ELSE standard_amt_usd/standard_qty END AS unit_price
FROM orders
LIMIT 10;

# More complicated and grouping aggregation

SELECT a.name, SUM(total_amt_usd) total_spent, 
     CASE WHEN SUM(total_amt_usd) > 200000 THEN 'top'
     WHEN  SUM(total_amt_usd) > 100000 THEN 'middle'
     ELSE 'low' END AS customer_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id 
GROUP BY a.name
ORDER BY 2 DESC;


## < Subqueries & Temporary Table > -- AS a filter

SELECT AVG(standard_qty) as standard, AVG(gloss_qty) as gloss, AVG(poster_qty) as poster, 
FROM orders
WHERE DATE_TRUNC('month',occurred_at) = 
(SELECT MIN(DATE_TRUNC('month', occurred_at))
FROM Orders) AND DATE_TRUNC('year', occurred_at) = (SELECT MIN(DATE_TRUNC('year', occurred_at))
FROM Orders)

# WITH
WITH events AS (
          SELECT DATE_TRUNC('day',occurred_at) AS day, 
                        channel, COUNT(*) as events
          FROM web_events 
          GROUP BY 1,2)

SELECT channel, AVG(events) AS average_events
FROM events
GROUP BY channel
ORDER BY 2 DESC;

## < Using subquery as a filter before JOIN >

# a common join to find the capital_city in country table
SELECT c.name AS capital_city, f.name AS country, c.population
FROM cities c JOIN facts f ON c.facts_id = f.id
WHERE c.capital = 1
ORDER BY 3 DESC
LIMIT 10;

# use subquery filter the city first then join 
SELECT c.name AS capital_city, f.name AS country, c.population
FROM facts f 
JOIN (
      SELECT * FROM cities
      WHERE capital = 1 AND population > 10000000
     ) c ON c.facts_id = f.id
ORDER BY 3 DESC;

## < SQL Data Cleaning >

# LEFT & RIGHT & LENGTH -- pull the number of characters 
LEFT(phone_number, 3) -- area code
RIGHT(phone_number, 8) -- phone number
LENGTH(phone_number)  -- number of characters for each row 






