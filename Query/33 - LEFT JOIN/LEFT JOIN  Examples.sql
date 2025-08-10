-- 1. Show all customers, even if they have no orders
SELECT Customers.CustomerName, Orders.OrderID
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

-- 2. Show all products, even if they have never been sold
SELECT Products.ProductName, order_details.Quantity
FROM Products
LEFT JOIN order_details ON Products.ProductID = order_details.ProductID;

-- 3. Show all employees and the orders they created
SELECT Employees.FirstName, Orders.OrderID
FROM Employees
LEFT JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID;

-- 4. Show customers and their order dates (NULL for those without orders)
SELECT Customers.CustomerName, Orders.OrderDate
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

-- 5. Show all customers with the total number of orders (0 or NULL for no orders)
SELECT Customers.CustomerName, COUNT(Orders.OrderID) AS TotalOrders
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerName;
