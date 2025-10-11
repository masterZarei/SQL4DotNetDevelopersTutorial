CREATE PROCEDURE AddCustomer
    @CustomerName NVARCHAR(100),
    @ContactName NVARCHAR(100),
    @City NVARCHAR(50),
    @Country NVARCHAR(50)
AS
BEGIN
    BEGIN TRY
        INSERT INTO Customers (CustomerName, ContactName, City, Country)
        VALUES (@CustomerName, @ContactName, @City, @Country);

        PRINT 'Customer added successfully!';
    END TRY
    BEGIN CATCH
        PRINT 'Error inserting customer!';
    END CATCH
END;

-- Execution
EXEC AddCustomer 'Microsoft', 'Bill Gates', 'Redmond', 'USA';


CREATE PROCEDURE GetCustomersByCountry @Country NVARCHAR(50)
AS
BEGIN
    SELECT CustomerID, CustomerName, City
    FROM Customers
    WHERE Country = @Country;
END;

-- Execution
EXEC GetCustomersByCountry 'Germany';



CREATE PROCEDURE UpdateCustomerCity
    @CustomerID INT,
    @NewCity NVARCHAR(50)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Customers WHERE CustomerID = @CustomerID)
        UPDATE Customers SET City = @NewCity WHERE CustomerID = @CustomerID;
    ELSE
        PRINT 'Customer not found!';
END;

-- Execution
EXEC UpdateCustomerCity @CustomerID = 1, @NewCity = 'London';



CREATE PROCEDURE DeleteCustomerByID @CustomerID INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Orders WHERE CustomerID = @CustomerID)
    BEGIN
        PRINT 'Cannot delete this customer. There are existing orders.';
        RETURN;
    END

    DELETE FROM Customers WHERE CustomerID = @CustomerID;
    PRINT 'Customer deleted successfully.';
END;

-- Execution
EXEC DeleteCustomerByID 2;



