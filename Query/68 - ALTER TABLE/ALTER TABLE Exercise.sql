ALTER TABLE MarketingTeam
ADD Email varchar(255);

ALTER TABLE MarketingTeam
DROP COLUMN Email;

ALTER TABLE MarketingTeam
ALTER COLUMN Email NVARCHAR(100);

ALTER TABLE MarketingTeam
DROP COLUMN Email;

EXEC sp_rename 'MarketingTeam.Email', 'PhoneNumber', 'COLUMN';

