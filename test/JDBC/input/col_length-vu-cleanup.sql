USE babel_3489_test_db;
GO

DROP TABLE IF EXISTS sys_column_length_test_table;
GO

DROP TABLE IF EXISTS sys_col_length_test_schema.test_table;
GO

DROP SCHEMA IF EXISTS sys_col_length_test_schema;
GO

USE master;
GO

DROP DATABASE IF EXISTS babel_3489_test_db;
GO

-- Drop views
DROP VIEW IF EXISTS col_length_prepare_v1;
DROP VIEW IF EXISTS col_length_prepare_v2;
DROP VIEW IF EXISTS col_length_prepare_v3;
DROP VIEW IF EXISTS col_length_prepare_v4;
DROP VIEW IF EXISTS col_length_prepare_v5;
DROP VIEW IF EXISTS col_length_prepare_v6;
DROP VIEW IF EXISTS col_length_prepare_v7;
DROP VIEW IF EXISTS col_length_prepare_v8;
DROP VIEW IF EXISTS col_length_prepare_v9;
DROP VIEW IF EXISTS col_length_prepare_v10;
GO

-- Drop procedures
DROP PROCEDURE IF EXISTS col_length_prepare_p1;
DROP PROCEDURE IF EXISTS col_length_prepare_p2;
DROP PROCEDURE IF EXISTS col_length_prepare_p3;
DROP PROCEDURE IF EXISTS col_length_prepare_p4;
DROP PROCEDURE IF EXISTS col_length_prepare_p5;
DROP PROCEDURE IF EXISTS col_length_prepare_p6;
DROP PROCEDURE IF EXISTS col_length_prepare_p7;
DROP PROCEDURE IF EXISTS col_length_prepare_p8;
DROP PROCEDURE IF EXISTS col_length_prepare_p9;
DROP PROCEDURE IF EXISTS col_length_prepare_p10;
GO

-- Drop functions
DROP FUNCTION IF EXISTS col_length_prepare_f1();
DROP FUNCTION IF EXISTS col_length_prepare_f2();
DROP FUNCTION IF EXISTS col_length_prepare_f3();
DROP FUNCTION IF EXISTS col_length_prepare_f4();
DROP FUNCTION IF EXISTS col_length_prepare_f5();
DROP FUNCTION IF EXISTS col_length_prepare_f6();
DROP FUNCTION IF EXISTS col_length_prepare_f7();
DROP FUNCTION IF EXISTS col_length_prepare_f8();
DROP FUNCTION IF EXISTS col_length_prepare_f9();
DROP FUNCTION IF EXISTS col_length_prepare_f10();
DROP FUNCTION IF EXISTS col_length_prepare_f11();
DROP FUNCTION IF EXISTS col_length_prepare_f12();
DROP FUNCTION IF EXISTS col_length_prepare_f13();
DROP FUNCTION IF EXISTS col_length_prepare_f14();
DROP FUNCTION IF EXISTS col_length_prepare_f15();
DROP FUNCTION IF EXISTS col_length_prepare_f16();
GO

-- Drop types
DROP TYPE custom_char_10;
DROP TYPE custom_varchar_20;
DROP TYPE custom_binary_5;
DROP TYPE custom_varbinary_15;
DROP TYPE custom_nchar_8;
DROP TYPE custom_nvarchar_16;
DROP TYPE custom_text;
DROP TYPE custom_image;
DROP TYPE custom_ntext;
DROP TYPE custom_sysname;
DROP TYPE custom_sql_variant;
DROP TYPE custom_xml;
DROP TYPE custom_varcharmax;
DROP TYPE custom_nvarcharmax;
DROP TYPE custom_varbinarymax;
DROP TYPE custom_bit;
DROP TYPE custom_tinyint;
DROP TYPE custom_bigint;
DROP TYPE custom_smallint;
DROP TYPE custom_smallmoney;
DROP TYPE custom_money;
DROP TYPE custom_smalldatetime;
DROP TYPE custom_real;
DROP TYPE custom_float;
DROP TYPE custom_time;
DROP TYPE custom_datetime;
DROP TYPE custom_datetime2;
DROP TYPE custom_datetimeoffset;
DROP TYPE custom_uniqueidentifier;
DROP TYPE custom_date;
DROP TYPE custom_decimal_10_5;
DROP TYPE custom_numeric_3_0;
GO