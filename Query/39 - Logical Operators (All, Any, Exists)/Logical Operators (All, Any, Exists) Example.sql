-- Find products that are cheaper than ANY product supplied by supplier 1
SELECT ProductName, Price
FROM Products
WHERE Price < ANY (SELECT Price FROM Products WHERE SupplierID = 1);
--اگر یه محصول از حداقل یکی از محصولات تأمین‌کننده 1 ارزون‌تر باشه → انتخاب میشه.

-- Find products that are cheaper than ALL products supplied by supplier 1
SELECT ProductName, Price
FROM Products
WHERE Price < ALL (SELECT Price FROM Products WHERE SupplierID = 1);
-- فقط محصولاتی انتخاب میشن که از همه‌ی محصولات تأمین‌کننده 1 ارزون‌تر باشن → یعنی ارزون‌ترین ارزون‌ها!

-- Find customers who have placed at least one order
SELECT CustomerName
FROM Customers
WHERE EXISTS (SELECT * FROM Orders WHERE Orders.CustomerID = Customers.CustomerID);
