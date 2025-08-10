-- 1. Show all customers and all orders, even if they are unrelated
SELECT Customers.CustomerName, Orders.OrderID
FROM Customers
FULL OUTER JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

-- 2. Show all products and all orders related to them
SELECT Products.ProductName, order_details.OrderID
FROM Products
FULL OUTER JOIN order_details ON Products.ProductID = order_details.ProductID;

-- 3. Show all employees and the orders they created
SELECT Employees.FirstName, Orders.OrderID
FROM Employees
FULL OUTER JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID;

-- 4. Show all countries and orders from customers in those countries
SELECT Customers.Country, Orders.OrderID
FROM Customers
FULL OUTER JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

-- 5. Show all customers and their total number of orders (NULL if unrelated)
SELECT Customers.CustomerName, COUNT(Orders.OrderID) AS TotalOrders
FROM Customers
FULL OUTER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerName;
