DECLARE @handle int;
EXEC sp_prepare @handle OUTPUT, N'@p varchar(50)', N'SELECT @p AS result';
EXEC sp_execute @handle, 12345;
EXEC sp_unprepare @handle;
GO

DECLARE @handle int;
DECLARE @val float = 3.14;
EXEC sp_prepare @handle OUTPUT, N'@p int', N'SELECT @p AS result';
EXEC sp_execute @handle, @val;
EXEC sp_unprepare @handle;
GO

DECLARE @handle int;
DECLARE @val varchar(50) = '999';
EXEC sp_prepare @handle OUTPUT, N'@p int', N'SELECT @p AS result';
EXEC sp_execute @handle, @val;
EXEC sp_unprepare @handle;
GO

DECLARE @handle int;
DECLARE @val bigint = 12345;
EXEC sp_prepare @handle OUTPUT, N'@p uniqueidentifier', N'SELECT @p AS result';
EXEC sp_execute @handle, @val;
EXEC sp_unprepare @handle;
GO

DECLARE @handle int;
DECLARE @val varchar(50) = 'hello';
EXEC sp_prepare @handle OUTPUT, N'@p bigint', N'SELECT @p AS result';
EXEC sp_execute @handle, @val;
EXEC sp_unprepare @handle;
GO

DECLARE @handle int;
DECLARE @val varchar(50) = '12345678-1234-1234-1234-123456789ABC';
EXEC sp_prepare @handle OUTPUT, N'@p uniqueidentifier', N'SELECT @p AS result';
EXEC sp_execute @handle, @val;
EXEC sp_unprepare @handle;
GO
