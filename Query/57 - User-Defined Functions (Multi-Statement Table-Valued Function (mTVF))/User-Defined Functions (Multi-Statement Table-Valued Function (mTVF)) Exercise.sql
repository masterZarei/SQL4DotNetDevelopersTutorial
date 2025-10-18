--Returns a list of customers with their total orders and total spent
CREATE FUNCTION fn_GetCustomerOrderSummary_mTVF()
RETURNS @Result TABLE
(
    CustomerID INT,
    CustomerName NVARCHAR(100),
    TotalOrders INT,
    TotalAmount DECIMAL(18,2)
)
AS
BEGIN
    INSERT INTO @Result
    SELECT 
        c.CustomerID,
        c.CustomerName,
        COUNT(o.OrderID),
        SUM(od.Quantity * p.Price)
    FROM Customers c
    LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
    LEFT JOIN Order_Details od ON o.OrderID = od.OrderID
    LEFT JOIN Products p ON od.ProductID = p.ProductID
    GROUP BY c.CustomerID, c.CustomerName;

    RETURN;
END;

-- Usage:
SELECT * FROM dbo.fn_GetCustomerOrderSummary_mTVF();


--Returns all orders with total price above a threshold
CREATE FUNCTION fn_GetOrdersAboveAmount (@MinAmount DECIMAL(10,2))
RETURNS @Orders TABLE
(
    OrderID INT,
    CustomerID INT,
    TotalAmount DECIMAL(18,2)
)
AS
BEGIN
    INSERT INTO @Orders
    SELECT o.OrderID, o.CustomerID, SUM(od.Quantity * p.Price)
    FROM Orders o
    JOIN Order_Details od ON o.OrderID = od.OrderID
    JOIN Products p ON od.ProductID = p.ProductID
    GROUP BY o.OrderID, o.CustomerID
    HAVING SUM(od.Quantity * p.Price) > @MinAmount;

    RETURN;
END;

-- Usage:
SELECT * FROM dbo.fn_GetOrdersAboveAmount(500);

-- Purpose: Classify each product into 'Low', 'Medium', or 'High' price category
CREATE FUNCTION fn_ClassifyProducts()
RETURNS @Products TABLE
(
    ProductID INT,
    ProductName NVARCHAR(100),
    Price DECIMAL(10,2),
    Category NVARCHAR(10)
)
AS
BEGIN
    INSERT INTO @Products
    SELECT ProductID, ProductName, Price,
           CASE 
               WHEN Price < 20 THEN 'Low'
               WHEN Price BETWEEN 20 AND 50 THEN 'Medium'
               ELSE 'High'
           END
    FROM Products;

    RETURN;
END;

-- Usage:
SELECT * FROM dbo.fn_ClassifyProducts();
