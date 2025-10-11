-- CREATE
CREATE PROCEDURE AddProduct
    @ProductName NVARCHAR(100),
    @Price DECIMAL(10,2),
    @CategoryID INT
AS
BEGIN
    INSERT INTO Products (ProductName, Price, CategoryID)
    VALUES (@ProductName, @Price, @CategoryID);
END;

-- READ
CREATE PROCEDURE GetProductByID @ProductID INT
AS
BEGIN
    SELECT * FROM Products WHERE ProductID = @ProductID;
END;

-- UPDATE
CREATE PROCEDURE UpdateProductPrice
    @ProductID INT,
    @NewPrice DECIMAL(10,2)
AS
BEGIN
    UPDATE Products SET Price = @NewPrice WHERE ProductID = @ProductID;
END;

-- DELETE
CREATE PROCEDURE DeleteProduct @ProductID INT
AS
BEGIN
    DELETE FROM Products WHERE ProductID = @ProductID;
END;
