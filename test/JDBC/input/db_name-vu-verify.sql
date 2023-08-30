--switch to database irrespective of case
USE DB_NAME_VU_PREPARE_TEST1;
GO

--returning original_case_dbname
SELECT DB_NAME();
GO

--showing newly added column returning original_case_dbname
SELECT orig_name FROM sys.babelfish_sysdatabases;
GO

USE db_name_vu_prepare_test2;
GO

SELECT DB_NAME();
GO

--showing name column storing lowercase dbname and newly added column with original_case_dbname
SELECT name, orig_name FROM sys.babelfish_sysdatabases;
GO

--testing these objects behaviour
SELECT PROCEDURE_QUALIFIER FROM sys.sp_stored_procedures_view where PROCEDURE_NAME LIKE 'sp_special_columns_length_helper%';
GO

SELECT PROCEDURE_QUALIFIER FROM sys.sp_sproc_columns_view where COLUMN_NAME LIKE 'money';
GO

SELECT * from information_schema_tsql.schemata;
GO

USE master;
GO

SELECT DB_NAME();
GO