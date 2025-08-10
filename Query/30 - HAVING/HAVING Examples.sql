-- Show categories where the average product price is more than 50
SELECT CategoryID, AVG(Price) AS AvgPrice
FROM Products
GROUP BY CategoryID
HAVING AVG(Price) > 50;

-- Show customers with more than 5 total orders
SELECT CustomerID, COUNT(OrderID) AS TotalOrders
FROM Orders
GROUP BY CustomerID
HAVING COUNT(OrderID) > 5;

-- Show products whose total sold quantity is under 100
SELECT ProductID, SUM(Quantity) AS TotalQuantity
FROM order_details
GROUP BY ProductID
HAVING SUM(Quantity) < 100;

-- Show categories that have exactly 10 products
SELECT CategoryID, COUNT(ProductID) AS ProductCount
FROM Products
GROUP BY CategoryID
HAVING COUNT(ProductID) = 10;




