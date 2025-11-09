-- Create a log table to store customer insert actions
CREATE TABLE CustomerLog (
    LogID INT IDENTITY PRIMARY KEY,       
    CustomerID INT,                       
    Action NVARCHAR(50),                  
    ActionDate DATETIME DEFAULT GETDATE() 
);

-- Trigger to automatically log when a new customer is inserted
CREATE TRIGGER trg_AfterCustomerInsert
ON Customers
AFTER INSERT
AS
BEGIN
    INSERT INTO CustomerLog (CustomerID, Action)
    SELECT CustomerID, 'INSERT' FROM inserted; 
END;

-- Test trigger by adding a new customer
INSERT INTO Customers (CustomerName, City)
VALUES ('Alex Brown', 'Paris');

-- View log table data
SELECT * FROM CustomerLog;



-- Create a table to track product price changes
CREATE TABLE ProductPriceHistory (
    HistoryID INT IDENTITY PRIMARY KEY,       
    ProductID INT,                            
    OldPrice DECIMAL(10,2),                   
    NewPrice DECIMAL(10,2),                   
    ChangeDate DATETIME DEFAULT GETDATE()     
);

-- Trigger to log price updates on Products table
CREATE TRIGGER trg_ProductPriceUpdate
ON Products
AFTER UPDATE
AS
BEGIN
    INSERT INTO ProductPriceHistory (ProductID, OldPrice, NewPrice)
    SELECT d.ProductID, d.Price, i.Price
    FROM deleted d
    JOIN inserted i ON d.ProductID = i.ProductID
    WHERE d.Price <> i.Price; -- Only log if price actually changed
END;

-- Test trigger by updating product prices
UPDATE Products SET Price = Price + 10 WHERE ProductID = 1;

-- View price change history
SELECT * FROM ProductPriceHistory;



-- Trigger to prevent customer deletions (blocks DELETE action)
CREATE TRIGGER trg_PreventCustomerDeletion
ON Customers
INSTEAD OF DELETE
AS
BEGIN
    PRINT 'Customers cannot be deleted!'; -- Notify attempt to delete
END;

-- Test delete prevention
DELETE FROM Customers WHERE CustomerName = 'Elizabeth Lincoln';



-- Database-level trigger to prevent table deletion
CREATE TRIGGER trg_BlockTableDrop
ON DATABASE
FOR DROP_TABLE
AS
BEGIN
    PRINT 'Dropping tables is not allowed in this database.';
    ROLLBACK; -- Cancel the DROP operation
END;
