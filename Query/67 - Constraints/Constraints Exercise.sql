-- Create the Categories table with a Primary Key and NOT NULL constraint
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),   -- Auto-incremented unique ID
    CategoryName NVARCHAR(100) NOT NULL         -- Category name cannot be NULL
);

-- Explicitly add a named Primary Key constraint to the Categories table
ALTER TABLE Categories
ADD CONSTRAINT PK_Categories PRIMARY KEY (CategoryID);


-- Create the Employees table with NOT NULL constraints on required columns
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY IDENTITY,        -- Unique auto-incremented employee ID
    FirstName NVARCHAR(50) NOT NULL,            -- First name is mandatory
    LastName NVARCHAR(50) NOT NULL              -- Last name is mandatory
);


-- Create the Products table and establish a Foreign Key relationship to Categories
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),    -- Unique auto-incremented product ID
    ProductName NVARCHAR(100),                  -- Product name (nullable)
    CategoryID INT,                             -- Category reference
    CONSTRAINT FK_Products_Categories           -- Foreign key constraint name
        FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID) -- Enforces relationship
);

-- Add a Foreign Key with ON DELETE CASCADE option to delete related products automatically
ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories_Cascade
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
ON DELETE CASCADE;


-- Add a UNIQUE constraint to ensure each customer has a unique email address
ALTER TABLE Customers
ADD CONSTRAINT UQ_Customers_Email UNIQUE (Email);


-- Add a DEFAULT constraint to set 'Unknown' as the default country value
ALTER TABLE Customers
ADD CONSTRAINT DF_Customers_Country DEFAULT 'Unknown' FOR Country;


-- Add a CHECK constraint to ensure all product prices are greater than zero
ALTER TABLE Products
ADD CONSTRAINT CHK_Products_Price CHECK (Price > 0);

-- Add a CHECK constraint to ensure employee birth dates are not in the future
ALTER TABLE Employees
ADD CONSTRAINT CHK_Employees_Age CHECK (BirthDate <= GETDATE());
