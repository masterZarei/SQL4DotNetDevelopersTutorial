--B. Row Subquery
-- Find the customer who placed order with ID = 10248
SELECT CustomerName
FROM Customers
WHERE CustomerID IN (
  SELECT CustomerID
  FROM Orders
  WHERE OrderID = 10248
);
