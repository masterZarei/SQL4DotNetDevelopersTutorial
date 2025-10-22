--Displays all customers located in London
CREATE VIEW vw_LondonCustomers
AS
SELECT ContactName, Address, Country
FROM customers
WHERE City = 'London'

SELECT * FROM vw_LondonCustomers

--Displays all orders with their corresponding customer names
CREATE VIEW vw_CustomerOrders
AS
SELECT c.ContactName, o.OrderId, o.OrderDate
FROM customers c
JOIN Orders o ON o.CustomerID = c.CustomerID

SELECT * FROM vw_CustomerOrders

--Shows total quantity and total revenue for top 10 top selling product
CREATE VIEW vw_TopSellingProducts
AS
SELECT Top 10 p.ProductName,
		p.Price,
		SUM(od.Quantity) AS 'Total Sold' ,
		SUM(od.Quantity * p.Price) AS 'Total Revenue'
FROM Products p
LEFT JOIN order_details od ON p.ProductID = od.ProductID
GROUP BY p.Price, p.ProductName
ORDER By SUM(od.Quantity) Desc 


