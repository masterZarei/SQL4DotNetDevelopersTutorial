--Select all customers that starts with the letter "a":
--SELECT * FROM customers
--WHERE CustomerName LIKE 'a%'

--Return all customers from a city that starts with 'L'
--followed by one wildcard character, then 'nd' and then two wildcard characters:
--SELECT * FROM customers
--WHERE City LIKE 'L_nd__'

--Return all customers from a city that contains the letter 'L':
--SELECT * FROM customers
--WHERE City LIKE '%L%'

--Return all customers that starts with 'La':
--SELECT * FROM customers
--WHERE City LIKE 'La%'

--Return all customers that starts with 'a' or starts with 'b':
--SELECT * FROM customers
--WHERE CustomerName LIKE 'a%' OR CustomerName LIKE 'b%'

--Return all customers that ends with 'a':
--SELECT * FROM customers
--WHERE CustomerName LIKE '%a'

--Return all customers that starts with "b" and ends with "s":
--SELECT * FROM customers
--WHERE CustomerName LIKE 'b%s'

--Return all customers that contains the phrase 'or'
--SELECT * FROM customers
--WHERE CustomerName LIKE '%or%'

--Return all customers that starts with "a" and are at least 3 characters in length:
--SELECT * FROM customers
--WHERE CustomerName LIKE 'a__%'

--Return all customers that have "r" in the second position:
--SELECT * FROM customers
--WHERE CustomerName LIKE '_r%'

--Return all customers from Spain:
--SELECT * FROM customers
--WHERE Country LIKE 'Spain'
