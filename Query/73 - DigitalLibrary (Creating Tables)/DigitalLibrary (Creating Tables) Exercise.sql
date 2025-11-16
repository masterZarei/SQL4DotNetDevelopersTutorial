CREATE DATABASE DigitalLibraryDb

USE DigitalLibraryDb

CREATE TABLE Categories(
	Id INT PRIMARY KEY Identity,
	Title NVARCHAR(255) Not Null
)
Create TABLE Roles(
	Id INT PRIMARY KEY Identity,
	Title NVARCHAR(255) Not Null
)
CREATE TABLE Books(
	Id INT PRIMARY KEY Identity,
	Title NVARCHAR(255) Not Null,
	[Description] NVARCHAR(MAX),
	ImageUrl NVARCHAR(MAX),
	FileUrl NVARCHAR(MAX),
	Author NVARCHAR(255),
	CategoryId INT,
	IsDeleted bit NOT NULL DEFAULT 0,
	CONSTRAINT FK_Books_Categories FOREIGN KEY (CategoryId)
	REFERENCES Categories(Id)
)
CREATE TABLE Users(
	Id INT PRIMARY KEY Identity,
	FullName NVARCHAR(500) Not Null,
	PhoneNumber NVARCHAR(13) Not Null,
	RoleId INT,
	IsDeleted bit NOT NULL DEFAULT 0,
	CONSTRAINT FK_Users_Roles FOREIGN KEY (RoleId)
	REFERENCES Roles(Id),
	CONSTRAINT UQ_Users_PhoneNumber UNIQUE (PhoneNumber)
)
CREATE TABLE DownloadedBooks(
	Id INt PRIMARY KEY IDENTITY,
	BookId INT,
	UserId INT,
	CONSTRAINT FK_DownloadedBooks_Books FOREIGN KEY (BookId) REFERENCES Books(Id),
	CONSTRAINT FK_DownloadedBooks_Users FOREIGN KEY (UserId) REFERENCES Users(Id)
)