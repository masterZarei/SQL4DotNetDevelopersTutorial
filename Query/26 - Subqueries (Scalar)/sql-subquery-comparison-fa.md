
# مقایسه انواع ساب‌کوئری‌ها در SQL Server

در این بخش، قصد داریم به بررسی انواع **ساب‌کوئری‌ها** (Subqueries) در SQL Server بپردازیم و تفاوت‌های آن‌ها را با مثال‌های عملی و کاربردی توضیح دهیم.

---

## ۱. ساب‌کوئری Scalar (مقداری)

ساب‌کوئری‌های Scalar تنها **یک مقدار منفرد** (یک سلول) را بازمی‌گردانند.

### مثال ۱: پیدا کردن میانگین قیمت محصولات

```sql
-- محصولات با قیمتی بیشتر از میانگین همه محصولات
SELECT *
FROM products
WHERE Price > (
    SELECT AVG(Price)
    FROM products
);
```

### مثال ۲: مقدار بیشترین قیمت در جدول products

```sql
SELECT MAX(Price) AS MaxPrice
FROM products;
```

---

## ۲. ساب‌کوئری Row (سطر)

ساب‌کوئری‌های Row یک **سطر کامل** با چند ستون را بازمی‌گردانند. در SQL Server امکان مقایسه مستقیم `(col1, col2) = (...)` وجود ندارد، اما با ترکیب شرط‌ها می‌توان این کار را انجام داد.

### مثال ۱: یافتن کارمندی که FirstName و LastName مشابه کارمند با EmployeeID=2 دارد

```sql
-- ابتدا نام و نام خانوادگی کارمند دوم را پیدا می‌کنیم
SELECT *
FROM employees
WHERE FirstName = (SELECT FirstName FROM employees WHERE EmployeeID = 2)
  AND LastName = (SELECT LastName FROM employees WHERE EmployeeID = 2)
  AND EmployeeID <> 2;
```

### مثال ۲: مقایسه چند ستون بدون استفاده از Tuple

```sql
-- مشتریانی که در همان کشور و شهر مشتری با ID=5 هستند (به جز خودش)
SELECT *
FROM customers
WHERE Country = (SELECT Country FROM customers WHERE CustomerID = 5)
  AND City = (SELECT City FROM customers WHERE CustomerID = 5)
  AND CustomerID <> 5;
```

---

## ۳. ساب‌کوئری Table (جدول)

ساب‌کوئری‌های Table یک **جدول کامل** را برمی‌گردانند و معمولاً در بخش `FROM` یا `IN` یا `EXISTS` استفاده می‌شوند.

### مثال ۱: استفاده در بخش FROM

```sql
-- میانگین قیمت محصولاتی که قیمتشان بالای 50 است
SELECT AVG(Price) AS AvgHighPrice
FROM (
    SELECT * FROM products WHERE Price > 50
) AS ExpensiveProducts;
```

### مثال ۲: استفاده در IN

```sql
-- سفارش‌هایی که متعلق به مشتریان آلمانی هستند
SELECT *
FROM orders
WHERE CustomerID IN (
    SELECT CustomerID
    FROM customers
    WHERE Country = 'Germany'
);
```

### مثال ۳: استفاده در EXISTS

```sql
-- مشتریانی که حداقل یک سفارش ثبت کرده‌اند
SELECT *
FROM customers c
WHERE EXISTS (
    SELECT 1 FROM orders o
    WHERE o.CustomerID = c.CustomerID
);
```

---

## جمع‌بندی تفاوت‌ها

| نوع ساب‌کوئری | مقدار بازگشتی        | محل استفاده رایج | مثال ساده                                  |
|---------------|------------------------|------------------|---------------------------------------------|
| Scalar        | یک مقدار (یک سلول)     | WHERE, SELECT    | WHERE Price > (SELECT AVG(Price) ...)       |
| Row           | یک سطر چند ستونی       | WHERE (مقایسه شرطی)| WHERE A = (...) AND B = (...)             |
| Table         | چند سطر/ستون (جدول کامل)| FROM, IN, EXISTS | FROM (SELECT ...) AS T                     |

---

✅ حالا می‌توانید بسته به نیاز، از ساب‌کوئری مناسب در جای مناسب استفاده کنید.
