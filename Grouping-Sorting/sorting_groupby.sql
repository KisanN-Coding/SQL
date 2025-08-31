-- Sorting and Groupby in SQL 

CREATE DATABASE IF NOT EXISTS my_sql;

USE my_sql;

-- 1 ) Sorting Data

-- Questions 

-- Q1 ) Find top 5 samsung phones with biggest screen size

SELECT model, screen_size FROM smartphones
WHERE brand_name = 'samsung'
ORDER BY screen_size DESC LIMIT 5;

-- Q2 ) Sort all the phones within decending order of number of total cameras

SELECT model, (num_rear_cameras + num_front_cameras) AS 'total_cameras' FROM smartphones
ORDER BY total_cameras DESC;

-- Q3 ) Sort data on basis of ppi in decreasing order

SELECT model,
 ROUND(SQRT((resolution_width*resolution_width) + (resolution_height*resolution_height)) / screen_size,2) AS 'PPI' 
 FROM smartphones
 ORDER BY PPI DESC;

-- Q4 ) Find the phone with 2nd largest battery capacity

SELECT model, battery_capacity FROM smartphones
ORDER BY battery_capacity DESC LIMIT 1,1;

-- Q5 ) Find the name and rating of worst rated apple phone

SELECT model, rating FROM smartphones
WHERE brand_name = 'Apple'
ORDER BY rating ASC LIMIT 1;

-- Q6 ) Sort phones alphabetically and then on basis of rating in decs order

SELECT brand_name, rating FROM smartphones
ORDER BY brand_name ASC , rating DESC;

-- Q7 ) Sort phones alphabetically and then on basis of price in asc order

SELECT brand_name, price FROM smartphones
ORDER BY brand_name ASC , price ASC;

-- -------------------------------------------------------------------------------------------

-- 2) Group by

-- Question : Group smartphones by brand and get count, average price , max rating, avg screen size and avg battery capacity

SELECT brand_name, COUNT(*) AS 'Num_phones',
ROUND(AVG(price)) AS 'Avg_price',
MAX(rating) AS 'Max_Rating',
ROUND(AVG(screen_size),2) AS 'Avg_Screen_Size',
ROUND(AVG(battery_capacity)) AS 'Avg_BC'
FROM smartphones
GROUP BY brand_name
ORDER BY Num_phones DESC;

-- More Questions

-- Q1 ) Group phones by weather they have NFC and get the average price and rating

SELECT has_nfc ,
 ROUND(AVG(price)) AS 'Average Price', 
 ROUND(AVG(rating),2) AS 'Average Rating'
from smartphones
GROUP BY has_nfc;

-- Q2 ) Group phones by extentend memory available and get the average price

SELECT extended_memory_available, 
ROUND(AVG(price)) AS 'Average_price'
FROM smartphones
GROUP BY extended_memory_available
ORDER BY Average_price DESC;

-- Q3 ) Group phones by brand and processor brand and get the count of models and 
--      average primary camera resolution( rear ) 

SELECT brand_name, processor_brand, 
COUNT(model) AS 'Num_phones', 
ROUND(AVG(primary_camera_rear)) AS 'Avg_camera'
FROM smartphones
GROUP BY brand_name, processor_brand;

-- Q4 ) Find top most costly phone brands

SELECT brand_name, 
MAX(price) AS 'Max_price'
FROM smartphones
GROUP BY brand_name
ORDER BY Max_price DESC LIMIT 1;

-- Q5 ) Which brand makes the smallest screen phone

SELECT brand_name, 
MIN(screen_size) 
FROM smartphones
GROUP BY brand_name
ORDER BY MIN(screen_size) ASC LIMIT 1;

-- Q6 ) Avg price of 5g phones vs avg price of non 5g phones

SELECT has_5g, 
ROUND(AVG(price))
FROM smartphones
GROUP BY has_5g;

-- Q7 ) Group smartphones by brand, and find the brand with the highest number of models
--     that have NFC and IR blaster

SELECT brand_name, 
COUNT(model)
FROM smartphones
WHERE has_nfc = 'True' AND has_ir_blaster = 'True'
GROUP BY brand_name
ORDER BY COUNT(model) DESC LIMIT 1;

-- Q8 ) Find all samsung 5g smartphones and find the average prices of NFC and non NFC

SELECT brand_name, has_5g, has_nfc,
ROUND(AVG(price)) AS 'Avg_price'
FROM smartphones
WHERE brand_name = 'samsung'
GROUP BY has_5g, has_nfc;

-- Q9 ) Find the phone name, price of the costiest

SELECT model, 
MAX(price)
FROM smartphones
GROUP BY model
ORDER BY MAX(price) DESC LIMIT 1;

-- ---------------------------------------------------------------------------------------

-- 3 ) Having clause

-- Questions 

-- Q1 ) Find the average rating of smartphone brand which have more than 20 phones

SELECT brand_name, 
ROUND(AVG(rating)) AS 'Average_rating',
COUNT(model) AS 'Num_phones'
FROM smartphones
GROUP BY brand_name
HAVING Num_phones > 20
ORDER BY Num_phones DESC;

-- Find top 3 brand with highest rating and avg ram that have refresh rate > 90 hz and fast charging available and
-- fast available and don't consider the brands which have less than 10 phones

SELECT brand_name,
ROUND(AVG(ram_capacity)) AS 'Avg_ram',
MAX(rating) AS 'Max_rating',
COUNT(model) AS 'Num_phones'
FROM smartphones
WHERE refresh_rate > 90 AND fast_charging_available = 1
GROUP BY brand_name
HAVING Num_phones > 10
ORDER BY Max_rating DESC LIMIT 3;

-- Find the average price of all phone brands with avg rating > 70 and num_phones
-- more than 10 among all 5g 

SELECT brand_name,
ROUND(AVG(price)) AS 'Average_price',
ROUND(AVG(rating)) AS 'Average_rating',
COUNT(model) AS 'Num_phones'
FROM smartphones
WHERE has_5g = 'True'
GROUP BY brand_name
HAVING Average_rating > 70 AND Num_phones > 10
ORDER BY Average_price DESC;

-- ---------------------------------------------------------------------------------------

-- More pratice Questions 

-- Q1 ) Find top 5 batsman in ipl 

SELECT batter,
SUM(batsman_run) AS 'total_runs'
FROM ipl
GROUP BY batter
ORDER BY total_runs DESC LIMIT 5;

-- Q2 ) Find the 2nd highest six hitting

SELECT batter,
COUNT(batsman_run) AS 'Total_sixes'
FROM ipl
WHERE batsman_run = 6
GROUP BY batter
ORDER BY Total_sixes DESC LIMIT 1,1;

-- Q3 ) Find Virat Kohli's performance against bowler

SELECT batter,
bowler,
SUM(batsman_run) AS 'total_run'
FROM ipl
WHERE batter = 'V Kohli'
GROUP BY bowler
ORDER BY total_run DESC LIMIT 10;
