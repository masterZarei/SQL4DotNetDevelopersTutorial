-- Categorize products as Cheap, Medium, or Expensive based on Price
SELECT ProductName, Price,
    CASE 
        WHEN Price < 10 THEN 'Cheap'
        WHEN Price BETWEEN 10 AND 30 THEN 'Medium'
        ELSE 'Expensive'
    END AS PriceCategory
FROM Products;

-- Assign a Continent to each customer
SELECT CustomerName, Country,
    CASE 
        WHEN Country IN ('Germany', 'UK', 'France') THEN 'Europe'
        WHEN Country IN ('USA', 'Canada') THEN 'North America'
        ELSE 'Other'
    END AS Continent
FROM Customers;

-- Label customers as Local or International
SELECT CustomerName, Country,
    CASE 
        WHEN Country = 'USA' THEN 'Local'
        ELSE 'International'
    END AS CustomerType
FROM Customers;
