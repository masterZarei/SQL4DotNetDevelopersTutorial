CREATE TABLE Categories(
	CategoryId INT PRIMARY KEY IDENTITY,
	CategoryName NVARCHAR(255) NOT NULL
)
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY IDENTITY,
    FirstName NVARCHAR(255) NOT NULL,
    LastName NVARCHAR(255) NOT NULL,
    BirthDate DATE NOT NULL
);
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY,
    CustomerName NVARCHAR(100),
    Email NVARCHAR(100),
    Country NVARCHAR(50)
);
CREATE TABLE Products(
	ProductId INT PRIMARY KEY IDENTITY,
	ProductName NVARCHAR(255) NOT NULL,
	Price float,
	CategoryId INT,
	CONSTRAINT FK_Products_Categories 
		FOREIGN KEY (CategoryId) REFERENCES Categories(CategoryId)
)
ALTER TABLE Customers
ADD CONSTRAINT UQ_Customers_Email UNIQUE (Email);

ALTER TABLE Customers
ADD CONSTRAINT DF_Customers_Country DEFAULT 'تعریف نشده' FOR Country;

ALTER TABLE Products
ADD CONSTRAINT CHK_Products_Price CHECK (Price > 0)

ALTER TABLE Employees
ADD CONSTRAINT CHK_Employees_BirthDate CHECK (BirthDate < GETDATE())