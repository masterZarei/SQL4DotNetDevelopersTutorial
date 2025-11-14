-- 1️⃣ Create a master key
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'MyTDEMasterKey@2025';

-- 2️⃣ Create a certificate to protect database encryption key
CREATE CERTIFICATE MyTDECert WITH SUBJECT = 'TDE Certificate';

-- 3️⃣ Create a database encryption key and protect it with certificate
USE TopTest;
CREATE DATABASE ENCRYPTION KEY
WITH ALGORITHM = AES_256
ENCRYPTION BY SERVER CERTIFICATE MyTDECert;

-- 4️⃣ Enable encryption on the database
ALTER DATABASE TopTest SET ENCRYPTION ON;

-- 5️⃣ To verify
SELECT name, is_encrypted FROM sys.databases;
