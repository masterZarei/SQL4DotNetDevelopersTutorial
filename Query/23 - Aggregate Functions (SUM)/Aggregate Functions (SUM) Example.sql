-- Calculates the total quantity of all order details across all products
SELECT SUM(Quantity)
FROM Order_details;

-- Calculates the total quantity sold of the product with ProductID = 11
SELECT SUM(Quantity)
FROM Order_details
WHERE ProductId = 11;

-- Calculates the total value (Quantity × 10) of orders for ProductID = 10
SELECT SUM(Quantity * 10)
FROM Order_details
WHERE ProductId = 10;