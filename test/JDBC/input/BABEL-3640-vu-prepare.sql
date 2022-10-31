create database babel_3640_db;
go

use babel_3640_db;
go

create table MyTable1 (a int, b int, c int)
go
create view t_sptables5
as
select a from MyTable1
go

create table trans2(id int identity(1,1) primary key, source int, target int, amount int);
go

create proc babel_3640_p1 as
    declare @p3 varchar(32) = '''''''TABLE''''''';
    EXEC sp_tables NULL,NULL,NULL,@p3;
go

create proc babel_3640_p2 as
    declare @p3 varchar(32) = '''TABLE''';
    EXEC sp_tables NULL,NULL,NULL,@p3;
go

create proc babel_3640_p3 as
    declare @p3 varchar(32) = 'TABLE';
    EXEC sp_tables NULL,NULL,NULL,@p3;
go

create proc babel_3640_p4 as
    declare @p3 varchar(32) = '''''''VIEW''''''';
    EXEC sp_tables NULL,NULL,NULL,@p3;
go

create proc babel_3640_p5 as
    declare @p3 varchar(32) = '''VIEW''';
    EXEC sp_tables NULL,NULL,NULL,@p3;
go

create proc babel_3640_p6 as
    declare @p3 varchar(32) = 'VIEW';
    EXEC sp_tables NULL,NULL,NULL,@p3;
go
