-- CREATE
CREATE PROC AddCustomer
@CustomerName varchar(255),
@ContactName varchar(255),
@City varchar(255),
@Country varchar(255)
AS
BEGIN
	BEGIN TRY
		INSERT INTO customers (CustomerName, ContactName, City, Country)
		VALUES (@CustomerName, @ContactName, @City, @Country)

		PRINT 'Customer Added Successfully!';
	END TRY
	BEGIN CATCH
		PRINT 'Error inserting customer!'
	END CATCH
END

EXEC AddCustomer 'Microsoft', 'Bill Gates', 'Redmind', 'US'

-- READ
CREATE PROC GetCustomerByCountry
@Country varchar(255)
AS
BEGIN
	SELECT ContactName, City, [Address], Country
	FROM customers
	WHERE Country = @Country
END

Exec GetCustomerByCountry 'USA'
