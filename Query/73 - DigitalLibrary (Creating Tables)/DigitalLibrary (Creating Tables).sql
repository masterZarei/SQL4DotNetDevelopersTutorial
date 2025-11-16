CREATE DATABASE DigitalLibraryDb

USE DigitalLibraryDb

CREATE TABLE Category(
	Id INT PRIMARY KEY Identity,
	Title NVARCHAR(255)
)
Create TABLE [Role](
	Id INT PRIMARY KEY Identity,
	Title NVARCHAR(255)
)
CREATE TABLE Book(
	Id INT PRIMARY KEY Identity,
	Title NVARCHAR(255),
	[Description] NVARCHAR(MAX),
	ImageUrl NVARCHAR(MAX),
	FileUrl NVARCHAR(MAX),
	Author NVARCHAR(255),
	CategoryId INT,
	IsDeleted bit,
	CONSTRAINT FK_Book_Category FOREIGN KEY (CategoryId)
	REFERENCES Category(Id)
)
CREATE TABLE [User](
	Id INT PRIMARY KEY Identity,
	FullName NVARCHAR(500),
	PhoneNumber NVARCHAR(13),
	RoleId INT,
	IsDeleted bit,
	CONSTRAINT FK_User_Role FOREIGN KEY (RoleId)
	REFERENCES [Role](Id)
)
CREATE TABLE DownloadedBooks(
	Id INt PRIMARY KEY IDENTITY,
	BookId INT,
	UserId INT,
	CONSTRAINT FK_DownloadedBooks_Book FOREIGN KEY (BookId) REFERENCES Book(Id),
	CONSTRAINT FK_DownloadedBooks_User FOREIGN KEY (UserId) REFERENCES [User](Id)
)