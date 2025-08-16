-- 1. Show all customers and their orders (customers with no orders should appear with NULL OrderID).
SELECT Customers.CustomerName, Orders.OrderID
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

-- 2. Show all products and the quantity sold (products never sold should show NULL).
SELECT Products.ProductName, Order_Details.Quantity
FROM Products
LEFT JOIN Order_Details ON Products.ProductID = Order_Details.ProductID;

-- 3. Show all employees and the orders they handled (employees without orders should appear with NULL).
SELECT Employees.FirstName, Orders.OrderID
FROM Employees
LEFT JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID;

-- 4. Show all customers and their order dates (NULL if no orders).
SELECT Customers.CustomerName, Orders.OrderDate
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

-- 5. Show all customers with the total number of their orders (0 if none).
SELECT Customers.CustomerName, COUNT(Orders.OrderID) AS TotalOrders
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerName;
