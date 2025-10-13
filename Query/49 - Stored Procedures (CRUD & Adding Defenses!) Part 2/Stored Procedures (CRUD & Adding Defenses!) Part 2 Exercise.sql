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

-- UPDATE
CREATE PROC UpdateCustomerCity
@NewCity varchar(255),
@CustomerId INT
AS
BEGIN
	BEGIN TRY
		IF EXISTS(SELECT 1 FROM customers WHERE CustomerID= @CustomerId)
			BEGIN
				UPDATE customers SET City=@NewCity
				WHERE CustomerID = @CustomerId
			END
		ELSE
			BEGIN
				PRINT 'Customer not found!'
			END

		PRINT 'Customer Updated Successfully!'
	END TRY

	BEGIN CATCH
		PRINT 'Error in Updating Customer'
	END CATCH
END

EXEC UpdateCustomerCity 'Mashhad',852

-- DELETE
CREATE PROC DeleteCustomerById
@CustomerId INT
AS
BEGIN
	IF EXISTS(SELECT 1 FROM ORDERS WHERE CustomerID= @CustomerId)
		BEGIN
			PRINT 'Cannot Delete this customer, there are existing orders.'
		END
	ELSE
		BEGIN
			DELETE FROM customers 
			WHERE CustomerID = @CustomerId
			PRINT 'Customer deleted Successfully!'
		END
END

EXEC DeleteCustomerById 94

--Get Customers who have no orders 
SELECT c.CustomerID
FROM customers c
WHERE NOT EXISTS(
	SELECT 1
	FROM orders o
	WHERE o.CustomerID = c.CustomerID
)