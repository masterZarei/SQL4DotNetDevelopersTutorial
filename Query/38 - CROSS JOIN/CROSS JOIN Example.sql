-- Combine all customers with all products
-- This shows every possible combination of a customer and a product
SELECT Customers.CustomerName, Products.ProductName
FROM Customers
CROSS JOIN Products;