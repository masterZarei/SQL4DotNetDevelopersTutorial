SELECT COUNT(*)
FROM Products;

-- Find the number of products where Price is higher than 20:
SELECT COUNT(ProductID)
FROM Products
WHERE Price > 20;

-- How many different prices are there in the Products table:
SELECT COUNT(DISTINCT Price)
FROM Products;

-- Here we use the COUNT() function and the GROUP BY clause,
-- to return the number of records for each category in the Products table:
-- (Don't panic!, we'll have an episode explaining The Group By command)
SELECT COUNT(*) AS [Number of records], CategoryID
FROM Products
GROUP BY CategoryID;