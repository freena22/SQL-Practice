# LeetCode_Medium14_Shortest_Distance_In_Plane

# Medium - Twitter

/*

Table point_2d holds the coordinates (x,y) of some unique points (more than two) in a plane.
Write a query to find the shortest distance between these points rounded to 2 decimals.
| x  | y  |
|----|----|
| -1 | -1 |
| 0  | 0  |
| -1 | -2 |

The shortest distance is 1.00 from point (-1,-1) to (-1,2). So the output should be:
| shortest |
|----------|
| 1.00     |

Note: The longest distance among all the points are less than 10000.
*/


SELECT
    ROUND(SQRT(MIN((POW(p1.x - p2.x, 2) + POW(p1.y - p2.y, 2)))), 2) AS shortest
FROM
    point_2d p1
JOIN
    point_2d p2 
ON p1.x != p2.x OR p1.y != p2.y
;


# Step by step 
# self-join and use built-in function POW() and SQRT() to get the euclidean distance between two points 
SELECT
    p1.x,
    p1.y,
    p2.x,
    p2.y,
    SQRT((POW(p1.x - p2.x, 2) + POW(p1.y - p2.y, 2))) AS distance
FROM
    point_2d p1
        JOIN
    point_2d p2 ON p1.x != p2.x OR p1.y != p2.y
;

/*
So the output would be as below after running this code

| x  | y  | x  | y  | distance           |
|----|----|----|----|--------------------|
| 0  | 0  | -1 | -1 | 1.4142135623730951 |
| -1 | -2 | -1 | -1 | 1                  |
| -1 | -1 | 0  | 0  | 1.4142135623730951 |
| -1 | -2 | 0  | 0  | 2.23606797749979   |
| -1 | -1 | -1 | -2 | 1                  |
| 0  | 0  | -1 | -2 | 2.23606797749979   |

*/


