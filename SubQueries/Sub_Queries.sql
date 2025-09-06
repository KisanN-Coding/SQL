-- Sub Queries in SQL 

CREATE DATABASE IF NOT EXISTS my_database;

USE my_database;

-- Simple Example of subquries

SELECT * FROM movies
WHERE score = (SELECT MAX(score) FROM movies);

-- Independent Subquery (Scalar Subquery)

-- Questions 

-- Q1 ) Find the movie with highest profit

SELECT *FROM movies
WHERE (gross - budget) = (SELECT MAX(gross - budget) FROM movies);
 
-- Q2 ) Find how many movie have rating > average of all movie rating
-- (Find the count of above average movies)

SELECT COUNT(*) FROM movies
WHERE  score > (SELECT ROUND(AVG(score),1) FROM movies);

-- Q3 ) Highest rated movie of 2000

SELECT * FROM movies
WHERE year = 2000 AND score = (SELECT MAX(score) 
                               FROM movies
                               WHERE year = 2000);

-- Q4 ) Find the highest rated movie among all movie whose number of 
-- votes are > the dataset average votes

SELECT * FROM movies
WHERE 
votes > (SELECT ROUND(AVG(votes)) FROM movies) 
AND
score = (SELECT MAX(score) FROM movies);

-- ----------------------------------------------------------------------------------

-- Independent Subquery - (Multi row subquery)

-- Questions 

-- Q1 ) Find all users who never ordered

SELECT * FROM new_users
WHERE user_id NOT IN (SELECT DISTINCT(user_id) FROM new_orders);

-- Q2 ) Find all movies of all those actors whose film's avg rating > 8.5 (Cutoff of 25000 votes)

SELECT * FROM movies
WHERE star IN
(SELECT star FROM movies
WHERE votes > 25000 
GROUP BY star
HAVING AVG(score) > 8.5) 
AND votes > 25000;

-- -----------------------------------------------------------------------------------

-- Independent Subquery - (Multiple column subquery)

-- Questions 

-- Q1 ) Most profitable movie of each year

SELECT * FROM movies
WHERE (year, (gross - budget)) IN (SELECT year, MAX(gross - budget) 
                         FROM movies
                         GROUP BY year);
						
-- Q2 ) Find the highest rated movie of genre votes cutoff of 25000

SELECT * FROM movies
WHERE (genre, score) IN (SELECT genre, MAX(score) FROM movies
                         WHERE votes > 25000
                         GROUP BY genre)
                         AND votes > 25000;
                         
-- Q3 ) Find the highest grossing movies of top 5 actor/director combo in terms
-- of total gross income

WITH top_duos AS (SELECT star, director, MAX(gross)
FROM movies
GROUP BY star , director
ORDER BY SUM(gross) DESC LIMIT 5)

SELECT * FROM movies
WHERE (star, director, gross) IN (SELECT * FROM top_duos);

-- -----------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------

-- Corelated SubQuery

-- Questions

-- Q1 ) Find all the movies that have a rating higher than the average
-- rating of movies in the same genre

SELECT *FROM movies m1
WHERE score > (SELECT AVG(score) FROM movies m2
               WHERE m2.genre = m1.genre);

-- Q2 ) Find the favourite of each customer

WITH fav_food AS
(SELECT t2.user_id, t1.name, t4.f_name, COUNT(*) AS 'freq' FROM new_users t1
JOIN new_orders t2
ON t1.user_id = t2.user_id

JOIN new_order_details t3
ON t2.order_id = t3.order_id

JOIN food t4
ON t3.f_id = t4.f_id

GROUP BY t1.name,t2.user_id, t4.f_name,t3.f_id
)

SELECT * FROM fav_food f1
WHERE freq = (SELECT MAX(freq) FROM fav_food f2 
               WHERE f2.user_id = f1.user_id);
               
-- ----------------------------------------------------------------------------------

-- Using Subquery in select (Very inefficient)

-- Questions

-- Q1 ) Get the percentage of votes for each movie compared to total number
--      of votes

SELECT name, (votes / (SELECT SUM(votes) FROM movies))* 100 FROM movies;

-- Q2 ) Display all movie names, genre, score, and avg(score)

SELECT name, genre, score, 
(SELECT ROUND(AVG(score),1) FROM movies m2
WHERE m1.genre = m2.genre
GROUP BY genre) AS 'Avg_score' 
FROM movies m1
ORDER BY Avg_score DESC;


-- ----------------------------------------------------------------------------------

-- Using Subquery in from

-- Question : Display average rating of all the restaurants

SELECT r_name, Avg_rating
FROM (SELECT r_id, ROUND(AVG(restaurant_rating),1) AS 'Avg_rating'
      FROM new_orders
      GROUP BY r_id) t1
JOIN restaurants t2
ON t1.r_id = t2.r_id;

-- --------------------------------------------------------------------------------------------

-- Using Subquery in Having

-- Question : Find genres having avg score > avg score of all movies

SELECT genre, ROUND(AVG(score),1) AS 'Avg_rating'
FROM movies
GROUP BY genre
HAVING Avg_rating > (SELECT ROUND(AVG(score),1) FROM movies);

-- --------------------------------------------------------------------------------------------



