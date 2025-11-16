CREATE PROCEDURE sp_CreateUser
    @FullName NVARCHAR(500),
    @PhoneNumber NVARCHAR(13),
    @Password NVARCHAR(MAX),
    @RoleId INT
AS
BEGIN
	IF EXISTS(SELECT 1 FROM Users WHERE PhoneNumber = @PhoneNumber)
    BEGIN
        RAISERROR('Phone number already exists.', 16, 1);
        RETURN;
    END

    INSERT INTO Users (FullName, PhoneNumber, Password, RoleId)
    VALUES (@FullName, @PhoneNumber, @Password, @RoleId);

    SELECT SCOPE_IDENTITY() AS NewUserId;
END;


CREATE PROCEDURE sp_GetAllUsers
AS
BEGIN
    SELECT Id, FullName, PhoneNumber, RoleId
    FROM Users
    WHERE IsDeleted = 0;
END;


CREATE PROCEDURE sp_GetUserById
    @Id INT
AS
BEGIN
    SELECT Id, FullName, PhoneNumber, RoleId
    FROM Users
    WHERE Id = @Id AND IsDeleted = 0;
END;


CREATE PROCEDURE sp_UpdateUser
    @Id INT,
    @FullName NVARCHAR(500),
    @PhoneNumber NVARCHAR(13),
    @Password NVARCHAR(MAX) = NULL,
    @RoleId INT
AS
BEGIN
	IF EXISTS(SELECT 1 FROM Users WHERE PhoneNumber = @PhoneNumber AND Id <> @Id)
    BEGIN
        RAISERROR('Phone number already exists.', 16, 1);
        RETURN;
    END
    UPDATE Users
    SET 
        FullName = @FullName,
        PhoneNumber = @PhoneNumber,
        RoleId = @RoleId,
        Password = ISNULL(@Password, Password)
    WHERE Id = @Id AND IsDeleted = 0;
END;


CREATE PROCEDURE sp_SoftDeleteUser
    @Id INT
AS
BEGIN
    UPDATE Users
    SET IsDeleted = 1
    WHERE Id = @Id;
END;


CREATE PROCEDURE sp_LoginUser
    @PhoneNumber NVARCHAR(13),
    @Password NVARCHAR(MAX)
AS
BEGIN
    SELECT Id, FullName, PhoneNumber, RoleId
    FROM Users
    WHERE PhoneNumber = @PhoneNumber 
      AND Password = @Password
      AND IsDeleted = 0;
END;
