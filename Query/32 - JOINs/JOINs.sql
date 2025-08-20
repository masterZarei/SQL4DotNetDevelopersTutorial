--(INNER) JOIN: Returns records that have matching values in both tables
--LEFT (OUTER) JOIN: Returns all records from the left table, and the matched records from the right table
--RIGHT (OUTER) JOIN: Returns all records from the right table, and the matched records from the left table
--FULL (OUTER) JOIN: Returns all records when there is a match in either left or right table

-- نمایش نام مشتری و مجموع تعداد محصولاتی که سفارش داده
SELECT Customers.CustomerName, SUM(order_details.Quantity) AS TotalQuantity
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
INNER JOIN order_details ON Orders.OrderID = order_details.OrderID
GROUP BY Customers.CustomerName;
