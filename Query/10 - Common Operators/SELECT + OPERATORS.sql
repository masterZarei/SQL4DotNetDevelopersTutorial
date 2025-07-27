--SELECT * FROM products
--WHERE ProductName='Chang' AND Price < 20
--WHERE ProductName='Chang' OR Price > 20
--WHERE Price > 10 AND Price < 20
--WHERE Price BETWEEN 10 AND 20
--WHERE NOT Price BETWEEN 10 AND 20

SELECT * FROM customers
WHERE City IN ('Berlin','Madrid','London')