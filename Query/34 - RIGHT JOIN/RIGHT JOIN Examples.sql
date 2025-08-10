-- 1. Show all orders, even if the customer does not exist
SELECT Orders.OrderID, Customers.CustomerName
FROM Customers
RIGHT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

-- 2. Show all order details, even if the product no longer exists
SELECT order_details.OrderID, Products.ProductName
FROM Products
RIGHT JOIN order_details ON Products.ProductID = order_details.ProductID;

-- 3. Show all orders and their employees, even if the employee no longer exists
SELECT Orders.OrderID, Employees.FirstName
FROM Employees
RIGHT JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID;

-- 4. Show all orders and the country of their customers (NULL if missing)
SELECT Orders.OrderID, Customers.Country
FROM Customers
RIGHT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

-- 5. Show all orders and the number of products in each order
SELECT Orders.OrderID, COUNT(order_details.ProductID) AS ProductCount
FROM Orders
RIGHT JOIN order_details ON Orders.OrderID = order_details.OrderID
GROUP BY Orders.OrderID;
