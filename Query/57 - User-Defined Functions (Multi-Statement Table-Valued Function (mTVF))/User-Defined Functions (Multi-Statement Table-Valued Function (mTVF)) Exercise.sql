--Returns total order quantity and total spent amount for each Customer
CREATE FUNCTION fn_GetCustomerOrderSummary()
RETURNS @Result TABLE
(
	CustomerId INT,
	CustomerName NVARCHAR(255),
	TotalOrders INT,
	TotalSpent float
)
AS
BEGIN
	INSERT INTO @Result
	SELECT c.CustomerID, c.ContactName, COUNT(o.OrderId), SUM(od.Quantity * p.Price)
	FROM customers c
	LEFT JOIN orders o ON o.CustomerID = c.CustomerID
	LEFT JOIN order_details od ON od.OrderID = o.OrderID
	LEFT JOIN products p ON p.ProductID = od.ProductID
	GROUP BY c.CustomerID, c.ContactName

	RETURN;
END

SELECT * FROM dbo.fn_GetCustomerOrderSummary()

--Returns all orders with total price above a threshold
CREATE FUNCTION fn_GetOrdersAboveAmount(@MinAmount float)
RETURNS @Orders TABLE
(
	OrderId INT,
	CustomerId INT,
	TotalAmount float
)
AS
BEGIN
	INSERT @Orders
	SELECT o.OrderID, o.CustomerID, SUM(od.Quantity * p.Price)
	FROM orders o
    JOIN order_details od ON od.OrderID = o.OrderID
    JOIN products p ON p.ProductID = od.ProductID
	GROUP BY o.OrderID, o.CustomerID
	HAVING SUM(od.Quantity * p.Price) > @MinAmount

	RETURN;
END

SELECT * FROM dbo.fn_GetOrdersAboveAmount(2000)

--Classify each product into 'Low', 'Medium', or 'High' price category
CREATE FUNCTION fn_ClassifyProducts()
RETURNS @Products TABLE
(
	ProductId INT,
	ProductName NVARCHAR(255),
	Price float,
	Category NVARCHAR(10)
)
AS
BEGIN
	INSERT INTO @Products
	SELECT ProductID, ProductName, Price,
		CASE
			WHEN Price < 20 THEN 'LOW'
			WHEN Price BETWEEN 20 AND 50 THEN 'MEDIUM'
			ELSE 'HIGH'
		END
	FROM products

	RETURN;
END

SELECT * FROM dbo.fn_ClassifyProducts()