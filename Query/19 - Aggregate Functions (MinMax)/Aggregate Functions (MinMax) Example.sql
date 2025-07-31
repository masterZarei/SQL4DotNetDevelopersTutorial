-- Minimum
SELECT MIN(Price) AS SmallestPrice
FROM Products;

-- Maximum
SELECT MAX(Price) AS LargestPrice
FROM Products;

-- Groups Data By CategoryId 
-- (Don't panic!, we'll have an episode explaining The Group By command)
SELECT MIN(Price) AS SmallestPrice, CategoryID
FROM Products
GROUP BY CategoryID;