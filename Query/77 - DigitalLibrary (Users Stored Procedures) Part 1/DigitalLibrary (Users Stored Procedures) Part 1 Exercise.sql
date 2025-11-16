CREATE PROC sp_CreateUser
	@FullName NVARCHAR(255),
	@PhoneNumber NVARCHAR(11),
	@Password NVARCHAR(MAX),
	@RoleId INT
AS
BEGIN 
		IF EXISTS(SELECT 1 FROM Users WHERE PhoneNumber = @PhoneNumber) 
		BEGIN
			RAISERROR('PhoneNumber already exists',16,1)
			RETURN;
		END
		INSERT INTO Users(FullName, PhoneNumber, [Password], RoleId)
		VALUES (@FullName, @PhoneNumber, @Password, @RoleId)

		SELECT SCOPE_IDENTITY() AS NewId;
END

exec sp_CreateUser 'حمید معصومی نژاد', '09366544112', '123', 1

CREATE PROC sp_UpdateUser
	@Id INT,
	@FullName NVARCHAR(255),
	@PhoneNumber NVARCHAR(11),
	@Password NVARCHAR(MAX),
	@RoleId INT
AS
BEGIN
	IF EXISTS(SELECT 1 FROM Users WHERE PhoneNumber = @PhoneNumber AND Id <> @Id) 
		BEGIN
			RAISERROR('PhoneNumber already exists',16,1)
			RETURN;
		END
	UPDATE Users
	SET
		FullName = @FullName,
		PhoneNumber = @PhoneNumber,
		RoleId = @RoleId,
		[Password] = @Password
	WHERE Id = @Id
END

exec sp_UpdateUser 1,'حمید معصومی', '09366544112', '123', 1

