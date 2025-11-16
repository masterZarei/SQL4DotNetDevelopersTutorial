CREATE PROCEDURE sp_AddBook
    @Title NVARCHAR(255),
    @Description NVARCHAR(MAX),
    @ImageUrl NVARCHAR(MAX),
    @FileUrl NVARCHAR(MAX),
    @Author NVARCHAR(255),
    @CategoryId INT
AS
BEGIN
    INSERT INTO Books (Title, [Description], ImageUrl, FileUrl, Author, CategoryId)
    VALUES (@Title, @Description, @ImageUrl, @FileUrl, @Author, @CategoryId);

    SELECT SCOPE_IDENTITY() AS NewId;
END


CREATE PROCEDURE sp_UpdateBook
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
    WHERE Id = @Id AND IsDeleted = 0;
END


CREATE PROCEDURE sp_DeleteBook
    @Id INT
AS
BEGIN
    UPDATE Books
    SET IsDeleted = 1
    WHERE Id = @Id;
END


CREATE PROCEDURE sp_DeleteBook
    @Id INT
AS
BEGIN
    UPDATE Books
    SET IsDeleted = 1
    WHERE Id = @Id;
END


CREATE PROCEDURE sp_GetBookById
    @Id INT
AS
BEGIN
    SELECT *
    FROM Books
    WHERE Id = @Id AND IsDeleted = 0;
END


CREATE PROCEDURE sp_GetAllBooks
AS
BEGIN
    SELECT *
    FROM Books
    WHERE IsDeleted = 0
    ORDER BY Id DESC;
END


















