CREATE PROC GetUserById
@UserId INT
AS
BEGIN
	SELECT * FROM Users WHERE UserId= @UserId
END

exec GetUserById 5