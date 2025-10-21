--Create a clustered index on CustomerID column
CREATE CLUSTERED INDEX IX_Customers_CustomerID
ON Customers(CustomerID);


--Create a non-clustered index on CustomerName
CREATE NONCLUSTERED INDEX IX_Customers_CustomerName
ON Customers(ContactName);
