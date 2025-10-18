--Returns the age of an employee based on their birth date.
CREATE FUNCTION fn_GetEmployeeAge (@BirthDate DATE)
RETURNS INT
AS
BEGIN
    RETURN DATEDIFF(YEAR, @BirthDate, GETDATE());
END;

-- Usage:
SELECT FirstName, LastName, dbo.fn_GetEmployeeAge(BirthDate) AS Age
FROM Employees;



--Concatenates first and last name into a full name.
CREATE FUNCTION fn_GetFullName (@FirstName NVARCHAR(50), @LastName NVARCHAR(50))
RETURNS NVARCHAR(100)
AS
BEGIN
    RETURN @FirstName + ' ' + @LastName;
END;


-- Usage:
SELECT dbo.fn_GetFullName(FirstName, LastName) AS FullName
FROM Employees;


--Returns total value of a specific order.
CREATE FUNCTION fn_GetOrderTotal (@OrderID INT)
RETURNS DECIMAL(18,2)
AS
BEGIN
    DECLARE @Total DECIMAL(18,2);

    SELECT @Total = SUM(Quantity * p.Price)
    FROM Order_Details od
    JOIN Products p ON od.ProductID = p.ProductID
    WHERE od.OrderID = @OrderID;

    RETURN ISNULL(@Total, 0);
END;

-- Usage:
SELECT OrderID, dbo.fn_GetOrderTotal(OrderID) AS TotalAmount
FROM Orders;