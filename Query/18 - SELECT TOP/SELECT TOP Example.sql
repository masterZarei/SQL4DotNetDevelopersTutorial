-- Returns Top 5 Customers.
SELECT TOP 5 * FROM Customers;

-- Returns 50 Percent of all Customers.
SELECT TOP 50 PERCENT * FROM Customers;

-- Returns last 3 Added Customers.
SELECT TOP 3 * FROM Customers
ORDER BY CustomerName DESC;