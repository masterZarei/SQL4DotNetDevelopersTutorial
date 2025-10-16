-- 1️⃣ ساخت Stored Procedure برای نمایش تمام مشتریان یک شهر خاص
CREATE PROCEDURE GetCustomersByCity @City NVARCHAR(50)
AS
BEGIN
    SELECT * FROM Customers WHERE City = @City;
END;

-- اجرای نمونه:
EXEC GetCustomersByCity @City = 'London';
-- 🔹 آموزش: تمرین پایه‌ای برای دریافت داده‌ها با پارامتر ورودی.


-- 2️⃣ ساخت Stored Procedure برای نمایش محصولاتی که قیمت آن‌ها از مقدار مشخصی بالاتر است
CREATE PROCEDURE GetProductsAbovePrice @MinPrice DECIMAL(10,2)
AS
BEGIN
    SELECT ProductName, Price
    FROM Products
    WHERE Price > @MinPrice;
END;

-- اجرای نمونه:
EXEC GetProductsAbovePrice @MinPrice = 50.00;
-- 🔹 آموزش: تمرین شرط‌گذاری عددی در SP با پارامتر ورودی.


-- 3️⃣ شمارش تعداد سفارش‌های یک مشتری خاص با استفاده از پارامتر خروجی (OUTPUT)
CREATE PROCEDURE GetOrderCountByCustomer
    @CustomerID INT,
    @TotalOrders INT OUTPUT
AS
BEGIN
    SELECT @TotalOrders = COUNT(*) FROM Orders WHERE CustomerID = @CustomerID;
END;

-- اجرای نمونه:
DECLARE @Count INT;
EXEC GetOrderCountByCustomer @CustomerID = 2, @TotalOrders = @Count OUTPUT;
PRINT 'Total Orders: ' + CAST(@Count AS NVARCHAR(10));
-- 🔹 آموزش: نحوه استفاده از پارامتر خروجی برای ارسال نتایج محاسباتی.


-- 4️⃣ نمایش گران‌ترین محصول در یک دسته‌بندی خاص
CREATE PROCEDURE GetTopProductByCategory @CategoryID INT
AS
BEGIN
    SELECT TOP 1 ProductName, Price
    FROM Products
    WHERE CategoryID = @CategoryID
    ORDER BY Price DESC;
END;

-- اجرای نمونه:
EXEC GetTopProductByCategory @CategoryID = 1;
-- 🔹 آموزش: استفاده از TOP و ORDER BY در SP برای انتخاب رکورد خاص.


-- 5️⃣ محاسبه مجموع مبلغ فروش برای یک مشتری خاص با استفاده از OUTPUT
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

-- اجرای نمونه:
DECLARE @Sales DECIMAL(18,2);
EXEC GetCustomerTotalSales @CustomerID = 1, @TotalAmount = @Sales OUTPUT;
PRINT 'Total Sales Amount: ' + CAST(@Sales AS NVARCHAR(20));
-- 🔹 آموزش: استفاده از پارامتر خروجی همراه با JOIN و توابع جمعی.


-- 6️⃣ درج مشتری جدید و برگرداندن شناسه مشتری جدید با استفاده از OUTPUT
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

-- اجرای نمونه:
DECLARE @ID INT;
EXEC AddCustomer @CustomerName = 'David Smith', @City = 'Berlin', @NewCustomerID = @ID OUTPUT;
PRINT 'New Customer ID: ' + CAST(@ID AS NVARCHAR(10));
-- 🔹 آموزش: درج داده جدید و برگرداندن ID آن (مفهوم SCOPE_IDENTITY).


-- 7️⃣ محاسبه میانگین قیمت محصولات بدون پارامتر ورودی
CREATE PROCEDURE GetAverageProductPrice
AS
BEGIN
    SELECT AVG(Price) AS AveragePrice FROM Products;
END;

-- اجرای نمونه:
EXEC GetAverageProductPrice;
-- 🔹 آموزش: مثال ساده برای SP بدون پارامتر ورودی.


-- 8️⃣ به‌روزرسانی شهر یک مشتری بر اساس شناسه (ID)
CREATE PROCEDURE UpdateCustomerCity @CustomerID INT, @NewCity NVARCHAR(50)
AS
BEGIN
    UPDATE Customers SET City = @NewCity WHERE CustomerID = @CustomerID;
END;

-- اجرای نمونه:
EXEC UpdateCustomerCity @CustomerID = 3, @NewCity = 'Madrid';
-- 🔹 آموزش: انجام عملیات UPDATE داخل SP.


-- 9️⃣ حذف تمام سفارش‌های مربوط به یک مشتری خاص
CREATE PROCEDURE DeleteOrdersByCustomer @CustomerID INT
AS
BEGIN
    DELETE FROM Orders WHERE CustomerID = @CustomerID;
END;

-- اجرای نمونه:
EXEC DeleteOrdersByCustomer @CustomerID = 5;
-- 🔹 آموزش: تمرین عملیات DELETE در SP.


-- 🔟 نمایش تعداد محصولات در هر دسته‌بندی (گروه‌بندی داده‌ها)
CREATE PROCEDURE GetProductCountPerCategory
AS
BEGIN
    SELECT CategoryID, COUNT(*) AS TotalProducts
    FROM Products
    GROUP BY CategoryID;
END;

-- اجرای نمونه:
EXEC GetProductCountPerCategory;
-- 🔹 آموزش: ترکیب GROUP BY با SP برای ساخت گزارش‌های خلاصه‌ای.
