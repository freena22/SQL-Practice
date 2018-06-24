# Relational Database and SQL Knowledge
-----

#### Rules for normalized tables:
1. Every row has the same number of columns.
In practice, the database system won't let us literally have different numbers of columns in different rows. But if we have columns that are sometimes empty (null) and sometimes not, or if we stuff multiple values into a single field, we're bending this rule.

The example to keep in mind here is the diet table from the zoo database. Instead of trying to stuff multiple foods for a species into a single row about that species, we separate them out. This makes it much easier to do aggregations and comparisons.

2. There is a unique key and everything in a row says something about the key.
The key may be one column or more than one. It may even be the whole row, as in the diet table. But we don't have duplicate rows in a table.

More importantly, if we are storing non-unique facts — such as people's names — we distinguish them using a unique identifier such as a serial number. This makes sure that we don't combine two people's grades or parking tickets just because they have the same name.

3. Facts that don't relate to the key belong in different tables.
The example here was the items table, which had items, their locations, and the location's street addresses in it. The address isn't a fact about the item; it's a fact about the location. Moving it to a separate table saves space and reduces ambiguity, and we can always reconstitute the original table using a join.

4. Tables shouldn't imply relationships that don't exist.
The example here was the job_skills table, where a single row listed one of a person's technology skills (like 'Linux') and one of their language skills (like 'French'). This made it look like their Linux knowledge was specific to French, or vice versa ... when that isn't the case in the real world. Normalizing this involved splitting the tech skills and job skills into separate tables.


#### SQL Data Structure
##### Text and string types
- text — a string of any length, like Python str or unicode types.
- char(n) — a string of exactly n characters.
- varchar(n) — a string of up to n characters.
##### Numeric types
- integer — an integer value, like Python int.
- real — a floating-point value, like Python float. Accurate up to six decimal places.
- double precision — a higher-precision floating-point value. Accurate up to 15 decimal places.
- decimal — an exact decimal value.
##### Date and time types
- date — a calendar date; including year, month, and day.
- time — a time of day.
- timestamp — a date and time together.

#### See the tables in different environments
```sh
PostgreSQL: \dt and \d tablename
MySQL: show tables and describe tablename
SQLite: .table and .schema tablename
```
### SQLite 
#### Environment Set Up
```sh
$  sqlite3 chinook.db  # use the database
sqlite>
```
#### Basic Commands
```sh
- sqlite> .help
- sqlite> .tables    # see what tables are in your database
- sqlite> .schema Album  # see the schema of your tables (datatype,primary key, foreign key
- sqlite> .exit
```
#### Using SQLite3 in Python
```sh
# Making Connection
import sqlite3
conn = sqlite3.connect('jobs.db')
# Creating A Cursor And Running A Query
cursor = conn.cursor()  
query = "SELECT * FROM recent_grads;"  # SQL query as a string
cursor.execute(query) # Execute the query, covert the results to tuples and store as a local varaible
# Save (commit) the changes  b
conn.commit()
results = cursor.fetchall()  # Fetch the full results set as a list of tuples
print(results[0:3])
# fetchone() and fetchmany()
cursor.execute(query)
first_result = cursor.fetchone()
five_results = cursor.fetchmany(5)  
# Closing the Database Connection
conn.close()   

# Practice 1
data = sqlite3.connect('jobs.db')
query='SELECT Major FROM recent_grads ORDER BY Major desc;'
result = data.cursor().execute(query).fetchall()
data.close()
# Practice 2
conn = sqlite3.connect('factbook.db')
birth_rate_tuple = conn.execute('SELECT COUNT(birth_rate) FROM facts;').fetchall()
birth_rate_count = birth_rate_tuple[0][0]
print(birth_rate_count)
# Pandas
pd.read_sql_query()

# Inserts new rowa in DB-API

import sqlite3

db = sqlite3.connect("testdb")
c = db.cursor()
c.execute("insert into balloons values ('blue', 'water') ")
db.commit()  # a commit call
db.close()

```

### PostgreSQL
```sh
# "Database code" for the DB Forum.

import datetime

import psycopg2

DBNAME = 'forum'


POSTS = [("This is the first post.", datetime.datetime.now())]

def get_posts():
  db = psycopg2.connect(database=DBNAME)
  c = db.cursor()
  c.execute('SELECT content, time FROM posts ORDER BY time DESC')
  db.close()
  return c.fetchall()


def add_post(content):
	db = psycopg2.connect(database=DBNAME)
	c = db.cursor()
	c.execute("INSERT INTO posts VALUES (%s)", (content,))
	# a safe way to insert the content
	# NEVER NEVER USE python string '+' or '%' to pass variables 
	# into a SQL query string. 
	db.commit()
	db.close() 

```


#### Basic SQL Sytax
```sh
QUERT = '''
SELECT ordernames.name, COUNT(*) as num
FROM taxonomy, animals, ordernames
WHERE animals.species = taxonomy.name AND taxonomy.t_order = ordernames.t_order
GROUP BY odernames.name
ORDER BY odernames.name desc;
```

```sh
** WHERE is a restriction on the source tables (execute first)
** HAVING is a restriction on the result ... after aggregation, which means. filter on a column generated by a query.
```
#### Database 
Chinook Database - https://chinookdatabase.codeplex.com/releases/view/55681

