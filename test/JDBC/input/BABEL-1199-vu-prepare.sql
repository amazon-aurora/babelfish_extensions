CREATE VIEW view_database_principal_id_v1
AS
SELECT principal_id AS database_principal_id
FROM sys.database_principals;
GO

CREATE VIEW dbo.view_current_principal_id AS
SELECT DATABASE_PRINCIPAL_ID();
GO

CREATE PROCEDURE dbo.proc_current_principal_id
AS
BEGIN
    SELECT DATABASE_PRINCIPAL_ID();
END;
GO

CREATE VIEW dbo.view_db_owner_principal_id AS
SELECT DATABASE_PRINCIPAL_ID('db_owner');
GO

CREATE PROCEDURE dbo.proc_db_owner_principal_id
AS
BEGIN
    SELECT DATABASE_PRINCIPAL_ID('db_owner');
END;
GO

CREATE VIEW dbo.view_db_owner_principal_id_v1 AS
SELECT DATABASE_PRINCIPAL_ID('db_temp');
GO