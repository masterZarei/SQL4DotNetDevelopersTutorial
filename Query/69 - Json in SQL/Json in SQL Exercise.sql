-- Create a table with a JSON column
CREATE TABLE ProductsJson (
    ProductID INT IDENTITY PRIMARY KEY,
    ProductName NVARCHAR(100),
    ProductDetails NVARCHAR(MAX) -- Store JSON data here
);

-- Insert a JSON object
INSERT INTO ProductsJson (ProductName, ProductDetails)
VALUES ('Laptop', '{"Brand":"Dell","RAM":"16GB","Storage":"512GB SSD"}');

-- Extract a specific value from JSON text
SELECT 
    ProductName,
    JSON_VALUE(ProductDetails, '$.Brand') AS Brand,
    JSON_VALUE(ProductDetails, '$.RAM') AS RAM
FROM ProductsJson;

-- Example JSON array
DECLARE @json NVARCHAR(MAX) = '
[
  {"Name": "Mouse", "Price": 25},
  {"Name": "Keyboard", "Price": 55},
  {"Name": "Monitor", "Price": 300}
]';

-- Parse JSON array into rows
SELECT * 
FROM OPENJSON(@json)
WITH (
    Name NVARCHAR(50),
    Price DECIMAL(10,2)
);


-- Convert table data to JSON
SELECT ProductID, ProductName
FROM ProductsJson
FOR JSON AUTO;



-- Insert JSON data and query nested fields
INSERT INTO ProductsJson (ProductName, ProductDetails)
VALUES 
('Phone', '{"Brand":"Samsung","Specs":{"RAM":"8GB","Battery":"4000mAh"}}');

-- Query nested JSON properties
SELECT 
    ProductName,
    JSON_VALUE(ProductDetails, '$.Specs.RAM') AS RAM,
    JSON_VALUE(ProductDetails, '$.Specs.Battery') AS Battery
FROM ProductsJson;



-- Find products where RAM = 16GB
SELECT *
FROM ProductsJson
WHERE JSON_VALUE(ProductDetails, '$.RAM') = '16GB';

