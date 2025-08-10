-- Show customers who live in the same city
SELECT c1.CustomerName, c2.CustomerName AS SameCityCustomer, c1.City
FROM Customers c1
INNER JOIN Customers c2
    ON c1.City = c2.City
    AND c1.CustomerID < c2.CustomerID;

-- Show products with the same price but different IDs
SELECT p1.ProductName, p2.ProductName AS SamePriceProduct, p1.Price
FROM Products p1
INNER JOIN Products p2
    ON p1.Price = p2.Price
    AND p1.ProductID <> p2.ProductID;
