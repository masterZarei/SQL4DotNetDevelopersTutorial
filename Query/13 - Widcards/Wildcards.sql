-- %	Represents zero or more characters
SELECT * FROM customers
WHERE CustomerName LIKE 'a%'

-- _	Represents a single character
SELECT * FROM customers
WHERE City LIKE '_ondon'

-- []	Represents any single character within the brackets *
SELECT * FROM Customers
WHERE CustomerName LIKE '[bsp]%'

-- -	Represents any single character within the specified range *
SELECT * FROM Customers
WHERE CustomerName LIKE '%[a-e]'

-- ^	Represents any character not in the brackets *
SELECT * FROM Customers
WHERE Country LIKE '[^U]%';
