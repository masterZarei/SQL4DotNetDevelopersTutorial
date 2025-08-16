-- 1. Show all orders with customer names 
--(include orders even if the customer info is missing).
SELECT Orders.OrderID, Customers.CustomerName
FROM Customers
RIGHT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

-- 2. Show all order details with product names
--(include order details even if product info is missing).
SELECT Order_Details.OrderID, Products.ProductName, Order_Details.Quantity
FROM Products
RIGHT JOIN Order_Details ON Products.ProductID = Order_Details.ProductID;

-- 3. Show all orders with employee names 
--(include orders even if the employee info is missing).
SELECT Orders.OrderID, Employees.FirstName
FROM Employees
RIGHT JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID;

-- 4. Show all orders with their shipping company name 
--(include orders even if company info is missing).
SELECT Orders.OrderID, Shippers.ShipperName
FROM Shippers
RIGHT JOIN Orders ON Shippers.ShipperID = Orders.ShipperID;

-- 5. Show all order details with category name of products 
--(include details even if category info is missing).
SELECT Order_Details.OrderID, Categories.CategoryName
FROM Categories
RIGHT JOIN Products ON Categories.CategoryID = Products.CategoryID
RIGHT JOIN Order_Details ON Products.ProductID = Order_Details.ProductID;
