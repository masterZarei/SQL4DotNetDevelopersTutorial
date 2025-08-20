-- RIGHT JOIN

-- 1. Show all orders with customer names 
--(include orders even if the customer info is missing).
SELECT ORDERS.OrderID, customers.ContactName
FROM customers
RIGHT JOIN orders ON orders.CustomerID = customers.CustomerID

-- 2. Show all order details with product names
--(include order details even if product info is missing).
SELECT order_details.OrderID, products.ProductName
FROM products
RIGHT JOIN order_details ON order_details.ProductID = products.ProductID

-- 3. Show all orders with employee names 
--(include orders even if the employee info is missing).
SELECT orders.OrderID, employees.FirstName
FROM employees
RIGHT JOIN orders ON orders.EmployeeID = employees.EmployeeID

-- 4. Show all orders with their shipping company name 
--(include orders even if company info is missing).
SELECT orders.OrderID, shippers.ShipperName
FROM shippers
RIGHT JOIN orders ON shippers.ShipperID = orders.ShipperID

-- 5. Show all order details with category name of products 
--(include details even if category info is missing).
SELECT order_details.OrderID, categories.CategoryName
FROM categories
RIGHT JOIN products ON categories.CategoryID = products.CategoryID
RIGHT JOIN order_details ON order_details.ProductID = products.ProductID