--TRUE if all of the subquery values meet the condition	
SELECT ProductName 
FROM Products
WHERE ProductID = ALL
(SELECT ProductID FROM order_details WHERE Quantity = 10);

SELECT SupplierName
FROM Suppliers
WHERE EXISTS 
(SELECT ProductName FROM Products 
WHERE Products.SupplierID = Suppliers.supplierID AND Price < 20);

SELECT ProductName
FROM Products
WHERE ProductID = ANY
  (SELECT ProductID
  FROM order_details
  WHERE Quantity = 10);

  SELECT ProductName
FROM Products
WHERE ProductID = ANY
  (SELECT ProductID
  FROM order_details
  WHERE Quantity > 1000);