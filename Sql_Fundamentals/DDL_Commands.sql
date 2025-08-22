-- DDL (Data Definition Language) Commands for Databases
-- 1 ) Create
-- 2 ) Drop

-- Creating the database using create command

CREATE DATABASE my_sql;

-- Another query to create database (better option)

CREATE DATABASE IF NOT EXISTS my_sql;

-- Deleting the database using drop command

DROP DATABASE my_sql;

-- Another query to delete database (better option)

DROP DATABASE IF EXISTS my_sql;

-- To use the database , we write

USE my_sql;

-- ---------------------------------------------------------------
-- DDL Commands for Tables

CREATE TABLE user (
    user_id INT,
    name VARCHAR(255),
    email VARCHAR(255),
    password VARCHAR(255)
);

-- Making table empty using truncate command (Make sure, table must hold some data)

TRUNCATE TABLE user;

-- Deleting the table using drop command

DROP TABLE IF EXISTS user;

-- -----------------------------------------------------------------

CREATE TABLE user (
    user_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL
);

-- 2 ) Unique constraints

CREATE TABLE new_user (
    user_id INT NOT NULL UNIQUE,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

DROP TABLE new_user;

-- Another way to specify the constraints (better for combo's and deleting constraints in future)

CREATE TABLE new_user (
    user_id INT NOT NULL,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL,
    CONSTRAINT new_user_email_unique UNIQUE (email)
);

DROP TABLE new_user;

-- 3 ) Primary Key

CREATE TABLE newuser (
    user_id INT NOT NULL UNIQUE PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL
);

DROP TABLE newuser;

-- Another way 

CREATE TABLE newuser (
    user_id INT NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    
    CONSTRAINT newuser_user_id_pk PRIMARY KEY (user_id)
);

DROP TABLE newuser;

-- Auto increment constraint

CREATE TABLE newuser1 (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL
);

-- Check constraint

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL CHECK (age > 6 AND age < 25)
);

-- Another way 

CREATE TABLE newstudents (
    student_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    CONSTRAINT newstudents_age_check CHECK (age > 6 AND age < 25)
); 

-- Default Constraint

create table ticket(
	ticket_id int primary key,
    name varchar(100) not null,
    travel_date date not null default(current_date)
);

-- Foreign key constraint

-- 1st table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

-- 2nd table 

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATETIME NOT NULL DEFAULT(current_timestamp()),
    CONSTRAINT orders_fk FOREIGN KEY (customer_id)
        REFERENCES customers (customer_id)
);


-- DROP TABLE customers; --> this will not work now

-- ---------------------------------------------------------------------------------------

-- Referential Actions

-- 1 ) Restricted 
-- 2 ) Cascade

DROP TABLE orders;

-- Recreating the orders table using Cascade

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP (),
    CONSTRAINT orders_fk FOREIGN KEY (customer_id)
        REFERENCES customers (customer_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- ----------------------------------------------------------------------------------------

-- Alter Table Command

-- 1 ) Adding new column

ALTER TABLE customers ADD COLUMN password VARCHAR(100) NOT NULL;

-- 2 ) Adding column on desired place 

ALTER TABLE customers ADD COLUMN surname VARCHAR(100) NOT NULL AFTER name;  -- We can also use BEFORE

-- 3 ) Adding multiple columns 

 ALTER TABLE customers
 
 ADD COLUMN pan_number VARCHAR(50) AFTER name,
 ADD COLUMN joining_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP;
 
-- 4 ) Deleting column

ALTER TABLE customers
DROP COLUMN pan_number;

-- 5 ) Deleting multiple column

ALTER TABLE customers
DROP COLUMN password,
DROP COLUMN joining_date;

-- 6 ) Modifying column (for example )

ALTER TABLE customers
MODIFY surname INT ;   -- I know its not logical , but just for example

-- -----------------------------------------------------------------------------------------------

-- Editing and Deleting Constraints

-- Adding one column and constraint

ALTER TABLE customers
ADD COLUMN age INT NOT NULL,
ADD CONSTRAINT customer_age_check CHECK(age > 13);

-- Deleting the constraint 

ALTER TABLE customers
DROP CONSTRAINT customer_age_check;

