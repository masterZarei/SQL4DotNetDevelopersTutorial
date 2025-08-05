-- SCALAR SUBQUERIES
-- 1. Get the average price of all products.
SELECT AVG(Price) FROM Products;

-- 2. Get the products with a price higher than the average price.
SELECT * FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products);

-- 3. Get the product with the highest price.
SELECT * FROM Products
WHERE Price = (SELECT MAX(Price) FROM Products);

-- 4.Count how many orders were made by the customer named 'Elizabeth Lincoln'
SELECT COUNT(*) FROM orders
WHERE CustomerID = (
    SELECT CustomerID
    FROM customers
    WHERE ContactName = 'Elizabeth Lincoln'
);

-- 5.Get the total quantity sold of the product named 'Chang'
SELECT SUM(Quantity)
FROM order_details 
WHERE ProductID = (
    SELECT ProductID
    FROM products
    WHERE ProductName = 'Chang'
);

-- 6. Get employees who were born in the same year as the employee with ID = 8 (excluding that employee)
SELECT * FROM employees
WHERE YEAR(BirthDate) = (
    SELECT YEAR(BirthDate)
    FROM employees
    WHERE EmployeeID = 8
)
AND EmployeeID <> 8;

