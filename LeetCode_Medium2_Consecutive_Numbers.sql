
# LeetCode_Medium2_Consecutive_Numbers

# Medium

/*
Write a SQL query to find all numbers that appear at least three times consecutively.

+----+-----+
| Id | Num |
+----+-----+
| 1  |  1  |
| 2  |  1  |
| 3  |  1  |
| 4  |  2  |
| 5  |  1  |
| 6  |  2  |
| 7  |  2  |
+----+-----+
For example, given the above Logs table, 1 is the only number that appears consecutively for at least three times.

+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+

*/ 

# 2*3 = 6 New Table 

SELECT *
FROM
    Logs l1,
    Logs l2,
    Logs l3
WHERE
    l1.Id = l2.Id - 1
    AND l2.Id = l3.Id - 1
    AND l1.Num = l2.Num
    AND l2.Num = l3.Num

# Output:

Id	Num	Id	Num	Id	Num
1   1   2   1   3   1


# Answer:

SELECT DISTINCT l1.Num AS ConsecutiveNums # DISTINCT 
FROM logs l1, logs l2, logs l3
WHERE l1.Id = l2.Id - 1
AND l2.Id = l3.Id - 1
AND l1.Num = l2.Num
AND l2.Num = l3.Num;

# Similar LeetCode Easy Consecutive Available Seats

SELECT DISTINCT a.seat_id
FROM cinema a 
JOIN cinema b
ON abs(a.seat_id - b.seat_id) = 1 # dislocate join 
AND a.free = 1 
AND b.free = 1
ORDER BY a.seat_id;





