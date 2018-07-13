# LeetCode15_Friends_Requests_I

# Easy

/*
In social network like Facebook or Twitter, people send friend requests and accept others’ requests as well. Now given two tables as below:
Table: friend_request
| sender_id | send_to_id |request_date|
|-----------|------------|------------|
| 1         | 2          | 2016_06-01 |
| 1         | 3          | 2016_06-01 |
| 1         | 4          | 2016_06-01 |
| 2         | 3          | 2016_06-02 |
| 3         | 4          | 2016-06-09 |
Table: request_accepted
| requester_id | accepter_id |accept_date |
|--------------|-------------|------------|
| 1            | 2           | 2016_06-03 |
| 1            | 3           | 2016-06-08 |
| 2            | 3           | 2016-06-08 |
| 3            | 4           | 2016-06-09 |
| 3            | 4           | 2016-06-10 |
Write a query to find the overall acceptance rate of requests rounded to 2 decimals, which is the number of acceptance divide the number of requests.
For the sample data above, your query should return the following result.
|accept_rate|
|-----------|
|       0.80|


***If there is no requests at all, 
you should return 0.00 as the accept_rate.


Follow-up:
Can you write a query to return the accept rate but for every month?
How about the cumulative accept rate for every day?
*/

SELECT
ROUND(
    IFNULL(
    (SELECT COUNT(*) FROM (SELECT DISTINCT requester_id, accepter_id FROM request_accepted) AS A)
    /
    (SELECT COUNT(*) FROM (SELECT DISTINCT sender_id, send_to_id FROM friend_request) AS B),
    0)
, 2) AS accept_rate;

/*

1. A sender sends multiple requests to the same receiver, and a request could be accepted more than once. 
In this case, the ‘duplicated’ requests or acceptances are only counted once.

2. The total number of requests) could be '0' if the table friend_request is empty. 
So, we have to utilize ifnull to deal with this special case.

*/


# Return an alternative value IF the expression is NULL
SELECT IFNULL(NULL, "PASS");
