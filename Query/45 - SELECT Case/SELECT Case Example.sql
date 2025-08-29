-- Categorize products as Cheap, Medium, or Expensive based on Price
SELECT ProductName, Price,
	CASE
		WHEN Price < 10 THEN 'Cheap'
		WHEN Price BETWEEN 10 AND 30 THEN 'Medium'
		ELSE 'Expensive'
	END AS PriceCategory
FROM products

-- Assign a Continent to each customer
SELECT ContactName, Country,
	CASE
		WHEN Country IN ('Germany','UK','France') THEN 'Europe'
		WHEN Country IN ('USA','Canada','Mexico') THEN 'America'
		ELSE 'Others'
	END AS Continent
FROM customers

-- Label customers as Local or International
SELECT ContactName, Country,
	CASE
		WHEN Country = 'USA' THEN 'Local'
		ELSE 'International'
	END AS 'Customer Type'
FROM customers