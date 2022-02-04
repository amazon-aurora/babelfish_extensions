CREATE DATABASE db1;
GO

USE db1
GO

CREATE TABLE rand_name1(a int);
GO

SELECT COUNT(*) FROM sys.tables WHERE name = 'rand_name1';
GO

USE master;
GO

#table rand_name1 should not be visible in master database.
SELECT COUNT(*) FROM sys.tables WHERE name = 'rand_name1';
GO

CREATE TABLE rand_name2(a int);
GO

SELECT COUNT(*) FROM sys.tables WHERE name = 'rand_name2';
GO

USE db1
GO

#table rand_name2 should not be visible in db1 database.
SELECT COUNT(*) FROM sys.tables WHERE name = 'rand_name2';
GO

DROP TABLE rand_name1;
GO

USE master;
GO

DROP DATABASE db1;
GO

DROP TABLE rand_name2;
GO