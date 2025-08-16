-- 1. Show all customers who have placed at least one order 
--(list their names and OrderID).
SELECT Customers.CustomerName, Orders.OrderID
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

-- 2. Show all products that have been sold at least once
--(list ProductName and Quantity).
SELECT Products.ProductName, Order_Details.Quantity
FROM Products
INNER JOIN Order_Details ON Products.ProductID = Order_Details.ProductID;

-- 3. Show all employees along with the orders they handled.
SELECT Employees.FirstName, Orders.OrderID
FROM Employees
INNER JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID;

-- 4. Show all orders with their customer name.
SELECT Orders.OrderID, Customers.CustomerName
FROM Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

-- 5. Show all order details with the product name and price.
SELECT Order_Details.OrderID, Products.ProductName, products.Price
FROM Order_Details
INNER JOIN Products ON Order_Details.ProductID = Products.ProductID;
