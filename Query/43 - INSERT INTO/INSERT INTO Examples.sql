-- 1. Insert all customers into an existing backup table
INSERT INTO CustomersBackup
SELECT * FROM Customers;

-- 2. Insert only French customers into an existing table
INSERT INTO CustomersBackup
SELECT * FROM Customers
WHERE Country = 'France';

-- 3. Insert selected columns into a table with matching schema
INSERT INTO CustomersLocation (CustomerName, City, Country)
SELECT CustomerName, City, Country
FROM Customers
WHERE Country = 'Brazil';
