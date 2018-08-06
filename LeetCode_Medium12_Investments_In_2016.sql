# LeetCode_Medium12_Investments_In_2016

# Medium - Twitter

/*
Write a query to print the sum of all total investment values in 2016 (TIV_2016), to a scale of 2 decimal places, for all policy holders who meet the following criteria:

1. Have the same TIV_2015 value as one or more other policyholders.
2. Are not located in the same city as any other policyholder (i.e.: the (latitude, longitude) attribute pairs must be unique).
Input Format:


The insurance table is described as follows:

| Column Name | Type          |
|-------------|---------------|
| PID         | INTEGER(11)   |
| TIV_2015    | NUMERIC(15,2) |
| TIV_2016    | NUMERIC(15,2) |
| LAT         | NUMERIC(5,2)  |
| LON         | NUMERIC(5,2)  |
where PID is the policyholder's policy ID, TIV_2015 is the total investment value in 2015, TIV_2016 is the total investment value in 2016, LAT is the latitude of the policy holder's city, and LON is the longitude of the policy holder's city.

Sample Input

| PID | TIV_2015 | TIV_2016 | LAT | LON |
|-----|----------|----------|-----|-----|
| 1   | 10       | 5        | 10  | 10  |
| 2   | 20       | 20       | 20  | 20  |
| 3   | 10       | 30       | 20  | 20  |
| 4   | 10       | 40       | 40  | 40  |

Sample Output

| TIV_2016 |
|----------|
| 45.00    |


The result is the sum of TIV_2016 of the first and last record, which is 45.


*/


SELECT
    SUM(insurance.TIV_2016) AS TIV_2016
FROM
    insurance
WHERE insurance.TIV_2015 IN
(
    SELECT TIV_2015
    FROM insurance
    GROUP BY TIV_2015
    HAVING COUNT(*) > 1  # meet 1st criteria
)
AND CONCAT(LAT, LON) IN
(
      SELECT CONCAT(LAT, LON)
      FROM insurance
      GROUP BY LAT , LON
      HAVING COUNT(*) = 1  # meet 2nd criteria
);

