-- برای ایجاد جدول تیم فروش این اسکریپت را اجرا کنید
USE [TopShopDb]
GO
CREATE TABLE [dbo].[SalesTeam](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[BirthDate] [nvarchar](50) NULL,
	[NationalCode] [nvarchar](10) NULL,
)