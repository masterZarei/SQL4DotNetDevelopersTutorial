CREATE PROC sp_AddCategory
@Title NVARCHAR(255)
AS
BEGIN
	INSERT INTO Categories(Title)
	VALUES (@Title)

	SELECT SCOPE_IDENTITY() AS NewId
END

exec sp_AddCategory 'جنایی'
exec sp_AddCategory 'رومان'

CREATE PROC sp_UpdateCategory
@Title NVARCHAR(255),
@Id INT
AS
BEGIN
	UPDATE Categories
	SET Title = @Title
	WHERE Id = @Id
END

CREATE PROC sp_DeleteCategory
@Id INT
AS
BEGIN
	DELETE FROM Categories
	WHERE Id = @Id
END

exec sp_DeleteCategory 2

CREATE PROC sp_GetCategoryById
@Id INT
AS
BEGIN
	SELECT * FROM Categories
	WHERE Id = @Id
END

exec sp_GetCategoryById 1

CREATE PROC sp_GetAllCategories
AS
BEGIN
	SELECT * FROM Categories
	ORDER BY Id DESC
END

exec sp_GetAllCategories

