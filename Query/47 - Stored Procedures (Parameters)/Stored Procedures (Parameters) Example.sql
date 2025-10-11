-- Get orders by customer ID
CREATE PROC GetOrdersByCustomerID
@CustomerId INT
AS
BEGIN
	SELECT * FROM ORDERS WHERE CustomerID = @CustomerId
END;

EXEC GetOrdersByCustomerID 9;

-- Get products more expensive than a price
CREATE PROC GetProductsAbovePrice
@MinPrice float
AS
BEGIN
	SELECT * FROM PRODUCTS
	WHERE Price > @MinPrice
END;

EXEC GetProductsAbovePrice 15

-- Get products in a specific category
CREATE PROC GetProductsByCategoryName
@CategoryName nvarchar(255)
AS
BEGIN
	SELECT * FROM products
	INNER JOIN categories ON products.CategoryID = categories.CategoryID
	WHERE CategoryName = @CategoryName
END;

EXEC GetProductsByCategoryName 'Seafood'