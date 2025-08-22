-- UNION: Combine cities from Customers and Suppliers, removing duplicates
SELECT CITY FROM customers
UNION
SELECT CITY FROM suppliers
ORDER BY City;

-- UNION ALL: Combine cities from Customers and Suppliers, keeping duplicates
SELECT CITY FROM customers
UNION ALL
SELECT CITY FROM suppliers
ORDER BY City;

-- INTERSECT: Return only the cities that exist in both Customers and Suppliers
SELECT CITY FROM customers
INTERSECT
SELECT CITY FROM suppliers;

-- EXCEPT: Return customers who never placed an order
SELECT customers.CustomerID FROM customers
EXCEPT
SELECT orders.CustomerID FROM orders;
