
### SELECT within SELECT Practice####


# List each country in the same continent as 'Brazil'

SELECT name FROM world WHERE continent = (SELECT continent 
FROM world WHERE name = 'Brazil')

# Alias: 

SELECT name FROM world WHERE continent = (SELECT continent 
FROM world WHERE name = 'Brazil') AS brazil_continent;

# Multiple Results: When subquery return more than one results the query above will fail. Use IN 

SELECT name, continent FROM world WHERE continent IN (SELECT continent FROM world WHERE name = ‘Brazil’ OR name = ‘Mexico’)

# Show the population of China as a multiple of the population of the United Kingdom:
	

SELECT population / (SELECT population FROM world
WHERE name='United Kingdom') FROM world WHERE name = 'China'

# Show each country that has a population greater than the population of ALL countries in Europe. 

SELECT name FROM world WHERE population > ALL (SELECT population FROM world WHERE continent='Europe')

# Show the countries in Europe with a per capita GDP greater than 'United Kingdom'

SELECT name FROM world WHERE continent = 'Europe' AND gdp/population > (SELECT gdp/population FROM world WHERE name = 'United Kingdom');

# List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.
SELECT name, continent FROM world 
WHERE continent IN (SELECT continent FROM world WHERE name IN ('Argentina', 'Australia'))
ORDER BY name;

# Which country has a population that is more than Canada but less than Poland? Show the name and the population
SELECT name, population FROM world 
WHERE population > (SELECT population FROM world WHERE name = 'Canada') 
AND population < (SELECT population FROM world WHERE name = 'Poland');

# Which countries have a GDP greater than every country in Europe
SELECT name FROM world 
WHERE gdp > ALL(SELECT gdp FROM world WHERE continent='Europe' AND gdp IS NOT NULL);

SELECT Salary FROM Table 
WHERE Salary < (SELECT salary FROM Table ORDER by Salary DESC )

# Select the code that shows the name, region and population of the smallest country in each region
SELECT region, name, population FROM bbc x 
WHERE population <= ALL (SELECT population FROM bbc y WHERE y.region=x.region AND population>0)

