
######### Summary2_Case_When ##########

### 1. Self Catalogue

SELECT school, sat_math,
CASE
    WHEN sat_math > 700 THEN "High"
    WHEN sat_math > 500 THEN 'Medium'
    WHEN sat_math < 500 THEN 'Low'
    ELSE "Outliers"
END AS math_level
FROM sat_scores;


### 2. Multiple Catelogue

SELECT account_id, 
CASE 
    WHEN standard_qty = 0 OR standard_qty IS NULL THEN 0
    ELSE standard_amt_usd/standard_qty 
    END AS unit_price
    # AS a new colomn nama
FROM orders
LIMIT 10;

### 3. Aggregation Catelogue

SELECT a.name, SUM(total_amt_usd) total_spent, 
     CASE WHEN SUM(total_amt_usd) > 200000 THEN 'top'
     WHEN  SUM(total_amt_usd) > 100000 THEN 'middle'
     ELSE 'low' 
     END AS customer_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id 
GROUP BY a.name
ORDER BY 2 DESC;