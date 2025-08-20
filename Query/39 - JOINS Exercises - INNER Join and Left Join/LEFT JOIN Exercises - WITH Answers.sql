-- LEFT JOIN EXERCISES WITH ANSWERS

-- 1. Show all customers and their orders (customers with no orders should appear with NULL OrderID).
SELECT CUSTOMERS.ContactName, ORDERS.OrderID
FROM customers
LEFT JOIN orders ON orders.CustomerID = customers.CustomerID

-- 2. Show all products and the quantity sold (products never sold should show NULL).
SELECT products.ProductName, SUM(order_details.Quantity)
FROM products
LEFT JOIN order_details ON order_details.ProductID = products.ProductID
GROUP BY products.ProductName

-- 3. Show all employees and the orders they handled (employees without orders should appear with NULL).
SELECT employees.LastName, orders.OrderID
FROM employees
LEFT JOIN orders ON orders.EmployeeID = employees.EmployeeID

-- 4. Show all customers and their order dates (NULL if no orders).
SELECT CUSTOMERS.ContactName, ORDERS.OrderDate
FROM customers
LEFT JOIN orders ON orders.CustomerID = customers.CustomerID

-- 5. Show all customers with the total number of their orders (0 if none).
SELECT customers.ContactName, COUNT(ORDERS.OrderID)
FROM customers
LEFT JOIN orders ON orders.CustomerID = customers.CustomerID
GROUP BY customers.ContactName
