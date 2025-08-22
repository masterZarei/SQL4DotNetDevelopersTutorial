SELECT * INTO CustomersBackup
FROM Customers;


SELECT * INTO GermanCustomers
FROM Customers
WHERE Country = 'Germany';


SELECT CustomerName, City, Country
INTO CustomersLocation
FROM Customers;

SELECT Customers.CustomerName, SUM(order_details.Quantity) AS TotalQuantity
INTO CustomersOrderReport14041231
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
INNER JOIN order_details ON Orders.OrderID = order_details.OrderID
GROUP BY Customers.CustomerName;