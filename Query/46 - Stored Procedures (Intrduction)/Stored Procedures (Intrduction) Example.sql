--Stored Procedure
-- 1. Get all customers
CREATE PROC GetAllCustomers
AS
BEGIN
	SELECT * FROM customers
END;

EXEC GetAllCustomers;

-- 2. Get all products
CREATE PROC GetAllProducts
AS
BEGIN
	SELECT * FROM products
END;

EXEC GetAllProducts;


-- 3. Get top 10 expensive products
CREATE PROC GetTop10ExpensiveProducts
AS
BEGIN
	SELECT TOP 10 ProductName,Price 
	FROM products
	ORDER BY PRICE DESC;
END;

EXEC GetTop10ExpensiveProducts;