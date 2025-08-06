-- lists the number of customers in each country:
SELECT COUNT(CustomerID), Country
FROM Customers
GROUP BY Country;

-- lists the number of customers in each country, sorted high to low:
SELECT COUNT(CustomerID), Country
FROM Customers
GROUP BY Country
ORDER BY COUNT(CustomerID) DESC;

--Get the average price of products per supplier.
SELECT SupplierID, AVG(Price) AS AveragePrice
FROM products
GROUP BY SupplierID;

--Show total quantity sold per product
SELECT ProductID, SUM(Quantity) AS TotalSold
FROM order_details
GROUP BY ProductID;

--Find how many employees were born in each birth year.
SELECT YEAR(BirthDate) AS BirthYear, COUNT(*) AS EmployeeCount
FROM employees
GROUP BY YEAR(BirthDate);

--Get the number of orders per customer (with only those who made more than 5 orders)
SELECT CustomerID, COUNT(*) AS OrderCount
FROM orders
GROUP BY CustomerID
HAVING COUNT(*) > 5; -- We'll be learning more about having in upcoming videos :)