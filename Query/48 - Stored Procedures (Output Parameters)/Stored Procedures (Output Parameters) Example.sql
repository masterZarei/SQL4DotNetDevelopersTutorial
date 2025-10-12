-- 1. Get total number of orders for a customer
CREATE PROC GetOrderCountByCustomerId
@CustomerId INT,
@TotalOrders INT OUTPUT
AS
BEGIN
	SELECT @TotalOrders = COUNT(*) FROM orders
	WHERE CustomerID = @CustomerId
END

Declare @tl INT
EXEC GetOrderCountByCustomerId 5, @tl OUTPUT
Select @tl

-- 2. Return highest product price
CREATE PROC GetMaxProductPrice
@MaxPrice float OUTPUT
AS
BEGIN
	SELECT @MaxPrice = MAX(PRICE) FROM PRODUCTS
END

-- 3. Return 1 if customer exists, 0 if not
CREATE PROC CheckIfCustomerExists
@CustomerId INT
AS
BEGIN
	IF EXISTS(SELECT 1 FROM customers WHERE CustomerID = @CustomerId)
		RETURN 1;
	ELSE
		RETURN 0;
END
