-- Show customers with PostalCode, or 'Unknown' if NULL
SELECT CustomerName,
       ISNULL(PostalCode, 'Unknown') AS PostalCode
FROM Customers;

-- Show total quantity, if no items then 0
SELECT ProductID,
       ISNULL(SUM(Quantity), 0) AS TotalQuantity
FROM Order_Details
GROUP BY ProductID;

-- Show customers's living region (Country, else City, else 'Unknown')
SELECT ContactName,
       COALESCE(Country, City, 'Unknown') AS Location
FROM customers;
