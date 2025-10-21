--Purpose: Returns total quantity and total sales amount for each product
CREATE FUNCTION fn_GetProductSalesSummary_mTVF()
RETURNS @Result TABLE
(
    ProductID INT,
    ProductName NVARCHAR(100),
    TotalQuantity INT,
    TotalSales DECIMAL(18,2)
)
AS
BEGIN
    -- Insert aggregated data (sales info) into the result table
    INSERT INTO @Result
    SELECT 
        p.ProductID,
        p.ProductName,
        SUM(od.Quantity) AS TotalQuantity,
        SUM(od.Quantity * p.Price) AS TotalSales
    FROM Products p
    LEFT JOIN Order_Details od ON p.ProductID = od.ProductID
    GROUP BY p.ProductID, p.ProductName;

    -- Return the final result set
    RETURN;
END;

--Usage:
SELECT * FROM dbo.fn_GetProductSalesSummary_mTVF();



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
