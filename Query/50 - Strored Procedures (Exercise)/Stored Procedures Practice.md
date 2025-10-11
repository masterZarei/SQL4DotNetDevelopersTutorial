# 🎯 تمرین‌های Stored Procedure در SQL Server
### موضوعات: معرفی، پارامترهای ورودی، پارامترهای خروجی

---

```sql
-- 1️⃣ یک Stored Procedure بنویس که همه مشتریان یک شهر خاص را برگرداند.
CREATE PROCEDURE GetCustomersByCity @City NVARCHAR(50)
AS
BEGIN
    SELECT * FROM Customers WHERE City = @City;
END;

-- نحوه اجرا:
EXEC GetCustomersByCity @City = 'London';
```
📘 *آموزش فیلتر کردن داده‌ها با پارامتر ورودی.*

---

```sql
-- 2️⃣ یک Stored Procedure بنویس که محصولات گران‌تر از یک قیمت مشخص را برگرداند.
CREATE PROCEDURE GetProductsAbovePrice @MinPrice DECIMAL(10,2)
AS
BEGIN
    SELECT ProductName, Price
    FROM Products
    WHERE Price > @MinPrice;
END;

-- نحوه اجرا:
EXEC GetProductsAbovePrice @MinPrice = 50.00;
```
📘 *آموزش استفاده از پارامتر عددی در شرط WHERE.*

---

```sql
-- 3️⃣ یک Stored Procedure بنویس که تعداد سفارش‌های یک مشتری خاص را حساب کند (با استفاده از OUTPUT).
CREATE PROCEDURE GetOrderCountByCustomer
    @CustomerID INT,
    @TotalOrders INT OUTPUT
AS
BEGIN
    SELECT @TotalOrders = COUNT(*) FROM Orders WHERE CustomerID = @CustomerID;
END;

-- نحوه اجرا:
DECLARE @Count INT;
EXEC GetOrderCountByCustomer @CustomerID = 2, @TotalOrders = @Count OUTPUT;
PRINT 'Total Orders: ' + CAST(@Count AS NVARCHAR(10));
```
📘 *آموزش مفهوم پارامتر خروجی و نحوه چاپ نتیجه.*

---

```sql
-- 4️⃣ یک Stored Procedure بنویس که گران‌ترین محصول در یک دسته‌بندی خاص را برگرداند.
CREATE PROCEDURE GetTopProductByCategory @CategoryID INT
AS
BEGIN
    SELECT TOP 1 ProductName, Price
    FROM Products
    WHERE CategoryID = @CategoryID
    ORDER BY Price DESC;
END;

-- نحوه اجرا:
EXEC GetTopProductByCategory @CategoryID = 1;
```
📘 *آموزش استفاده از ORDER BY و TOP در SP ها.*

---

```sql
-- 5️⃣ یک Stored Procedure بنویس که مجموع مبلغ فروش یک مشتری را محاسبه کند (با استفاده از OUTPUT).
CREATE PROCEDURE GetCustomerTotalSales
    @CustomerID INT,
    @TotalAmount DECIMAL(18,2) OUTPUT
AS
BEGIN
    SELECT @TotalAmount = SUM(od.Quantity * p.Price)
    FROM Orders o
    JOIN Order_Details od ON o.OrderID = od.OrderID
    JOIN Products p ON od.ProductID = p.ProductID
    WHERE o.CustomerID = @CustomerID;
END;

-- نحوه اجرا:
DECLARE @Sales DECIMAL(18,2);
EXEC GetCustomerTotalSales @CustomerID = 1, @TotalAmount = @Sales OUTPUT;
PRINT 'Total Sales Amount: ' + CAST(@Sales AS NVARCHAR(20));
```
📘 *آموزش کاربرد پارامتر خروجی در سناریوهای واقعی و با Join.*

---

```sql
-- 6️⃣ یک Stored Procedure بنویس که مشتری جدید اضافه کند و شناسه‌ی او را برگرداند.
CREATE PROCEDURE AddCustomer
    @CustomerName NVARCHAR(50),
    @City NVARCHAR(50),
    @NewCustomerID INT OUTPUT
AS
BEGIN
    INSERT INTO Customers (CustomerName, City)
    VALUES (@CustomerName, @City);

    SELECT @NewCustomerID = SCOPE_IDENTITY();
END;

-- نحوه اجرا:
DECLARE @ID INT;
EXEC AddCustomer @CustomerName = 'David Smith', @City = 'Berlin', @NewCustomerID = @ID OUTPUT;
PRINT 'New Customer ID: ' + CAST(@ID AS NVARCHAR(10));
```
📘 *آموزش درج داده و گرفتن ID با SCOPE_IDENTITY().*

---

```sql
-- 7️⃣ یک Stored Procedure بنویس که میانگین قیمت محصولات را محاسبه کند (بدون پارامتر).
CREATE PROCEDURE GetAverageProductPrice
AS
BEGIN
    SELECT AVG(Price) AS AveragePrice FROM Products;
END;

-- نحوه اجرا:
EXEC GetAverageProductPrice;
```
📘 *نمونه ساده برای مرور مفاهیم قبلی بدون پارامتر.*

---

```sql
-- 8️⃣ یک Stored Procedure بنویس که شهر مشتری را بر اساس ID به‌روزرسانی کند.
CREATE PROCEDURE UpdateCustomerCity @CustomerID INT, @NewCity NVARCHAR(50)
AS
BEGIN
    UPDATE Customers SET City = @NewCity WHERE CustomerID = @CustomerID;
END;

-- نحوه اجرا:
EXEC UpdateCustomerCity @CustomerID = 3, @NewCity = 'Madrid';
```
📘 *آموزش عملیات UPDATE در داخل SP.*

---

```sql
-- 9️⃣ یک Stored Procedure بنویس که تمام سفارش‌های یک مشتری خاص را حذف کند.
CREATE PROCEDURE DeleteOrdersByCustomer @CustomerID INT
AS
BEGIN
    DELETE FROM Orders WHERE CustomerID = @CustomerID;
END;

-- نحوه اجرا:
EXEC DeleteOrdersByCustomer @CustomerID = 5;
```
📘 *آموزش عملیات DELETE در SP ها.*

---

```sql
-- 🔟 یک Stored Procedure بنویس که تعداد محصولات هر دسته‌بندی را برگرداند.
CREATE PROCEDURE GetProductCountPerCategory
AS
BEGIN
    SELECT CategoryID, COUNT(*) AS TotalProducts
    FROM Products
    GROUP BY CategoryID;
END;

-- نحوه اجرا:
EXEC GetProductCountPerCategory;
```
📘 *آموزش استفاده از GROUP BY در SP ها.*

---

✅ **خلاصه:**
این تمرین‌ها به دانشجویان کمک می‌کنند تا:
- نحوه ساخت Stored Procedure با و بدون پارامتر را تمرین کنند.
- مفهوم پارامتر خروجی (OUTPUT) را درک کنند.
- عملیات CRUD را در داخل SP پیاده‌سازی کنند.
- SQL تمیز و قابل استفاده مجدد بنویسند.
