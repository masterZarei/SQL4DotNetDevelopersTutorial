--Table Subquery
-- 1. Get all products supplied by suppliers from 'Germany'.
SELECT * FROM Products
WHERE SupplierID IN
(SELECT SupplierID FROM Suppliers WHERE Country = 'Germany');

-- 2. Get all orders placed by customers from 'Brazil'.
SELECT * FROM Orders
WHERE CustomerID IN
(SELECT CustomerID FROM Customers WHERE Country = 'Brazil');

-- 3. Get all products that are in the same category as the most expensive products
SELECT *
FROM products
WHERE CategoryID IN (
    SELECT CategoryID
    FROM products
    WHERE Price = (SELECT MAX(Price) FROM products)
);

-- 4. Get all customers who have placed at least one order
SELECT *
FROM customers
WHERE CustomerID IN (
    SELECT DISTINCT CustomerID
    FROM orders
);

-- 5. Get products that have never been ordered
SELECT *
FROM products
WHERE ProductID NOT IN (
    SELECT DISTINCT ProductID
    FROM order_details
);
