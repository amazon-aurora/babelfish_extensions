use master
go

create table trans2(id int identity(1,1) primary key, source int, target int, amount int);
go

create table MyTable1 (a int, b int, c int)
go
create view t_sptables5
as
select a from MyTable1
go

declare @p0 sysname = 'trans2';
declare @p1 sysname = null;
declare @p2 sysname = null;
declare @p3 varchar(32) = '''''''TABLE''''''';
EXEC sp_tables @P0, @P1, @P2, @P3; -- non-empty
go

declare @p0 sysname = 'trans2';
declare @p1 sysname = null;
declare @p2 sysname = null;
declare @p3 varchar(32) = '''TABLE''';
EXEC sp_tables @P0, @P1, @P2, @P3; -- non-empty
go

declare @p0 sysname = 'trans2';
declare @p1 sysname = null;
declare @p2 sysname = null;
declare @p3 varchar(32) = 'TABLE';
EXEC sp_tables @P0, @P1, @P2, @P3; -- empty
go

declare @p0 sysname = 't_sptables5';
declare @p1 sysname = null;
declare @p2 sysname = null;
declare @p3 varchar(32) = '''VIEW''';
EXEC sp_tables @P0, @P1, @P2, @P3; -- non-empty
go

declare @p0 sysname = 't_sptables5';
declare @p1 sysname = null;
declare @p2 sysname = null;
declare @p3 varchar(32) = '''''''VIEW''''''';
EXEC sp_tables @P0, @P1, @P2, @P3; -- non-empty
go

declare @p0 sysname = 't_sptables5';
declare @p1 sysname = null;
declare @p2 sysname = null;
declare @p3 varchar(32) = 'VIEW';
EXEC sp_tables @P0, @P1, @P2, @P3; -- empty
go

drop table trans2
go

drop view t_sptables5
go

DROP table MyTable1
go