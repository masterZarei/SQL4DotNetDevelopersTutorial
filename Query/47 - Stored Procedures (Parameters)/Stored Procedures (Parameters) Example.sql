-- 1. Get orders by customer ID
CREATE PROCEDURE GetOrdersByCustomerID
@CustomerID INT
AS
BEGIN
    SELECT * FROM Orders WHERE CustomerID = @CustomerID;
END;

-- 2. Get products more expensive than a price
CREATE PROCEDURE GetProductsAbovePrice
@MinPrice float
AS
BEGIN
    SELECT * FROM Products WHERE Price > @MinPrice;
END;

-- 3. Get customer info by city
CREATE PROCEDURE GetCustomersByCity 
@City NVARCHAR(50)
AS
BEGIN
    SELECT * FROM Customers WHERE City = @City;
END;


-- 4. Get products in a specific category
CREATE PROCEDURE GetProductsByCategory 
@CategoryID INT
AS
BEGIN
    SELECT * FROM Products WHERE CategoryID = @CategoryID;
END;
