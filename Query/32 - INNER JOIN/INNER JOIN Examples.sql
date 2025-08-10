-- 1. Show customers and their orders
SELECT Customers.CustomerName, Orders.OrderID
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

-- 2. Show products that have been sold along with their quantities
SELECT Products.ProductName, order_details.Quantity
FROM Products
INNER JOIN order_details ON Products.ProductID = order_details.ProductID;

-- 3. Show orders along with the employee who created them
SELECT Orders.OrderID, Employees.FirstName
FROM Orders
INNER JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID;

-- 4. Show German customers and their orders
SELECT Customers.CustomerName, Orders.OrderID
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Customers.Country = 'Germany';

-- 5. Show total quantity sold for each product
SELECT Products.ProductName, SUM(order_details.Quantity) AS TotalQuantity
FROM Products
INNER JOIN order_details ON Products.ProductID = order_details.ProductID
GROUP BY Products.ProductName;
