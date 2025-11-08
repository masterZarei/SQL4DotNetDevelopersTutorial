-- CREATE DATABASE TopTest
-- (Commented out: used to create a new database named "TopTest")

-- Create a table named MarketingTeam
CREATE TABLE MarketingTeam(
	Id INT PRIMARY KEY IDENTITY(1,1),    -- Unique ID for each team member, auto-incremented
	FirstName NVARCHAR(255),             -- Member's first name
	LastName NVARCHAR(255),              -- Member's last name
	City NVARCHAR(50),                   -- Member's city
	RoleId INT                           -- Foreign key reference to a role (will link to MarketingTeamRoles)
)

-- Create a table named MarketingTeamRoles
CREATE TABLE MarketingTeamRoles(
	Id INT PRIMARY KEY IDENTITY(1,1),    -- Unique ID for each role, auto-incremented
	RoleName NVARCHAR(255)               -- Name or title of the marketing role
)

-- Add a new column named Email to the MarketingTeam table
ALTER TABLE MarketingTeam
ADD Email NVARCHAR(255)

-- Remove the Email column from the MarketingTeam table
ALTER TABLE MarketingTeam
DROP COLUMN Email

-- Modify the Email column's data type and size to NVARCHAR(300)
-- (This assumes the column exists before executing)
ALTER TABLE MarketingTeam
ALTER COLUMN Email NVARCHAR(300)

-- Rename the column 'Email' to 'PhoneNumber' in the MarketingTeam table
EXEC sp_rename 'MarketingTeam.Email', 'PhoneNumber', 'COLUMN'

-- Delete the entire MarketingTeamRoles table and all its data
DROP TABLE MarketingTeamRoles
