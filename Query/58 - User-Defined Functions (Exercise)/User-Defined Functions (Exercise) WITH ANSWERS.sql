-- Scalar Functions (Returns a single value)
-- 1. Returns the full address of a customer (Address + City + Country)
CREATE FUNCTION fn_GetFullAddress(@CustomerID INT)
RETURNS NVARCHAR(255)
AS
BEGIN
    DECLARE @Address NVARCHAR(255)
    SELECT @Address = Address + ', ' + City + ', ' + Country
    FROM Customers
    WHERE CustomerID = @CustomerID

    RETURN @Address
END

-- Usage:
SELECT CustomerName, dbo.fn_GetFullAddress(CustomerID) AS FullAddress
FROM Customers



-- 2. Return the average price of products in a specific category
CREATE FUNCTION fn_GetAveragePriceByCategory(@CategoryID INT)
RETURNS float
AS
BEGIN
    DECLARE @AvgPrice float

    SELECT @AvgPrice = AVG(Price)
    FROM Products
    WHERE CategoryID = @CategoryID

    RETURN ISNULL(@AvgPrice, 0)
END;

-- Usage:
SELECT 
    CategoryID, 
    dbo.fn_GetAveragePriceByCategory(CategoryID) AS AveragePrice
FROM Categories;




-- 3. Returns the total quantity of items in a given order
CREATE FUNCTION fn_GetTotalQuantity(@OrderID INT)
RETURNS INT
AS
BEGIN
    DECLARE @TotalQty INT
    SELECT @TotalQty = SUM(Quantity) 
    FROM Order_Details 
    WHERE OrderID = @OrderID

    RETURN ISNULL(@TotalQty, 0)
END

-- Usage:
SELECT OrderID, dbo.fn_GetTotalQuantity(OrderID) AS TotalItems
FROM Orders



-- Inline Table-Valued Functions (iTVF)
-- 1. Returns all customers from a specific country
CREATE FUNCTION fn_GetCustomersByCountry(@Country NVARCHAR(50))
RETURNS TABLE
AS
RETURN
(
    SELECT CustomerID, CustomerName, City, Country
    FROM Customers
    WHERE Country = @Country
)

-- Usage:
SELECT * FROM dbo.fn_GetCustomersByCountry('USA')


-- 2. Returns all products cheaper than a given price
CREATE FUNCTION fn_GetProductsBelowPrice(@MaxPrice DECIMAL(10,2))
RETURNS TABLE
AS
RETURN
(
    SELECT ProductID, ProductName, Price
    FROM Products
    WHERE Price < @MaxPrice
)

-- Usage:
SELECT * FROM dbo.fn_GetProductsBelowPrice(25)



-- 3. Returns all orders placed in a specific year
CREATE FUNCTION fn_GetOrdersByYear(@Year INT)
RETURNS TABLE
AS
RETURN
(
    SELECT OrderID, CustomerID, OrderDate
    FROM Orders
    WHERE YEAR(OrderDate) = @Year
)

-- Usage:
SELECT * FROM dbo.fn_GetOrdersByYear(1997)



--Multi-Statement Table-Valued Functions (mTVF)
-- 1. Returns total quantity and total value for each product
CREATE FUNCTION fn_GetProductSalesSummary()
RETURNS @Result TABLE
(
    ProductID INT,
    ProductName NVARCHAR(255),
    TotalQuantity INT,
    TotalRevenue DECIMAL(18,2)
)
AS
BEGIN
    INSERT INTO @Result
    SELECT 
        p.ProductID,
        p.ProductName,
        SUM(od.Quantity),
        SUM(od.Quantity * p.Price)
    FROM Products p
    LEFT JOIN Order_Details od ON p.ProductID = od.ProductID
    GROUP BY p.ProductID, p.ProductName

    RETURN;
END

-- Usage:
SELECT * FROM dbo.fn_GetProductSalesSummary()

 -- 2. Return total revenue and average sold price for each supplier
CREATE FUNCTION fn_GetSupplierSalesSummary()
RETURNS @Summary TABLE
(
    SupplierID INT,
    SupplierName NVARCHAR(255),
    TotalRevenue float,
    AvgSoldPrice float
)
AS
BEGIN
    -- Step 1: Calculate total sales per product
    DECLARE @ProductSales TABLE
    (
        ProductID INT,
        SupplierID INT,
        TotalRevenue float
    )

    INSERT INTO @ProductSales
    SELECT 
        p.ProductID,
        p.SupplierID,
        SUM(od.Quantity * p.Price) AS TotalRevenue
    FROM Products p
    JOIN Order_Details od ON p.ProductID = od.ProductID
    GROUP BY p.ProductID, p.SupplierID

    -- Step 2: Aggregate data per supplier
    INSERT INTO @Summary
    SELECT 
        s.SupplierID,
        s.SupplierName,
        SUM(ps.TotalRevenue) AS TotalRevenue,
        AVG(p.Price) AS AvgSoldPrice
    FROM Suppliers s
    LEFT JOIN Products p ON s.SupplierID = p.SupplierID
    LEFT JOIN @ProductSales ps ON ps.SupplierID = s.SupplierID
    GROUP BY s.SupplierID, s.SupplierName

    RETURN;
END;

-- Usage:
SELECT * FROM dbo.fn_GetSupplierSalesSummary();


-- 3. Returns all customers with classification based on total amount spent => X < 1000 Bronze, 1000 < X < 5000 Silver, X > 5000 Gold
CREATE FUNCTION fn_ClassifyCustomersBySpending()
RETURNS @Customers TABLE
(
    CustomerID INT,
    CustomerName NVARCHAR(255),
    TotalSpent DECIMAL(18,2),
    Category NVARCHAR(20)
)
AS
BEGIN
    INSERT INTO @Customers
    SELECT 
        c.CustomerID,
        c.CustomerName,
        SUM(od.Quantity * p.Price),
        CASE
            WHEN SUM(od.Quantity * p.Price) < 1000 THEN 'Bronze'
            WHEN SUM(od.Quantity * p.Price) BETWEEN 1000 AND 5000 THEN 'Silver'
            ELSE 'Gold'
        END AS Category
    FROM Customers c
    LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
    LEFT JOIN Order_Details od ON o.OrderID = od.OrderID
    LEFT JOIN Products p ON od.ProductID = p.ProductID
    GROUP BY c.CustomerID, c.CustomerName

    RETURN;
END

-- Usage:
SELECT * FROM dbo.fn_ClassifyCustomersBySpending()
