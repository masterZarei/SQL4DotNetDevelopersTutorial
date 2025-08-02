-- Aggregate Functions Exercise

--🔸 SUM()
--Calculate the total quantity of all products sold.
SELECT SUM(Quantity) FROM Order_Details;

--Calculate the total revenue from all orders
--assuming each product has a fixed price of 10.
SELECT SUM(Quantity * 10) FROM Order_Details;

--Calculate total quantity of ProductID 5 sold.
SELECT SUM(Quantity) FROM Order_Details
WHERE ProductID = 5;

--🔸 AVG()
--Find the average price of all products.
SELECT AVG(Price) FROM Products;

--Find the average quantity per order for ProductID 2.
SELECT AVG(Quantity) FROM Order_Details
WHERE ProductID = 2;

--Show the average product price per category.
SELECT CategoryID, AVG(Price) FROM Products
GROUP BY CategoryID;

--🔸 MIN()
--Find the lowest product price in the Products table.
SELECT MIN(Price) FROM Products;

--Get the lowest price for each category.
SELECT CategoryID, MIN(Price) FROM Products
GROUP BY CategoryID;

--Find the minimum quantity ever ordered in any order.
SELECT MIN(Quantity) FROM Order_Details;

--🔸 MAX()
--Find the highest product price.
SELECT MAX(Price) FROM Products;

--Show the maximum quantity ordered for ProductID 10.
SELECT MAX(Quantity) FROM Order_Details
WHERE ProductID = 10;

--Find the most expensive product per supplier.
SELECT SupplierID, MAX(Price) FROM Products
GROUP BY SupplierID;

--🔸 COUNT()
--Count how many products exist in the Products table.
SELECT COUNT(*) FROM Products;

--Count how many products have a price greater than 20.
SELECT COUNT(*) FROM Products
WHERE Price > 20;

--Count how many customers are from 'Germany'.
SELECT COUNT(*) FROM Customers
WHERE Country = 'Germany';





