-- CROSS JOIN WITH ANSWERS

-- Show all combinations of employees and shippers
SELECT Employees.FirstName, Shippers.ShipperName
FROM Employees
CROSS JOIN Shippers;

-- Show all combinations of categories and suppliers
SELECT Categories.CategoryName, Suppliers.Country
FROM Categories
CROSS JOIN Suppliers;

-- Show all combinations of customers and products
SELECT Customers.CustomerName, Products.ProductName
FROM Customers
CROSS JOIN Products;
