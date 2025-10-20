--Returns all products in a specific category
CREATE FUNCTION fn_GetCategoryProducts(@CategoryId INT)
RETURNS TABLE
AS
RETURN
(
	SELECT ProductName, Price
	FROM products
	WHERE CategoryID = @CategoryId
)

SELECT * FROM dbo.fn_GetCategoryProducts(3)

--Returns all orders placed by a specific customer
CREATE FUNCTION fn_GetOrdersByCustomerId(@CustomerId INT)
RETURNS TABLE
AS
RETURN
(
	SELECT OrderID, OrderDate, ShipperID
	FROM orders
	WHERE CustomerID = @CustomerId
)
SELECT * FROM dbo.fn_GetOrdersByCustomerId(10)

--Returns all orders with total amount greater than 1000
CREATE FUNCTION fn_GetHighValueOrders()
RETURNS TABLE
AS
RETURN
(
	SELECT o.OrderID, c.ContactName, SUM(od.Quantity * p.Price) AS TotalAmount
	FROM orders o
	JOIN customers c ON c.CustomerID = o.CustomerID
	JOIN order_details od ON od.OrderID = o.OrderID
	JOIN products p ON od.ProductID = p.ProductID
	GROUP BY o.OrderID, c.ContactName
	HAVING SUM(od.Quantity * p.Price) > 1000
)

SELECT * FROM dbo.fn_GetHighValueOrders()