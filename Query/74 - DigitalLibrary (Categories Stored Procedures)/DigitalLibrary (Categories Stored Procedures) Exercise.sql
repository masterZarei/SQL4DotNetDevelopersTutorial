CREATE PROCEDURE sp_AddCategory
    @Title NVARCHAR(255)
AS
BEGIN
    INSERT INTO Categories (Title)
    VALUES (@Title);

    SELECT SCOPE_IDENTITY() AS NewId;
END

CREATE PROCEDURE sp_UpdateCategory
    @Id INT,
    @Title NVARCHAR(255)
AS
BEGIN
    UPDATE Categories
    SET Title = @Title
    WHERE Id = @Id;
END


CREATE PROCEDURE sp_DeleteCategory
    @Id INT
AS
BEGIN
    DELETE FROM Categories
    WHERE Id = @Id;
END


CREATE PROCEDURE sp_GetCategoryById
    @Id INT
AS
BEGIN
    SELECT * FROM Categories
    WHERE Id = @Id;
END


CREATE PROCEDURE sp_GetAllCategories
AS
BEGIN
    SELECT * FROM Categories ORDER BY Id DESC;
END










