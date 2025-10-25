-- Scalar Functions (Returns a single value)
-- 1. Return the full address of a customer (Address + City + Country)
CREATE FUNCTION fn_GetFullAddress(@CustomerId Int)
RETURNS NVARCHAR(255)
AS
BEGIN
	DECLARE @Address NVARCHAR(255)
	SELECT @Address = [Address] + ' ,' + City + ' ,' + Country
	FROM customers
	WHERE CustomerID = @CustomerId

	RETURN @Address 
END

SELECT ContactName, dbo.fn_GetFullAddress(CustomerId) AS FullAddress
FROM customers

-- 2. Return the average price of products in a specific category
CREATE FUNCTION fn_GetAveragePriceByCategory(@CategoryId INT)
RETURNS float
BEGIN
	DECLARE @avgPrice float
	SELECT @avgPrice = AVG(Price)
	FROM products
	WHERE CategoryID = @CategoryId

	RETURN ISNULL(@avgPrice, 0)
END

SELECT CategoryName, dbo.fn_GetAveragePriceByCategory(CategoryId) AS AveragePrice
From categories

-- 3. Return the total quantity of items in a given order
CREATE FUNCTION fn_GetTotalQuantity(@OrderId INT)
RETURNS INT
BEGIN
	DECLARE @TotalQty INT
	SELECT @TotalQty = SUM(Quantity)
	FROM order_details
	WHERE OrderID = @OrderId

	RETURN ISNULL(@TotalQty, 0)
END

SELECT OrderId, dbo.fn_GetTotalQuantity(OrderId)
FROM orders