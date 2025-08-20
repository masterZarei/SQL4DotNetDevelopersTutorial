USE TopShopDb
-- FULL OUTER JOIN

-- 1. Show all customers and all orders
--(customers with no orders and orders without valid customer should both appear).
SELECT CUSTOMERS.ContactName, orders.OrderID
FROM customers
FULL OUTER JOIN orders ON orders.CustomerID = customers.CustomerID

-- 2. Show all products and order details
--(products never sold and order details with invalid product should both appear).
SELECT order_details.OrderID, products.ProductName
FROM order_details
FULL OUTER JOIN products ON products.ProductID = order_details.ProductID

-- 3. Show all employees and orders
--(employees without orders and orders without valid employee should appear).
SELECT orders.OrderID, employees.LastName
FROM orders 
FULL OUTER JOIN employees ON employees.EmployeeID = orders.EmployeeID

-- 4. Show all categories and products
--(categories with no products and products with no valid category should appear).
SELECT products.ProductName, categories.CategoryName
FROM products
FULL OUTER JOIN categories ON categories.CategoryID = products.CategoryID

-- 5. Show all employees and all shippers (to check which employees have worked with which shipping company,
-- including employees who have never created an order and shippers who have never been used in any order).
SELECT employees.FirstName, shippers.ShipperName, orders.OrderID
FROM employees
FULL OUTER JOIN orders ON orders.EmployeeID = employees.EmployeeID
FULL OUTER JOIN shippers ON orders.ShipperID = shippers.ShipperID
