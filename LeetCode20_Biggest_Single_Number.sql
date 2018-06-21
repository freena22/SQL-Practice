# LeetCode20_Biggest_Single_Number

# Easy

/*

Table number contains many numbers in column num including duplicated ones.
Can you write a SQL query to find the biggest number, which only appears once.
+---+
|num|
+---+
| 8 |
| 8 |
| 3 |
| 3 |
| 1 |
| 4 |
| 5 |
| 6 | 
For the sample data above, your query should return the following result:
+---+
|num|
+---+
| 6 |

*/


SELECT MAX(num) AS num
FROM 
( 
	SELECT num, COUNT(num)
    FROM number
    GROUP BY num
    HAVING COUNT(num) <= 1
) sub;
