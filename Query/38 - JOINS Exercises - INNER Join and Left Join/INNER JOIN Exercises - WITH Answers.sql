-- INNER JOIN EXERCISES WITH ANSWERS

-- 1. Show all customers who have placed at least one order 
--(list their names and OrderID).
SELECT customers.ContactName, orders.OrderID
FROM customers
INNER JOIN orders ON customers.CustomerID = orders.CustomerID

-- 2. Show all products that have been sold at least once
--(list ProductName and Quantity).
SELECT products.ProductName, order_details.Quantity
FROM products
INNER JOIN order_details ON products.ProductID = order_details.ProductID

-- 3. Show all employees along with the orders they handled.
SELECT employees.LastName, orders.OrderID
FROM employees
INNER JOIN orders ON employees.EmployeeID = orders.EmployeeID

-- 4. Show all orders with their customer name.
SELECT orders.ORDERID,orders.OrderDate, customers.ContactName
FROM orders
INNER JOIN customers ON customers.CustomerID = orders.CustomerID

-- 5. Show all order details with the product name and price.
SELECT order_details.OrderID, products.ProductName, products.Price
FROM order_details
INNER JOIN products ON products.ProductID = order_details.ProductID