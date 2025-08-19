-- FULL OUTER JOIN WITH ANSWERS

-- 1. Show all customers and all orders
--(customers with no orders and orders without valid customer should both appear).
SELECT Customers.CustomerName, Orders.OrderID
FROM Customers
FULL OUTER JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

-- 2. Show all products and order details
--(products never sold and order details with invalid product should both appear).
SELECT Products.ProductName, Order_Details.OrderID
FROM Products
FULL OUTER JOIN Order_Details ON Products.ProductID = Order_Details.ProductID;

-- 3. Show all employees and orders
--(employees without orders and orders without valid employee should appear).
SELECT Employees.FirstName, Orders.OrderID
FROM Employees
FULL OUTER JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID;

-- 4. Show all categories and products
--(categories with no products and products with no valid category should appear).
SELECT Categories.CategoryName, Products.ProductName
FROM Categories
FULL OUTER JOIN Products ON Categories.CategoryID = Products.CategoryID;

-- 5. Show all employees and all shippers (to check which employees have worked with which shipping company,
-- including employees who have never created an order and shippers who have never been used in any order).
SELECT Employees.FirstName, Shippers.ShipperName, Orders.OrderID
FROM Employees
FULL OUTER JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
FULL OUTER JOIN Shippers ON Orders.ShipperID = Shippers.ShipperID;

