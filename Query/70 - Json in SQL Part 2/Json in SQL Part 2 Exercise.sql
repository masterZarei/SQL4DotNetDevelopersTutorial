-- Convert all rows from the Products table into a JSON array
SELECT * 
FROM Products
FOR JSON AUTO;

-- Insert a product with nested JSON structure for specifications
INSERT INTO ProductJson
VALUES('Phone', '{"Brand":"Samsung","Specs":{"RAM":"8GB","Battery":"4000mAh"}}');

-- Extract nested JSON values (RAM and Battery) from the Specs object
SELECT 
	ProductName,
	JSON_VALUE(ProductDetails, '$.Specs.RAM') AS RAM,
	JSON_VALUE(ProductDetails, '$.Specs.Battery') AS Battery
FROM ProductJson;

-- Retrieve all products where RAM = 16GB from JSON data
SELECT * 
FROM ProductJson
WHERE JSON_VALUE(ProductDetails, '$.RAM') = '16GB';
