--List all customers who live in the same city as the customer ContactName is 'Thomas Hardy'.
SELECT * FROM customers
WHERE City = (
    SELECT City FROM customers WHERE ContactName = 'Thomas Hardy'
)
AND ContactName <> 'Thomas Hardy';

--Find customers who are from a country where at least one supplier also lives.
SELECT * FROM customers
WHERE Country IN (
    SELECT DISTINCT Country FROM suppliers
    WHERE Country IS NOT NULL
);

--List all products that have been sold in at least one order with quantity >= 10.
SELECT * FROM products
WHERE ProductID IN (
    SELECT ProductID FROM order_details
    WHERE Quantity >= 10
);

--Display customers who ordered the product named 'Chang'.
SELECT * FROM customers
WHERE CustomerID IN (
    SELECT CustomerID FROM orders
    WHERE OrderID IN (
        SELECT OrderID FROM order_details
        WHERE ProductID = (
            SELECT ProductID FROM products WHERE ProductName = 'Chang'
        )
    )
);
