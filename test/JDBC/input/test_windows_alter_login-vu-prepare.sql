-- create login for windows
CREATE LOGIN [BAbel\aDUser_alter] from windows;
GO

-- create login for password
CREATE LOGIN passWORduser_alter with password='123';
GO

CREATE LOGIN [aduser_alter@BBF] with password='123';
GO

-- create a database to test alter login with default database
CREATE DATABASE alter_db;
GO