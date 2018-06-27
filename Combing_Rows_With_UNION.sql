# Combing Rows With UNION

# snytax
[select_statement_one]
UNION
[select_statement_two]

# Tables should have the same number of columns and compatible types

# Example: Table 1 - customer_usa
#          Table 2 - customer_gt_90_dollars


# Customers who are in the USA or have spent more than $90 (OR)
# UNION -- selects rows that occur in either statement
SELECT * from customer_usa
UNION
SELECT * from customer_gt_90_dollars;

# Customers who are in the USA and have spent more than $90 (AND)
# INTERSECT -- Selects rows that occur in both statements
SELECT * from customer_usa
INTERSECT
SELECT * from customer_gt_90_dollars;

# Customers who are in the USA and have not spent more than $90 (AND NOT)
# EXCEPT -- Selects rows that occur in the first statement, but don't occur in the second statement.
SELECT * from customer_usa
EXCEPT
SELECT * from customer_gt_90_dollars;