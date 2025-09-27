-- 1. Get all customers
CREATE PROCEDURE GetAllCustomers
AS
BEGIN
    SELECT * FROM Customers;
END;

-- 2. Get all products
CREATE PROCEDURE GetAllProducts
AS
BEGIN
    SELECT * FROM Products;
END;

-- 3. Get all orders
CREATE PROCEDURE GetAllOrders
AS
BEGIN
    SELECT * FROM Orders;
END;

-- 4. Get all employees
CREATE PROCEDURE GetAllEmployees
AS
BEGIN
    SELECT * FROM Employees;
END;

-- 5. Get top 10 expensive products
CREATE PROCEDURE GetTop10ExpensiveProducts
AS
BEGIN
    SELECT TOP 10 ProductName, Price
    FROM Products
    ORDER BY Price DESC;
END;


