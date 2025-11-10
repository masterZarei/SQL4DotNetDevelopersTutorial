-- Log table to record customer actions (e.g. insert)
CREATE TABLE CustomerLog(
	LogId INT PRIMARY KEY IDENTITY,
	CustomerId INT,
	[Action] NVARCHAR(255),
	ActionDate DATETIME DEFAULT GETDATE()
);

-- Trigger: logs a record after a new customer is inserted
CREATE TRIGGER trg_AfterCustomerInsert
ON Customers
AFTER INSERT
AS
BEGIN
	INSERT INTO CustomerLog(CustomerId, [Action])
	SELECT CustomerId, 'INSERT' FROM inserted;
END;

-- Test insert to fire the trigger
INSERT INTO Customers (ContactName, City)
VALUES('Mohammad', 'Shiraz');

-- Table to store product price change history
CREATE TABLE ProductPriceHistory(
	HistoryId INT PRIMARY KEY IDENTITY,
	ProductId INT,
	OldPrice FLOAT,
	NewPrice FLOAT,
	ChangeDate DATETIME DEFAULT GETDATE()
);

-- Trigger: logs old and new prices when product price is updated
CREATE TRIGGER trg_ProductPriceUpdate
ON Products
AFTER UPDATE
AS
BEGIN
	INSERT INTO ProductPriceHistory(ProductId, OldPrice, NewPrice)
	SELECT d.ProductId, d.Price, i.Price
	FROM deleted d
	JOIN inserted i ON d.ProductID = i.ProductID
	WHERE d.Price <> i.Price;
END;

-- Trigger: prevents any deletion from Customers table
CREATE TRIGGER trg_PreventCustomerDeletion
ON Customers
INSTEAD OF DELETE
AS
BEGIN
	PRINT 'Customers cannot be deleted';
END;

-- Test delete to fire prevention trigger
DELETE FROM Customers;

-- Database-level trigger: blocks table deletion across the database
CREATE TRIGGER trg_BlockTableDrop
ON DATABASE
FOR DROP_TABLE
AS
BEGIN
	PRINT 'Dropping tables are not allowed in this Database';
	ROLLBACK;
END;

-- Test database-level trigger
DROP TABLE Products;
