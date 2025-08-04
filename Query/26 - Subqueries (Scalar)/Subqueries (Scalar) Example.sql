--A. Scalar Subquery
-- Find all products more expensive than the average price
SELECT ProductName, Price
FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products);

