USE my_database;

-- Creating a marks table and inserting values in it

CREATE TABLE marks(
      name VARCHAR(255),
      branch VARCHAR(255),
      marks INTEGER
      );
      
INSERT INTO marks (name,branch,marks)VALUES 
('Kisan','AI',82),
('Krushna','AI',91),
('Rohan','AI',69),
('Bhavesh','AI',55),
('Shubham','CSE',78),
('Arjun','CSE',43),
('Kartik','CSE',98),
('Achyut','CSE',95),
('Chaitanya','DS',95),
('Kiran','DS',88),
('Faizan','DS',95),
('Sahil','MECH',75),
('Omkar','MECH',69),
('Sohan','MECH',39),
('Abhi','MECH',51);

-- -----------------------------------------------------------------------------------------------

-- Simple Examples of Window function (Using OVER())

-- Example 1

SELECT branch,AVG(marks) OVER(PARTITION BY branch) FROM marks;

-- Example 2

SELECT *,MIN(marks) OVER() AS 'Min_marks', 
MAX(marks) OVER() AS 'Max_marks' 
FROM marks;

-- --------------------------------------------------------------------------------------------

-- Aggregate Function with OVER() 

-- Question

-- Find all the students who have marks higher than avg marks of their respective branch

SELECT * FROM (SELECT *,
               AVG(marks) OVER(PARTITION BY branch) AS 'branch_average'
               FROM marks) t
WHERE t.marks > branch_average;

-- --------------------------------------------------------------------------------------------

-- RANK , DENSE_RANK , ROW_NUMBER (Windows Functions)

-- Examples : 

-- RANK

SELECT * ,
RANK() OVER(PARTITION BY branch ORDER BY marks DESC) AS 'Rank'
FROM marks;

-- DENSE_RANK

SELECT * ,
RANK() OVER(PARTITION BY branch ORDER BY marks DESC) AS 'Rank',
DENSE_RANK() OVER(PARTITION BY branch ORDER BY marks DESC) AS 'Dense_Rank'
FROM marks;

-- ROW_NUMBER

SELECT *,
ROW_NUMBER() OVER(PARTITION BY branch)
FROM marks;

-- Practical usage

SELECT *,
CONCAT(branch,'-',ROW_NUMBER() OVER(PARTITION BY branch)) AS 'Roll_no'
FROM marks;


-- Questions

-- Q1 ) : Find top 2 most paying customers of each month

SELECT * FROM new_orders;

SELECT * FROM (SELECT user_id, MONTHNAME(date) AS 'month_name', SUM(amount) AS 'total',
               DENSE_RANK() OVER(PARTITION BY MONTHNAME(date) ORDER BY SUM(amount) DESC) AS 'rank'
               FROM new_orders
               GROUP BY MONTHNAME(date), user_id
               ORDER BY MONTHNAME(date) DESC) t
WHERE t.rank < 3
ORDER BY t.month_name DESC, t.rank ASC;
               

-- Q2 ) : Create roll number from branch and marks

SELECT *,
CONCAT(branch,'-',ROW_NUMBER() OVER(PARTITION BY branch)) AS 'Roll_no'
FROM marks;

-- -----------------------------------------------------------------------------------------

-- First_value , Last_value, Nth_value (Window Functions)

-- Examples

-- First_value

SELECT *,
FIRST_VALUE(name) OVER(ORDER BY marks DESC)
FROM marks;

-- Last_value 

SELECT *,
LAST_VALUE(name) OVER(PARTITION BY branch 
                      ORDER BY marks DESC
                      ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM marks; 

-- Nth Value

SELECT *,
NTH_VALUE(name,2) OVER(PARTITION BY branch 
                      ORDER BY marks DESC
                      ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM marks; 

-- Question 

-- Q1 ) Find the branch toppers

SELECT name, marks, branch FROM (SELECT *,
FIRST_VALUE(name) OVER(PARTITION BY branch 
				       ORDER BY marks DESC) AS 'topper_name',
FIRST_VALUE(marks) OVER(PARTITION BY branch 
				       ORDER BY marks DESC) AS 'topper_marks'
FROM marks) t
WHERE t.name = t.topper_name AND t.marks = t.topper_marks;

-- -----------------------------------------------------------------------------------------------------------------

-- Lead and Lag (Window Function)

-- Examples

-- Lag

SELECT * ,
LAG(marks) OVER(ORDER BY name) 
FROM marks;

-- Lead

SELECT * ,
LEAD(marks) OVER(ORDER BY name) 
FROM marks;

-- Questions

-- Q ) Find the MoM revenue growth of zomato

SELECT MONTHNAME(date) AS 'month_name',
SUM(amount)  AS 'revenue',
((SUM(amount) - LAG(SUM(amount)) OVER(ORDER BY MONTHNAME(date) DESC))/ LAG(SUM(amount)) OVER(ORDER BY MONTHNAME(date) DESC))*100
FROM new_orders
GROUP BY month_name
ORDER BY month_name DESC;
