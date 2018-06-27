
############ Building_Complex_Queries ###########

# 1. With Clause -- temporary named subquery use ONLY within the query

WITH playlist_info AS
    (
     SELECT 
        p.playlist_id AS playlist_id,
        p.name AS playlist_name,
        t.name AS track_name,
        (t.milliseconds / 1000) AS length_seconds
     FROM playlist p
     LEFT JOIN playlist_track pl ON p.playlist_id = pl.playlist_id
     LEFT JOIN track t ON pl.track_id = t.track_id
     )
     
SELECT 
    playlist_id, 
    playlist_name, 
    COUNT(track_name) AS number_of_tracks,
    SUM(length_seconds) AS length_seconds
FROM playlist_info
GROUP BY 1,2
ORDER BY 1;

# Once aggregation function appears, it follows with GROUP BY!!!

# 2. Multiple Named Subqueries

WITH
    usa AS
        (
        SELECT * FROM customer
        WHERE country = "USA"
        ),
    last_name_g AS
        (
         SELECT * FROM usa
         WHERE last_name LIKE "G%"
        ),
    state_ca AS
        (
        SELECT * FROM last_name_g
        WHERE state = "CA"
        )

SELECT
    first_name,
    last_name,
    country,
    state
FROM state_ca


# 3. Creating Views -- permanently define a subquery that we can use in all future queries

CREATE VIEW 
database.view_name AS
    SELECT * FROM 
database.table;

CREATE VIEW 
chinook.customer_usa AS 
     SELECT * FROM 
chinook.customer
     WHERE country = "USA";

CREATE VIEW chinook.customer_gt_90_dollars AS 
    SELECT
        c.*
    FROM chinook.invoice i
    INNER JOIN chinook.customer c ON i.customer_id = c.customer_id
    GROUP BY 1
    HAVING SUM(i.total) > 90;
# error: WHERE i.total > 90; customers could have multiple orders





