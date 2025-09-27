-- 1. Get total number of orders for a customer
CREATE PROCEDURE GetOrderCountByCustomer 
@CustomerID INT,
@TotalOrders INT OUTPUT
AS
BEGIN
    SELECT @TotalOrders = COUNT(*)
    FROM Orders WHERE CustomerID = @CustomerID;
END;

-- 2. Return highest product price
CREATE PROCEDURE GetMaxProductPrice 
@MaxPrice float OUTPUT
AS
BEGIN
    SELECT @MaxPrice = MAX(Price) FROM Products;
END;

-- 3. Return average product price
CREATE PROCEDURE GetAverageProductPrice 
@AvgPrice float OUTPUT
AS
BEGIN
    SELECT @AvgPrice = AVG(Price) FROM Products;
END;

-- 4. Return 1 if customer exists, 0 if not
CREATE PROCEDURE CheckCustomerExists 
@CustomerID INT
AS
BEGIN
    IF EXISTS(SELECT 1 FROM Customers WHERE CustomerID = @CustomerID)
        RETURN 1;
    ELSE
        RETURN 0;
END;
