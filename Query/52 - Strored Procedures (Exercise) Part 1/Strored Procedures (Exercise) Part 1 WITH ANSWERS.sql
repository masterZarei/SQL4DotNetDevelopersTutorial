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