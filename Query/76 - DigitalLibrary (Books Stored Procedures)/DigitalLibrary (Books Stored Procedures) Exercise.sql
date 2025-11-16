CREATE PROC sp_AddBook
	@Title NVARCHAR(255),
	@Description NVARCHAR(MAX),
	@ImageUrl NVARCHAR(MAX),
	@FileUrl NVARCHAR(MAX),
	@Author NVARCHAR(255),
	@CategoryId INT
AS
BEGIN
	INSERT INTO Books (Title, [Description], ImageUrl, FileUrl, Author, CategoryId)
	VALUES (@Title, @Description, @ImageUrl, @FileUrl, @Author, @CategoryId)

	SELECT SCOPE_IDENTITY() AS NewId;
END

exec sp_AddBook 'اثر مرکب','کتابی برای تحول زندگی شما', 'Image', 'File','دارن هاردی',1

CREATE PROC sp_UpdateBook
	@Id INT,
	@Title NVARCHAR(255),
	@Description NVARCHAR(MAX),
	@ImageUrl NVARCHAR(MAX),
	@FileUrl NVARCHAR(MAX),
	@Author NVARCHAR(255),
	@CategoryId INT
AS
BEGIN
	UPDATE Books
	SET 
		Title = @Title,
		[Description] = @Description,
		ImageUrl = @ImageUrl,
		FileUrl = @FileUrl,
		Author = @Author,
		CategoryId = @CategoryId
	WHERE Id = @Id AND IsDeleted = 0
END

exec sp_UpdateBook 1,'بیندیشید و ثروتمند شوید','کتابی برای تحول زندگی شما', 'Image', 'File','ناپلئون هیل',1

CREATE PROC sp_DeleteBook
	@Id INT
AS
BEGIN
	UPDATE Books
	SET IsDeleted = 1
	WHERE Id = @Id
END

exec sp_DeleteBook 1

CREATE PROC sp_GetBookById
	@Id INT
AS
BEGIN
	SELECT * FROM Books
	WHERE Id = @Id AND IsDeleted = 0
END

exec sp_GetBookById 1

CREATE PROC sp_GetAllBook
AS
BEGIN
	SELECT * FROM Books
	WHERE IsDeleted = 0
	ORDER BY Id DESC
END

