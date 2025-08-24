-- DML (Data Manipulation Language) Commands

-- Creating Database
CREATE DATABASE my_queries;

-- Use it
USE my_queries;


-- Creating new table name user

CREATE TABLE user (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL
);
-- -----------------------------------------------------------------------------------
-- 1 ) Insert 

-- Inserting the data in table

INSERT INTO user(user_id, name, email, password)
VALUES (NULL, 'Fake', 'ifakecoder@gmail.com', 'Fake@123');

-- To see the inserted data

SELECT *FROM user;

-- Another way (without passing the column names)

INSERT INTO user()
VALUES (NULL, 'Data Seeker', 'idataseeker@gmail.com', 'Data@123');

-- To see 

SELECT *FROM user;

-- Inserting multiple users

INSERT INTO user() VALUES
(NULL, 'Loss Pointer', 'losspointer@gmail.com', 'Loss@123'),
(NULL, 'Bug Ninja', 'bugninja@gmail.com', 'Bug@123'),
(NULL, 'Data Filler', 'datafiller@gmail.com', 'Datafill@123');

-- To see
SELECT *FROM user;

-- ----------------------------------------------------------------------------------

 -- Importing the data (csv file )
 -- Smartphones Data
 
 -- 2 ) Select 
 
 -- Used to fetch all row in data (basically the whole data)
 SELECT *FROM smartphones;
 
 -- To fetch desired columns in order we want
 
 SELECT model, price, rating FROM smartphones;
 
 -- To rename columns
 
 SELECT os AS 'Operating System', model FROM smartphones;
 
 -- Creating expression using columns ( Calculating PPI )
 
 SELECT model,
 SQRT((resolution_width*resolution_width) + (resolution_height*resolution_height)) / screen_size AS 'PPI' 
 FROM smartphones;
 
 -- Rating 
 
 SELECT model, rating/10 FROM smartphones;
 
 -- -----------------------------------------------
 
 -- Constants
 
 SELECT model, 'Smartphone' AS 'type' FROM smartphones;
 
 -- Distinct (unique)
 
 SELECT DISTINCT(brand_name) AS 'All brand_name' FROM smartphones; 
 
 -- One more example of distinct
 
 SELECT DISTINCT(processor_brand) AS 'All processor_brand' FROM smartphones;
 
 -- Distinct combo
 
 SELECT DISTINCT brand_name, processor_brand FROM smartphones;
 
 -- ------------------------------------------------------------------------------------
 
 -- WHERE clause (Filtering Rows)
 
-- Some Questions

-- Q1 ) Find all samsung phones 

SELECT *
FROM smartphones 
WHERE brand_name = 'samsung';

-- Q2 ) Find all phones with price greater than 50000

SELECT brand_name, model, price FROM smartphones
WHERE  price > 50000;

-- Using BETWEEN Operator

-- Q3 ) Find all phones with price range 10000 to 20000

SELECT brand_name, model, price FROM smartphones
WHERE price BETWEEN 10000 AND 20000;

-- Q4 ) Find all phones with rating > 80 and price < 25000

SELECT brand_name, model, rating, price FROM smartphones
WHERE rating > 80 AND price < 25000;

-- Q5 ) Find all samsung phone with ram > 8gb

SELECT brand_name, model, ram_capacity FROM smartphones
WHERE brand_name = 'samsung' AND ram_capacity > 8;

-- Q6 ) All samsung phones with snapdragon processor 

SELECT brand_name, model, processor_brand FROM smartphones
WHERE brand_name = 'samsung' AND processor_brand = 'snapdragon';

-- Q7 ) Find all brand who sell phones with price > 50000

SELECT DISTINCT(brand_name), price FROM smartphones
WHERE price > 50000;

-- IN and NOT IN

-- Q8 ) Get the phones with processor_brand is snapdragon, exynos, bionic

SELECT * FROM smartphones
WHERE processor_brand IN ('snapdragon', 'exynos', 'bionic');

-- Get the phones excluding this processor_brand --> snapdragon, exynos, bionic

SELECT * FROM smartphones
WHERE processor_brand NOT IN ('snapdragon', 'exynos', 'bionic');

-- -------------------------------------------------------------------------------

-- 3 ) Update 

UPDATE user
SET email = 'ifakecoder@yahoo.com'
WHERE email = 'ifakecoder@gmail.com';

-- One more example

UPDATE user
SET email = 'losspointer@yahoo.com', password = 'Pointer@123'
WHERE name = 'Loss Pointer';

SELECT *FROM user;

-- ----------------------------------------------------------------------------------------------

-- 4 ) Delete

-- Delete all phones where price > 200000

SELECT *FROM smartphones
WHERE price > 200000;

DELETE FROM smartphones
WHERE price > 200000;

-- See there is no phones where price > 200000

SELECT *FROM smartphones
WHERE price > 200000;

-- One more example 

SELECT *FROM smartphones
WHERE battery_capacity > 7000;

DELETE FROM smartphones
WHERE battery_capacity > 7000;

SELECT *FROM smartphones
WHERE battery_capacity > 7000;

-- ------------------------------------------------------------------------------------------------

-- Types of functions in sql (built in )

-- Two types of built in functions
-- 1 ) Scalar Functions  --> Gives a value 
-- 2 ) Aggregate Function --> Gives a summary

-- Aggregate Functions

-- 1 ) Max
-- 2 ) Min

-- Q1 ) Find the minimum and maximum price of phones

SELECT MAX(price) FROM smartphones;

SELECT MIN(price) FROM smartphones;

-- Q2 ) Find the costliest samsung phone

SELECT MAX(price) FROM smartphones
WHERE brand_name = 'samsung';

-- 3 ) Avg

-- Find the average rating of apple phones

SELECT AVG(rating) FROM smartphones
WHERE brand_name = 'apple';

-- 4 ) Sum

SELECT SUM(price) FROM smartphones;

-- 5 ) Count

-- Q ) Find the number of oneplus phones

SELECT COUNT(brand_name) FROM smartphones
WHERE brand_name = 'oneplus';

-- 6 ) Count (Distinct)

-- Q ) Find the number of brands available

SELECT COUNT(DISTINCT(brand_name)) AS 'Brands Available' FROM smartphones;

-- 7 ) Std

-- Q ) Find the std of screen size

SELECT STD(screen_size) FROM smartphones;

-- 8 ) Variance

-- Q ) Find the std of screen size

SELECT VARIANCE(screen_size) FROM smartphones;

-- -------------------------------------------

-- Scalar Functions

-- 1 ) ABS (absolute)

SELECT ABS(100000 - price) AS 'temp_price' FROM smartphones;

-- 2 ) Round 

 SELECT model,
 ROUND(SQRT((resolution_width*resolution_width) + (resolution_height*resolution_height)) / screen_size,2) AS 'PPI' 
 FROM smartphones;
 
 -- 3 ) Ceil / Floor
 
 SELECT CEIL(screen_size) FROM smartphones;
 
 -- Floor
 
 SELECT FLOOR(screen_size) FROM smartphones;
 
-- -----------------------------------------------------------------------------------------------

-- Practice Question

-- Q1 ) Find the avg battery capacity and primary rear camera resolution for all smartphones with a price
-- greater than or equal to 100000

Select round(avg(battery_capacity)), round(avg(primary_camera_rear)) from smartphones
where price >= 100000;





