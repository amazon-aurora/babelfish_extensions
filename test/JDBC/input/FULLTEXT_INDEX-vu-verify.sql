-- enable FULLTEXT
SELECT set_config('role', 'jdbc_user', false);
GO

SELECT set_config('babelfishpg_tsql.escape_hatch_fulltext', 'ignore', 'false')
GO

USE fti_test_db;
GO

-- Fetching index details to check if index is created correctly
SELECT * FROM fti_prepare_v1;
GO

EXEC fti_prepare_p1;
GO

SELECT fti_prepare_f1();
GO

SELECT tablename, indexname FROM pg_indexes WHERE tablename='fti_table_t4';
GO

SELECT tablename, indexname FROM pg_indexes WHERE tablename='fti_table_t5';
GO

SELECT tablename, indexname FROM pg_indexes WHERE tablename='fti_table_t6';
GO

SELECT tablename, indexname FROM pg_indexes WHERE tablename='fti_table_t7';
GO

SELECT tablename, indexname FROM pg_indexes WHERE tablename='fti_table_t8';
GO

-- Creating more than 1 fulltext index in a table, should throw error
CREATE FULLTEXT INDEX ON fti_schema_s1.fti_table_t8(b) KEY INDEX IX_s1_t8_b;
GO

-- Creating index in a non existent table of a schema, should throw error
CREATE FULLTEXT INDEX ON fti_schema_s1.fti_table_t9(a) KEY INDEX IX_s1_t9_a;
GO

-- Creating index in a table of a non existent schema, should throw error
CREATE FULLTEXT INDEX ON fti_schema_s3.fti_table_t8(a) KEY INDEX IX_s2_t8_a;
GO

-- should throw unsupported error
CREATE FULLTEXT INDEX ON fti_table_unsupported(a TYPE COLUMN a) KEY INDEX ix_unsupported_fti;
GO

-- should throw unsupported error
CREATE FULLTEXT INDEX ON fti_table_unsupported(a LANGUAGE 1033) KEY INDEX ix_unsupported_fti;
GO

-- should throw unsupported error
CREATE FULLTEXT INDEX ON fti_table_unsupported(a STATISTICAL_SEMANTICS) KEY INDEX ix_unsupported_fti;
GO

-- should throw unsupported error
CREATE FULLTEXT INDEX ON fti_table_unsupported(a) KEY INDEX ix_unsupported_fti ON t_unsupported_catalog;
GO

-- should throw unsupported error
CREATE FULLTEXT INDEX ON fti_table_unsupported(a) KEY INDEX ix_unsupported_fti WITH CHANGE_TRACKING OFF;
GO

-- should throw unsupported error
CREATE FULLTEXT INDEX ON fti_table_unsupported(a) KEY INDEX ix_unsupported_fti WITH STOPLIST = SYSTEM;
GO

-- should throw unsupported error
CREATE FULLTEXT INDEX ON fti_table_unsupported(a) KEY INDEX ix_unsupported_fti WITH SEARCH PROPERTY LIST = DocumentPropertyList;
GO

-- disable FULLTEXT
SELECT set_config('role', 'jdbc_user', false);
GO

SELECT set_config('babelfishpg_tsql.escape_hatch_fulltext', 'strict', 'false')
GO