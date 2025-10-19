--Returns the age of an employee based on their birth date.
CREATE FUNCTION fn_GetEmployeeAge (@BirthDate DATE)
RETURNS INT
AS
BEGIN
	RETURN DATEDIFF(YEAR, @BirthDate, GETDATE())
END
-- Usage:
SELECT FirstName, LastName, dbo.fn_GetEmployeeAge(BirthDate)
FROM employees


--Concatenates first and last name into a full name.
CREATE FUNCTION fn_GetFullName(@firstName NVARCHAR(255), @lastName NVARCHAR(255))
RETURNS NVARCHAR(255)
AS
BEGIN
	RETURN @firstName + ' ' + @lastName
END
-- Usage:
SELECT dbo.fn_GetFullName(FirstName, LastName) AS FullName
From employees



--Returns total value of a specific order.
CREATE FUNCTION fn_GetOrderTotal(@OrderId INT)
RETURNS float
AS
BEGIN
	DECLARE @Total float
	SELECT @Total = SUM(Quantity * p.price)
	FROM order_details od
	JOIN products p ON p.ProductID = od.ProductID
	WHERE od.OrderID = @OrderId

	RETURN ISNULL(@Total,0);
END
-- Usage:
SELECT OrderID, dbo.fn_GetOrderTotal(OrderId) AS TotalPrice
FROM orders