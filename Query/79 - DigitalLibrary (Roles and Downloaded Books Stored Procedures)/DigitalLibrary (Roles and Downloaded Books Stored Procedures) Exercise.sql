CREATE PROC sp_CreateRole
@Title NVARCHAR(255)
AS
BEGIN
	INSERT INTO Roles(Title)
	VALUES (@Title)

	SELECT SCOPE_IDENTITY() AS NewId
END

exec sp_CreateRole 'User'

CREATE PROC sp_UpdateRole
@Title NVARCHAR(255),
@Id INT
AS
BEGIN
	UPDATE Roles
	SET Title = @Title
	WHERE Id = @Id
END

CREATE PROC sp_DeleteRole
@Id INT
AS
BEGIN
	DELETE FROM Roles
	WHERE Id = @Id
END

exec sp_DeleteRole 2

CREATE PROC sp_GetRoleById
@Id INT
AS
BEGIN
	SELECT * FROM Roles
	WHERE Id = @Id
END

exec sp_GetRoleById 1

CREATE PROC sp_GetAllRoles
AS
BEGIN
	SELECT * FROM Roles
	ORDER BY Id DESC
END

exec sp_GetAllRoles


CREATE PROC sp_AddDownloadedBook
	@BookId INT,
	@UserId INT
AS
BEGIN
	IF EXISTS (SELECT 1 FROM DownloadedBooks WHERE BookId = @BookId AND UserId = @UserId)
	BEGIN
		RAISERROR('Already Exists',16,1)
		RETURN;
	END

	INSERT INTO DownloadedBooks (UserId, BookId)
	VALUES (@UserId, @BookId)
END

exec sp_AddDownloadedBook 1,1

CREATE PROC sp_GetAllDownloadedBooksByUserId
	@UserId INT
AS
BEGIN
	SELECT * FROM DownloadedBooks
	WHERE UserId = @UserId
END

exec sp_GetAllDownloadedBooksByUserId 1