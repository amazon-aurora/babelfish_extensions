DECLARE @c int;
DECLARE @val bigint = 12345;
EXEC sp_cursoropen @c OUTPUT, N'SELECT @p AS result', 1, 1, NULL, N'@p varchar(50)', @val;
EXEC sp_cursorfetch @c, 2, 0, 1;
EXEC sp_cursorclose @c;
GO

DECLARE @c int;
DECLARE @val float = 3.14;
EXEC sp_cursoropen @c OUTPUT, N'SELECT @p AS result', 1, 1, NULL, N'@p int', @val;
EXEC sp_cursorfetch @c, 2, 0, 1;
EXEC sp_cursorclose @c;
GO

DECLARE @c int;
DECLARE @val varchar(50) = '999';
EXEC sp_cursoropen @c OUTPUT, N'SELECT @p AS result', 1, 1, NULL, N'@p int', @val;
EXEC sp_cursorfetch @c, 2, 0, 1;
EXEC sp_cursorclose @c;
GO

DECLARE @c int;
DECLARE @val int = 42;
EXEC sp_cursoropen @c OUTPUT, N'SELECT @p AS result', 1, 1, NULL, N'@p varchar(50)', @val;
EXEC sp_cursorfetch @c, 2, 0, 1;
EXEC sp_cursorclose @c;
GO

DECLARE @c int;
DECLARE @val varchar(50) = '2024-01-15';
EXEC sp_cursoropen @c OUTPUT, N'SELECT @p AS result', 1, 1, NULL, N'@p datetime', @val;
EXEC sp_cursorfetch @c, 2, 0, 1;
EXEC sp_cursorclose @c;
GO

DECLARE @c int;
DECLARE @val bigint = 12345;
EXEC sp_cursoropen @c OUTPUT, N'SELECT @p AS result', 1, 1, NULL, N'@p uniqueidentifier', @val;
EXEC sp_cursorfetch @c, 2, 0, 1;
EXEC sp_cursorclose @c;
GO

DECLARE @c int;
DECLARE @val varchar(50) = 'hello';
EXEC sp_cursoropen @c OUTPUT, N'SELECT @p AS result', 1, 1, NULL, N'@p bigint', @val;
EXEC sp_cursorfetch @c, 2, 0, 1;
EXEC sp_cursorclose @c;
GO

DECLARE @c int;
DECLARE @val varchar(50) = '12345678-1234-1234-1234-123456789ABC';
EXEC sp_cursoropen @c OUTPUT, N'SELECT @p AS result', 1, 1, NULL, N'@p uniqueidentifier', @val;
EXEC sp_cursorfetch @c, 2, 0, 1;
EXEC sp_cursorclose @c;
GO

DECLARE @c int;
DECLARE @val decimal(10,2) = 123.45;
EXEC sp_cursoropen @c OUTPUT, N'SELECT @p AS result', 1, 1, NULL, N'@p varchar(50)', @val;
EXEC sp_cursorfetch @c, 2, 0, 1;
EXEC sp_cursorclose @c;
GO
