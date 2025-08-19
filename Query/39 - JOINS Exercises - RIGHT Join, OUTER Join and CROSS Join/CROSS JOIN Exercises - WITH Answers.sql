-- CROSS JOIN

-- Show all combinations of employees and shippers
SELECT employees.FirstName, shippers.ShipperName
FROM employees
CROSS JOIN shippers

-- Show all combinations of categories and suppliers
SELECT categories.CategoryName, suppliers.Country
FROM categories
CROSS JOIN suppliers

-- Show all combinations of customers and products
SELECT customers.ContactName, products.ProductName
FROM customers
CROSS JOIN products