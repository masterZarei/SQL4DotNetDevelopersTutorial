-- SCALAR SUBQUERIES
-- 1. Get the average price of all products.
SELECT AVG(Price) FROM Products;

-- 2. Get the products with a price higher than the average price.
SELECT * FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products);

-- 3. Get the product with the highest price.
SELECT * FROM Products
WHERE Price = (SELECT MAX(Price) FROM Products);

-- 4. Get the number of orders placed by the customer with ID = 5.
SELECT COUNT(*) FROM Orders
WHERE CustomerID = (SELECT CustomerID FROM Customers WHERE CustomerID = 5);

-- 5. Get the price of the product named 'Chang'.
SELECT Price FROM Products
WHERE ProductID = (SELECT ProductID FROM Products WHERE ProductName = 'Chang');