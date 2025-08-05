--C. Table Subquery
-- Average price of products per category using a derived table
SELECT CategoryID, AvgPrice
FROM (
  SELECT CategoryID, AVG(Price) AS AvgPrice
  FROM Products
  GROUP BY CategoryID
) AS CategoryAvg;

