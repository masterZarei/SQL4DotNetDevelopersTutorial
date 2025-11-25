# 📘 SQL for .NET Developers — Practical Tutorial
دوره جامع آموزش SQL Server برای توسعه دهندگان ASP.NET Core + پروژه عملی

**A complete hands-on SQL Server course + Digital Library project**

## برای  [مشاهده دوره](https://toplearn.com/c/6275) کلیک کنید
### برای ذخیره دوره در بخش Stars گیت هاب خود روی Star ⭐این ریپو کلیک کنید
این ریپازیتوری شامل تمامی فایل‌های تمرینی، اسکریپت‌ها، Stored Procedures، و پروژه‌ی کامل **Digital Library** است؛ پروژه‌ای که توسعه‌دهندگان ASP.NET Core را وارد سطح بالاتری از مهارت دیتابیس می‌کند.

---

## 🚀 درباره این دوره

این دوره برای توسعه‌دهندگانی ساخته شده که همیشه تمام بار دیتابیس را روی دوش EF Core انداخته‌اند و حالا می‌خواهند SQL Server را **واقعی و حرفه‌ای** یاد بگیرند.

در این ریپازیتوری شما:

* ساخت دیتابیس از صفر تا صد
* نوشتن کوئری‌های حرفه‌ای
* کار با SP، Function، Trigger، View
* آموزش Index، امنیت، JSON، Encryption
* و در نهایت *پیاده‌سازی یک پروژه واقعی* با ADO.NET + Stored Procedure

را یک‌جا در اختیار دارید.

---

## 📂 ساختار ریپازیتوری

```
SQL4DotNetDevelopersTutorial/
│
├── DigitalLibrary/
│   ├── DigitalLibrary/           # پروژه ASP.NET Core Razor Pages
│   │   ├── Data/                 # SqlDataContext + Repositories + SP Calls
│   │   ├── Models/               # DTOs و مدل‌ها
│   │   ├── Pages/                # صفحات Razor (Admin, Account, Books...)
│   │   ├── wwwroot/              # استایل‌ها و فایل‌های استاتیک
│   │   ├── Program.cs            # کانفیگ پروژه + Authentication/Authorization
│   │   └── appsettings.json
│   │
│   └── Exercises/                # فایل‌های تمرینی دوره + مثال‌ها
│
└── README.md                     # مستندات (همین فایل)
```

---

## 🧩 پروژه DigitalLibrary شامل چه چیزهایی می‌شود؟

### ✔ طراحی دیتابیس

* Tables: Categories, Roles, Users, Books, DownloadedBooks
* روابط و کلیدهای اصلی و خارجی
* استفاده از ADO.Net 
* ایجاد ابزارهای تعامل با دیتابیس از صفر

### ✔ Stored Procedures کامل

* مدیریت کاربران، نقش‌ها، کتاب‌ها، دانلودها
* لاگین امن با SP
* CRUD کامل با بهترین الگوها
* جلوگیری از SQL Injection به‌کمک پارامترها

### ✔ لایه دسترسی به داده‌ها (ADO.NET)

* SqlDataContext عمومی
* Repository Pattern
* Map کردن Reader به DTO
* خواندن و نوشتن فقط از طریق SPها

### ✔ Razor Pages + Authentication

* Login با Claims
* Authorization Policy برای Admin و User
* صفحات Admin:

  * مدیریت دسته‌بندی
  * مدیریت کتاب‌ها
  * مدیریت کاربران
* صفحه BookDetails
* صفحه MyLibrary

---

## 🏋️‍♂️ برای چه کسانی مناسب است؟

این دوره مخصوص توسعه‌دهندگان:

* ASP.NET Core
* EF Core Developers که می‌خواهند بالاخره SQL واقعی را یاد بگیرند
* کسانی که می‌خواهند برای مصاحبه‌های برنامه‌نویسی حرفه‌ای‌تر شوند
* کسانی که می‌خواهند معماری درست دیتابیس و Query Optimization را بفهمند

---

## 🛠 پیش‌نیازها

* آشنایی اولیه با #C
* آشنایی سطح مقدماتی با ASP.NET Core
* نصب SQL Server و SSMS
* .NET 8 SDK

---

## ▶️ نحوه اجرا

1. دیتابیس **DigitalLibraryDb** را بسازید
2. اسکریپت‌های ساخت جدول و SPها را اجرا کنید
3. فایل `appsettings.json` را با ConnectionString خود تنظیم کنید
4. پروژه DigitalLibrary را اجرا کنید

```bash
cd DigitalLibrary/DigitalLibrary
dotnet run
```
---

## ⭐️ حمایت از پروژه

اگر این دوره برای شما ارزشمند بود:

✔ ریپازیتوری را Star ⭐ کنید

✔ آن را با دوستان توسعه‌دهنده‌تان به اشتراک بگذارید

---
