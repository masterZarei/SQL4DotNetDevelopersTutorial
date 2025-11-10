-- Create a table to store products with JSON-based details
CREATE TABLE ProductJson(
	ProductId INT PRIMARY KEY IDENTITY,
	ProductName NVARCHAR(100),
	ProductDetails NVARCHAR(MAX) -- Stores JSON data
);

-- Insert a single JSON object describing a laptop
INSERT INTO ProductJson (ProductName, ProductDetails)
VALUES ('Laptop', '{"Brand":"Dell","RAM":"16GB","Storage":"512GB SSD"}');

-- Insert a JSON array representing multiple PC-related items
INSERT INTO ProductJson (ProductName, ProductDetails)
VALUES ('PC',
'[
  {"Name": "Mouse", "Price": 25},
  {"Name": "Keyboard", "Price": 55},
  {"Name": "Monitor", "Price": 300}
]');

-- Extract values from JSON object fields (Brand, RAM, Storage)
SELECT 
	ProductJson.ProductName,
	JSON_VALUE(ProductDetails, '$.Brand') AS Brand,
	JSON_VALUE(ProductDetails, '$.RAM') AS RAM,
	JSON_VALUE(ProductDetails, '$.Storage') AS Storage
FROM ProductJson
WHERE ProductId = 2;

-- Parse JSON array from the ProductDetails field into rows and columns
SELECT * 
FROM OPENJSON(
	(SELECT ProductDetails 
	 FROM ProductJson 
	 WHERE ProductId = 2)
)
WITH (
	[Name] NVARCHAR(100),
	Price FLOAT
);
