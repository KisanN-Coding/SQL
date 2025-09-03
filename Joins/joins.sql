-- Joins in SQL 

CREATE DATABASE IF NOT EXISTS my_database;

USE my_database;

-- Seeing the data

SELECT * FROM students;

SELECT * FROM class;

SELECT * FROM my_database.groups;

SELECT * FROM category;

SELECT * FROM membership;

SELECT * FROM orders;
SELECT * FROM order_details;

SELECT * FROM users;
SELECT * FROM users1;

SELECT * FROM person1;
SELECT * FROM person2;

-- -------------------------------------------------------------------------

-- Cross Join

SELECT * FROM users1 t1
CROSS JOIN my_database.groups t2;

-- --------------------------------------------------------------

-- Inner Join

SELECT * FROM membership t1
INNER JOIN users1 t2
ON t1.user_id = t2.user_id;

-- Left Join 

SELECT * FROM membership t1
LEFT JOIN users1 t2
ON t1.user_id = t2.user_id;

-- Right Join

SELECT * FROM membership t1
RIGHT JOIN users1 t2
ON t1.user_id = t2.user_id;

-- Set Operations in sql

-- 1 ) Union

SELECT *FROM person1
UNION
SELECT *FROM person2;

-- 2 ) Union All

SELECT *FROM person1
UNION ALL
SELECT *FROM person2;

-- Now Full Outer Join 

SELECT * FROM membership t1
LEFT JOIN users1 t2
ON t1.user_id = t2.user_id
UNION
SELECT * FROM membership t1
RIGHT JOIN users1 t2
ON t1.user_id = t2.user_id;

-- Self Join

SELECT * FROM users1 t1
JOIN users1 t2
ON t1.emergency_contact = t2.user_id;

-- -------------------------------------------------------------------------------

-- Joining on more than one column

SELECT * FROM students t1
JOIN class t2
ON t1.class_id = t2.class_id
AND t1.enrollment_year = t2.class_year;


-- Joining on more than two tables
-- And Filtering the columns

SELECT t1.order_id id, t2.order_date date, t3.name, t3.state, t3.city
FROM order_details t1
JOIN orders t2
ON t1.order_id = t2.order_id
JOIN users t3
ON t2.user_id = t3.user_id;

-- Filtering the rows 

-- Find all order placed in pune

SELECT t1.order_id, t1.order_date, t2.name, t2.city 
FROM orders t1 
JOIN users t2
ON t1.user_id = t2.user_id
WHERE t2.city = 'Pune';

-- Find all orders under chair category

SELECT t1.order_id, t2.category_id, t2.category, t2.vertical
FROM order_details t1
JOIN category t2
WHERE t2.category = 'Chairs';

-- Practice Questions 

-- Q1 ) Find all profitable orders

SELECT t1.order_id, SUM(t1.profit) AS 'Profit' 
FROM order_details t1
JOIN orders t2
GROUP BY t1.order_id
HAVING Profit > 0
ORDER BY Profit DESC;


-- Q2 ) Find the customer who has placed the max number of orders

SELECT t2.name, COUNT(*) AS 'Num_orders'
FROM orders t1
JOIN users t2
ON t1.user_id = t2.user_id
GROUP BY t2.name
ORDER BY Num_orders DESC LIMIT 1;

-- Q3) Which is most profitable category

SELECT t2.category, SUM(t1.profit) AS 'total_profit'
FROM order_details t1
JOIN category t2 
ON t1.category_id = t2.category_id
GROUP BY t2.category
ORDER BY total_profit DESC LIMIT 1;

