Create database sp_rename_database1;
go
use sp_rename_database1
go
Create role sp_rename_role1;
go
Create schema sp_rename_schema1;
go
Create login sp_rename_login1 with password = '1234', default_database = sp_rename_database1;
go
Create database [sp_rename_ThisOldDatabaseNameIsCaseSensitiveAndIsLongerThan64DigitsToTestRenameDb];
go
Create login sp_rename_login2 with password = '1234';
go
Use sp_rename_database1
go
Create User sp_rename_login2;
go