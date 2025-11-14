-------------------------------------------------------
-- STEP 1: Create master key (root for all encryption)
-------------------------------------------------------
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'MyStrongPassword@2025';


-------------------------------------------------------
-- STEP 2: Create certificate to protect symmetric key
-------------------------------------------------------
CREATE CERTIFICATE CustomerDataCert
WITH SUBJECT = 'Encrypt customer personal info';


-------------------------------------------------------
-- STEP 3: Create symmetric key with AES_256 algorithm
-------------------------------------------------------
CREATE SYMMETRIC KEY CustomerSymKey
WITH ALGORITHM = AES_256
ENCRYPTION BY CERTIFICATE CustomerDataCert;


-------------------------------------------------------
-- STEP 4: Add a column to store encrypted data
-------------------------------------------------------
ALTER TABLE Customers
ADD EncryptedAddress VARBINARY(MAX);


-------------------------------------------------------
-- STEP 5: Encrypt existing Address data into new column
-------------------------------------------------------
OPEN SYMMETRIC KEY CustomerSymKey DECRYPTION BY CERTIFICATE CustomerDataCert;

UPDATE Customers
SET EncryptedAddress = ENCRYPTBYKEY(KEY_GUID('CustomerSymKey'), Address);

CLOSE SYMMETRIC KEY CustomerSymKey;


-------------------------------------------------------
-- STEP 6: (Optional but recommended) Remove plain column
-------------------------------------------------------
ALTER TABLE Customers DROP COLUMN Address;


-------------------------------------------------------
-- STEP 7: Decrypt data when reading
-------------------------------------------------------
OPEN SYMMETRIC KEY CustomerSymKey DECRYPTION BY CERTIFICATE CustomerDataCert;

SELECT 
    CustomerID,
    CONVERT(NVARCHAR(100), DECRYPTBYKEY(EncryptedAddress)) AS DecryptedAddress
FROM Customers;

CLOSE SYMMETRIC KEY CustomerSymKey;
