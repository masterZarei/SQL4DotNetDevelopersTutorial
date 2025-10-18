-- 1️⃣ ساخت Stored Procedure برای نمایش تمام مشتریان یک شهر خاص
-- 🔹 آموزش: تمرین پایه‌ای برای دریافت داده‌ها با پارامتر ورودی.
CREATE PROC GetCustomerByCity
@City NVARCHAR(255)
AS
BEGIN
	SELECT * FROM customers
	WHERE CITY = @City
END

EXEC GetCustomerByCity 'Paris'


-- 2️⃣ ساخت Stored Procedure برای نمایش محصولاتی که قیمت آن‌ها از مقدار مشخصی بالاتر است
-- 🔹 آموزش: تمرین شرط‌گذاری عددی در SP با پارامتر ورودی.
CREATE PROC GetProductsAbovePrice
@MinPrice float
AS
BEGIN
	SELECT products.ProductName, products.Price
	FROM products
	WHERE PRICE > @MinPrice
END

EXEC GetProductsAbovePrice 15

-- 3️⃣ شمارش تعداد سفارش‌های یک مشتری خاص با استفاده از پارامتر خروجی (OUTPUT)
-- 🔹 آموزش: نحوه استفاده از پارامتر خروجی برای ارسال نتایج محاسباتی.
CREATE PROC GetOrderCountByCustomerId
@CustomerId INT,
@TotalOrders INT OUTPUT
AS
BEGIN
	SELECT @TotalOrders = COUNT(*) FROM orders
	WHERE CustomerID = @CustomerId
END

DECLARE @COUNT INT
EXEC GetOrderCountByCustomerId 5, @COUNT OUTPUT
PRINT @Count

-- 4️⃣ نمایش گران‌ترین محصول در یک دسته‌بندی خاص
-- 🔹 آموزش: استفاده از TOP و ORDER BY در SP برای انتخاب رکورد خاص.
CREATE PROC GetTopProductsByCategoryId
@CategoryId INT
AS
BEGIN
	SELECT TOP 1 ProductName, Price
	FROM products
	WHERE CategoryID = @CategoryId
	ORDER BY Price DESC
END

EXEC GetTopProductsByCategoryId 5

-- 5️⃣ محاسبه مجموع مبلغ فروش برای یک مشتری خاص با استفاده از OUTPUT
-- 🔹 آموزش: استفاده از پارامتر خروجی همراه با JOIN و توابع جمعی.
CREATE PROC GetCustomerTotalSales
@CustomerId INT,
@TotalSales float OUTPUT
AS
BEGIN
	SELECT @TotalSales = SUM(od.Quantity * p.Price) FROM ORDERS o
	INNER JOIN order_details od ON O.OrderID = od.OrderID
	INNER JOIN products p ON od.ProductID = p.ProductID
	where CustomerID = @CustomerId
END

DECLARE @TotalSales float
EXEC GetCustomerTotalSales 4, @TotalSales OUTPUT
PRINT @TotalSales
-- 6️⃣ درج مشتری جدید و برگرداندن شناسه مشتری جدید با استفاده از OUTPUT
-- 🔹 آموزش: درج داده جدید و برگرداندن ID آن (مفهوم SCOPE_IDENTITY).
CREATE PROC AddCustomer
@ContactName NVARCHAR(255),
@City NVARCHAR(255),
@CustomerId INT OUTPUT
AS
BEGIN
	INSERT INTO customers(ContactName,City)
	VALUES(@ContactName,@City)

	SELECT @CustomerId = SCOPE_IDENTITY();
END

DECLARE @ID INT
EXEC AddCustomer @ContactName='Hamid',@City='Ahvaaz',@CustomerId=@ID OUTPUT
PRINT @ID
-- 7️⃣ محاسبه میانگین قیمت محصولات بدون پارامتر ورودی
-- 🔹 آموزش: مثال ساده برای SP بدون پارامتر ورودی.
CREATE PROC GetProductsAverage
AS
BEGIN
	SELECT AVG(PRICE) AS AvergePrice FROM products
END

EXEC GetProductsAverage
-- 8️⃣ به‌روزرسانی شهر یک مشتری بر اساس شناسه (ID)
-- 🔹 آموزش: انجام عملیات UPDATE داخل SP.
CREATE PROC UpdateCustomerCityById
@CustomerId INT,
@City NVARCHAR(255)
AS
BEGIN
	UPDATE customers SET City=@City
	WHERE CustomerID= @CustomerId
END

EXEC UpdateCustomerCityById 102, 'Shiraz'

-- 9️⃣ حذف تمام سفارش‌های مربوط به یک مشتری خاص
-- 🔹 آموزش: تمرین عملیات DELETE در SP.
CREATE PROC DeleteCustomerOrdersById
@CustomerId INT
AS
BEGIN
	DELETE From orders
	Where CustomerID = @CustomerId
END

EXEC DeleteCustomerOrdersById 5

-- 🔟 نمایش تعداد محصولات در هر دسته‌بندی (گروه‌بندی داده‌ها)
-- 🔹 آموزش: ترکیب GROUP BY با SP برای ساخت گزارش‌های خلاصه‌ای.
CREATE PROC GetProductsCountPerCategory
AS
BEGIN
	SELECT CategoryId, COUNT(*) AS TotalProducts
	FROM products
	GROUP BY CategoryID
END

EXEC GetProductsCountPerCategory