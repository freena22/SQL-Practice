######## Practical Problems ############

# 1. Counting what isn’t there

-- The "programs" table gives the name of each program and the files
-- that it's made of.  The "bugs" table gives the file in which each
-- bug was found.
--
-- create table programs (
--    name text,
--    filename text
-- );
-- create table bugs (
--    filename text,
--    description text,
--    id serial primary key
-- );
--
-- The query below is intended to count the number of bugs in each
-- program. IF Use a Inner JOin, it doesn't return a row for any program that has zero
-- bugs. Thus, use LEFT JOIN and ALSO COUNT(bugs.id) Rather than COUNT(*)

# COUNT(*) will ignore the NULL 

SELECT programs.name, count(bugs.id) as num
FROM programs 
LEFT JOIN bugs
ON programs.filename = bugs.filename
GROUP BY programs.name
ORDER BY num;


# 2. Subquery

# Average highest-scorer's score

SELECT AVG(bigscore)
FROM
(
SELECT MAX(score) AS bigscore
FROM mooseball
GROUP BY tea
) as maxes;

# 3. View -- A View is a select query stored in the database in a way that
#            lets you use it like a table

-- Here's a select statement that runs on the zoo database.
-- It selects the species with the top five highest populations in the zoo.
-- Change it into a statement that creates a view named "topfive".

CREATE VIEW topfive AS  # Add this line
select species, count(*) as num 
  from animals
  group by species
  order by num desc
  limit 5;
