
######### Summary1_Subqueries ##########

### 1. In Conditional Logic (As a filter)

# a. As a standard filter

# below the average
SELECT Major, Unemployment_rate FROM recent_grads
WHERE Unemployment_rate < (SELECT AVG(Unemployment_rate) FROM recent_grads)
ORDER BY Unemployment_rate;

# 2nd highest
SELECT MAX(Salary) AS SecondHighestSalary 
FROM Employee 
WHERE Salary NOT IN 
(
	SELECT MAX(Salary) 
	FROM Employee
);

# belong to certain cateloge
SELECT name, continent
FROM world
WHERE continent IN 
( 
	SELECT continent FROM world
	WHERE name = 'Brazil' OR name = 'Mexico'
);

               # PRACTICE #

#  Show the countries in Europe with a per capita GDP greater than 'United Kingdom'

SELECT name FROM world 
WHERE continent = 'Europe' AND gdp/population > 
(
	SELECT gdp/population FROM world 
	WHERE name = 'United Kingdom'
);

# Which country has a population that is more than Canada but less than Poland? Show the name and the population
SELECT name, population FROM world 
WHERE population > (SELECT population FROM world WHERE name = 'Canada') 
AND population < (SELECT population FROM world WHERE name = 'Poland');

# Which countries have a GDP greater than every country in Europe
SELECT name FROM world 
WHERE gdp > ALL
(
	SELECT gdp FROM world 
	WHERE continent='Europe' AND gdp IS NOT NULL
);

# Select the code that shows the name, region and population of the smallest country in each region
SELECT region, name, population FROM bbc x 
WHERE population <= ALL 
(
	SELECT population FROM bbc y WHERE y.region=x.region AND population>0
);


### 2. In FROM clause

# Create a table to display the top one payer on each day

SELECT Date, memberID
FROM 
(
	SELECT Date, memberID, MAX(Amount)
    FROM Payment
    GROUP BY Date, memberID
) sub;


### 3. Join Subqueries

SELECT *
FROM sf_crime_incidents_2014 incidents
JOIN
(
    SELECT date
    FROM sf_crime_incidents_2014
    ORDER BY date
    LIMIT 5
) sub
ON incidents.date = sub.date;


### 4. Subqueries and Unions

SELECT COUNT(*) AS total_rows
FROM
(
    SELECT *
    FROM crunchbase_investments_part1

    UNION ALL

    SELECT *
    FROM crunchbase_investments_part2
) sub;




