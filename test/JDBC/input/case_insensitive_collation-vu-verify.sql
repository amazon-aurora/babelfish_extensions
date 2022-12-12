select name from sys.columns where name = 'Test';
go

select name from sys.columns where name = 'TesT';
go

select COUNT(*) FROM sys.tables WHERE name = 'cameltable';
go

select COUNT(*) FROM sys.tables WHERE name = 'CAMELTABLE';
go

select COUNT(*) FROM sys.tables WHERE name = 'CaMeLtAbLe';
go

SELECT COUNT(*) FROM sys.columns WHERE name = 'cAmElCoLuMn';
go

select COUNT(*) FROM sys.views WHERE name = 'CAMELview';
go

select name from sys.databases where name = 'test';
go

select name from sys.databases where name = 'TEST';
go

select * from vB;
go

SELECT t.TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES AS t
JOIN sys.objects o ON t.TABLE_NAME = o.name where o.name = 'mytable' AND o.object_id != 0;
go

-- [BABEL-2981]
-- sys.sysname and other string types in Babelfish need to have the correct collation
select typ.typname, coll.collname from pg_type typ join pg_collation coll on typ.typcollation = coll.oid where typnamespace = (select oid from pg_namespace where nspname = 'sys');
go
