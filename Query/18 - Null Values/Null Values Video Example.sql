--UPDATE products
--SET Unit = NULL
--WHERE CategoryID = 6

SELECT * FROM products
WHERE Unit IS NULL

SELECT * FROM products
WHERE Unit IS NOT NULL
