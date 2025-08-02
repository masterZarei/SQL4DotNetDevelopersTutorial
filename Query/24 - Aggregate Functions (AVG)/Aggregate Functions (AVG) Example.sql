-- Calculates the average price of all products
SELECT AVG(Price) FROM products;

-- Calculates the average price of products for each category
SELECT AVG(PRICE), CATEGORYID
FROM products
GROUP BY CategoryID;

-- Retrieves all products that are priced above the average price of all products
SELECT * FROM PRODUCTS
WHERE Price > (SELECT AVG(Price) FROM products);
