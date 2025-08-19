-- Any
SELECT products.ProductName, PRICE
FROM products
WHERE PRICE < ANY (SELECT Price FROM products WHERE CategoryID = 1)
-- All
SELECT products.ProductName, PRICE
FROM products
WHERE PRICE < ALL (SELECT Price FROM products WHERE CategoryID = 1)
-- Exists
SELECT customers.CustomerName
FROM customers
WHERE EXISTS (SELECT * FROM orders WHERE orders.CustomerID = customers.CustomerID)