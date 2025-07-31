-- CRUD Operations Exercise.
--🔹 CREATE – INSERT Operations (3 Questions)

--1. Insert a new customer with all details filled.
INSERT INTO customers
VALUES('Jafar','Mahdi','Meydoon Emam','Mashhad','256415','Iran')
SELECT * FROM customers

--2. Insert a customer without a PostalCode.
INSERT INTO customers(CustomerName,ContactName,Address,City,Country)
VALUES('Mojtaba','Shahin','Meydoon Azadi','Kerman','Iran')
SELECT * FROM customers

--3. Insert a customer using columns in a different order.
INSERT INTO customers(City,ContactName,CustomerName,Country,Address)
VALUES('Bandar Abbas','Sara','Kimia','IRAN','Kooche 2')
SELECT * FROM customers

--🔹 READ – SELECT Operations (3 Questions)

--1. Select all customers from Germany.
SELECT * FROM customers
WHERE Country='Germany'

--2. Select customers whose name starts with ‘A’.
SELECT * FROM customers
WHERE CustomerName LIKE 'A%'

--3. Select only CustomerName and City from customers in Canada.
SELECT CustomerName,City FROM customers
WHERE Country = 'Canada'

--🔹 UPDATE Operations (3 Questions)

--1. Update the city of customer with ID = 1 to 'Mashhad'.
UPDATE customers
SET City = 'MASHHAD'
WHERE CustomerID = 1;

SELECT * FROM customers

--2. Set PostalCode to NULL for all customers in Brazil.
UPDATE customers
SET PostalCode = NULL
WHERE Country = 'Brazil';

SELECT * FROM customers
WHERE Country='Brazil'
--3. Add prefix ‘Dr. ’ to ContactName where Country = 'France'.
UPDATE customers
SET ContactName = 'Dr. ' + ContactName
WHERE Country = 'France';

SELECT * FROM customers
WHERE Country='France'
--🔹 DELETE Operations (3 Questions)

--1. Delete customer with CustomerID = 91.
DELETE FROM customers
WHERE CustomerID = 92

SELECT * FROM customers

--2. Delete customers whose name ends with ‘Mart’.
DELETE FROM customers
WHERE CustomerName LIKE '%ance'

--3. Delete all customers from country 'Unknown'.
DELETE FROM customers
WHERE Country = 'Denmark'
