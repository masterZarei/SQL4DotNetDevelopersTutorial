--Purpose: Returns all products in a specific category
CREATE FUNCTION fn_GetProductsByCategory (@CategoryID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT ProductID, ProductName, Price
    FROM Products
    WHERE CategoryID = @CategoryID
);
-- Usage:
SELECT * FROM dbo.fn_GetProductsByCategory(1);

--Purpose: Returns all orders placed by a specific customer
CREATE FUNCTION fn_GetOrdersByCustomer (@CustomerID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT OrderID, OrderDate, ShipperID
    FROM Orders
    WHERE CustomerID = @CustomerID
);
-- Usage:
SELECT * FROM dbo.fn_GetOrdersByCustomer(2);


--Returns all orders with total amount greater than 1000
CREATE FUNCTION fn_GetHighValueOrders()
RETURNS TABLE
AS
RETURN
(
    SELECT o.OrderID, c.CustomerName, SUM(od.Quantity * p.Price) AS TotalAmount
    FROM Orders o
    JOIN Order_Details od ON o.OrderID = od.OrderID
    JOIN Products p ON od.ProductID = p.ProductID
    JOIN Customers c ON o.CustomerID = c.CustomerID
    GROUP BY o.OrderID, c.CustomerName
    HAVING SUM(od.Quantity * p.Price) > 1000
);
-- Usage:
SELECT * FROM dbo.fn_GetHighValueOrders();


--Returns each customer with total orders and total sales
CREATE FUNCTION fn_GetCustomerOrderSummary()
RETURNS TABLE
AS
RETURN
(
    SELECT 
        c.CustomerID,
        c.CustomerName,
        COUNT(o.OrderID) AS TotalOrders,
        SUM(od.Quantity * p.Price) AS TotalSales
    FROM Customers c
    LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
    LEFT JOIN Order_Details od ON o.OrderID = od.OrderID
    LEFT JOIN Products p ON od.ProductID = p.ProductID
    GROUP BY c.CustomerID, c.CustomerName
);
-- Usage:
SELECT * FROM dbo.fn_GetCustomerOrderSummary();

