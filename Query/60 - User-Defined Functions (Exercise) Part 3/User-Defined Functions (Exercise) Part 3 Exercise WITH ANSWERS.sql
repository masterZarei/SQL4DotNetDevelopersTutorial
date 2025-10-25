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


SELECT ContactName, dbo.fn_GetFullAddress(CustomerID) AS FullAddress
FROM Customers



-- 2. Return the average price of products in a specific category
CREATE FUNCTION fn_GetAveragePriceByCategory(@CategoryID INT)
RETURNS float
AS
BEGIN
    DECLARE @avgPrice float

    SELECT @avgPrice = AVG(Price)
    FROM Products
    WHERE CategoryID = @CategoryID

    RETURN ISNULL(@avgPrice, 0)
END;

SELECT CategoryID,dbo.fn_GetAveragePriceByCategory(CategoryID) AS AveragePrice
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

SELECT OrderID, dbo.fn_GetTotalQuantity(OrderID) AS TotalItems
FROM Orders





-- Inline Table-Valued Functions (iTVF)
-- 1. Returns all customers from a specific country
CREATE FUNCTION fn_GetCustomersByCountry(@Country NVARCHAR(50))
RETURNS TABLE
AS
RETURN
(
    SELECT CustomerID, ContactName, City, Country
    FROM Customers
    WHERE Country = @Country
)


SELECT * FROM dbo.fn_GetCustomersByCountry('France')


-- 2. Return all products between two given prices
CREATE FUNCTION fn_GetProductsBelowPrice(@MaxPrice float, @MinPrice float)
RETURNS TABLE
AS
RETURN
(
    SELECT * FROM Products
    WHERE Price BETWEEN @MaxPrice AND @MinPrice
)

SELECT * FROM dbo.fn_GetProductsBelowPrice(50,150)



-- 3. Return all orders placed in a specific year
CREATE FUNCTION fn_GetOrdersByYear(@Year INT)
RETURNS TABLE
AS
RETURN
(
    SELECT o.OrderID, c.CustomerID, o.OrderDate
    FROM Orders o
	JOIN customers c ON c.CustomerID = o.CustomerID
    WHERE YEAR(OrderDate) = @Year
)

SELECT * FROM dbo.fn_GetOrdersByYear(1997)



--Multi-Statement Table-Valued Functions (mTVF)
-- 1. Returns total quantity and total value for each product
CREATE FUNCTION fb_GetProductsSalesInfo()
RETURNS @Result TABLE
(
	ProductId INT,
	ProductName NVARCHAR(255),
	TotalQuantity INT,
	TotalRevenue float
)
AS
BEGIN
	INSERT INTO @Result
	SELECT
		p.ProductID,
		p.ProductName,
		SUM(od.Quantity),
		SUM(od.Quantity * p.Price)
	FROM products p
	LEFT JOIN order_details od ON od.ProductID = p.ProductID
	GROUP BY p.ProductID, p.ProductName

	RETURN;
END

SELECT * FROM dbo.fb_GetProductsSalesInfo()

 -- 2. Return total revenue and average sold price for each supplier
 CREATE FUNCTION fn_GetSuppliersSalesInfo()
 RETURNS @Info TABLE
 (
	SupplierId INT,
	SupplierName NVARCHAR(255),
	TotalRevenue float,
	AverageSold float
 )
 AS
 BEGIN
	DECLARE @ProductSales TABLE
	(
		ProductId INT,
		SupplierId INT,
		TotalRevenue float
	)
	INSERT INTO @ProductSales
	SELECT
		p.ProductID,
		p.SupplierID,
		SUM(od.Quantity * p.Price) AS TotalRevenue
	FROM products p
	JOIN order_details od ON od.ProductID = p.ProductID
	GROUP By p.ProductID, p.SupplierID


	INSERT INTO @Info
	SELECT 
		s.SupplierID,
		s.SupplierName,
		SUM(sp.TotalRevenue) AS TotalRevenue,
		AVG(p.Price) AS AveragePrice
	FROM suppliers s
	LEFT JOIN products p ON s.SupplierID = p.SupplierID
	LEFT JOIN @ProductSales sp ON sp.SupplierId = s.SupplierID
	GROUP BY s.SupplierID, s.SupplierName

	RETURN;
 END

 SELECT * FROM dbo.fn_GetSuppliersSalesInfo()
-- 3. Return all customers with classification based on total amount spent => X < 1000 Bronze, 1000 < X < 5000 Silver, X > 5000 Gold
ALTER FUNCTION fn_ClassifyCustomersBySpending()
RETURNS @Customers TABLE
(
	CustomerId INT,
	ContactName NVARCHAR(255),
	TotalSpent float,
	Category NVARCHAR(20)
)
AS
BEGIN
	INSERT INTO @Customers
	SELECT
		c.CustomerID,
		c.ContactName,
		SUM(od.Quantity * p.Price),
		CASE
			WHEN SUM(od.Quantity * p.Price) < 1000 THEN 'Bronze'
			WHEN SUM(od.Quantity * p.Price) BETWEEN 1000 AND 5000 THEN 'Silver'
			WHEN SUM(od.Quantity * p.Price) < 1000 THEN 'GOLD'
		END AS Category
	FROM customers c
	LEFT JOIN orders o ON o.CustomerID = c.CustomerID
	LEFT JOIN order_details od ON od.OrderID = o.OrderID
	LEFT JOIN products p ON p.ProductID = od.ProductID
	GROUP BY c.CustomerID, c.ContactName

	RETURN;
END

SELECT * FROM dbo.fn_ClassifyCustomersBySpending()