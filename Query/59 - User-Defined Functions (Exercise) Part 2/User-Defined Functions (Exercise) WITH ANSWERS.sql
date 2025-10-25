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

