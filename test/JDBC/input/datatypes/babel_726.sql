-- only NULLs
select coalesce(NULL, NULL)
go

select coalesce(NULL)
go

-- Empty or white spaced strings
select coalesce('  ', 1)
go

select coalesce(2, '   ')
go

-- tab space
select coalesce(NULL, CHAR(9))
go

-- line break
select coalesce(NULL, char(13) + char(10))
go

-- constant string literal
SELECT COALESCE(NULL, 1, 2, 'I am a string')
go

SELECT COALESCE(NULL, 'I am a string', 1, 2)
go

-- precedence correctness
EXEC sp_babelfish_configure 'babelfishpg_tsql.escape_hatch_rowversion', 'ignore';
go

create table babel_726_t1 (
    a1 sql_variant,
    a2 datetimeoffset,
    a3 datetime2,
    a4 datetime,
    a5 smalldatetime,
    a6 date,
    a7 time,
    a8 float,
    a9 real,
    a10 decimal,
    a11 money,
    a12 smallmoney,
    a13 bigint,
    a14 int,
    a15 smallint,
    a16 tinyint,
    a17 bit,
    a18 ntext,
    a19 text,
    a20 image,
    a21 uniqueidentifier,
    a22 nvarchar(15),
    a23 nchar(15),
    a24 varchar(15),
    a25 char(15),
    a26 varbinary(15),
    a27 binary
)
go

insert into babel_726_t1 values (
    cast (1 as BIT),
    '1900-01-01 00:00+0:00',
    '2016-10-23 12:45:37.123',
    '2000-02-28 23:59:59.989',
    '2007-05-08 12:35:29',
    '2000-02-28',
    '12:45:37.123',
    1.050,
    01.05,
    123.456,
    10,
    -10.05,
    122100,
    12,
    10,
    8,
    1,
    'asdf',
    'asdfghjk',
    0x31323334,
    '51f178a6-53c7-472c-9be1-1c08942342d7',
    'asdfgh',
    'a',
    'asdfg',
    'b',
    1234,
    1
)
go

-- sql_variant and datetimeoffset
select coalesce(a1, a2) from babel_726_t1
GO
select coalesce(a2, a1) from babel_726_t1
GO

-- datetimeoffset and datetime2
select coalesce(a2, a3) from babel_726_t1
GO
select coalesce(a3, a2) from babel_726_t1
GO

-- datetime2 and datetime
select coalesce(a3, a4) from babel_726_t1
GO
select coalesce(a4, a3) from babel_726_t1
GO

-- datetime and smalldatetime
select coalesce(a4, a5) from babel_726_t1
GO
select coalesce(a5, a4) from babel_726_t1
GO

-- smalldatetime and date
select coalesce(a5, a6) from babel_726_t1
GO
select coalesce(a6, a5) from babel_726_t1
GO

-- date and time. Throws error as CASTing from time to DATE is not supported
select coalesce(a6, a7) from babel_726_t1
GO
select coalesce(a7, a6) from babel_726_t1
GO

-- time and float. Throws error as CASTing from float to time is not supported
select coalesce(a7, a8) from babel_726_t1
GO
select coalesce(a8, a7) from babel_726_t1
GO

-- float and real
select coalesce(a8, a9) from babel_726_t1
GO
select coalesce(a9, a8) from babel_726_t1
GO

-- real and decimal
select coalesce(a9, a10) from babel_726_t1
GO
select coalesce(a10, a9) from babel_726_t1
GO

-- decimal and money
select coalesce(a10, a11) from babel_726_t1
GO
select coalesce(a11, a10) from babel_726_t1
GO

-- money and smallmoney
select coalesce(a11, a12) from babel_726_t1
GO
select coalesce(a12, a11) from babel_726_t1
GO

-- smallmoney and bigint
select coalesce(a12, a13) from babel_726_t1
GO
select coalesce(a13, a12) from babel_726_t1
GO

-- bigint and int
select coalesce(a13, a14) from babel_726_t1
GO
select coalesce(a14, a13) from babel_726_t1
GO

-- int and smallint
select coalesce(a14, a15) from babel_726_t1
GO
select coalesce(a15, a14) from babel_726_t1
GO

-- smallint and tinyint
select coalesce(a15, a16) from babel_726_t1
GO
select coalesce(a16, a15) from babel_726_t1
GO

-- tinyint and bit
select coalesce(a16, a17) from babel_726_t1
GO
select coalesce(a17, a16) from babel_726_t1
GO

-- bit and ntext. Throws error as CASTing from ntext to bit is not supported
select coalesce(a17, a18) from babel_726_t1
GO
select coalesce(a18, a17) from babel_726_t1
GO

-- ntext and text
select coalesce(a18, a19) from babel_726_t1
GO
select coalesce(a19, a18) from babel_726_t1
GO

-- text and image.
select coalesce(a19, a20) from babel_726_t1
GO
select coalesce(a20, a19) from babel_726_t1
GO

-- image and uniqueidentifier. 
select coalesce(a20, a21) from babel_726_t1
GO
select coalesce(a21, a20) from babel_726_t1
GO

-- uniqueidentifier and nvarchar
select coalesce(a21, a22) from babel_726_t1
GO
select coalesce(a22, a21) from babel_726_t1
GO

-- nvarchar and nchar
select coalesce(a22, a23) from babel_726_t1
GO
select coalesce(a23, a22) from babel_726_t1
GO

-- nchar and varchar
select coalesce(a23, a24) from babel_726_t1
GO
select coalesce(a24, a23) from babel_726_t1
GO

-- varchar and char
select coalesce(a24, a25) from babel_726_t1
GO
select coalesce(a25, a24) from babel_726_t1
GO

-- char and varbinary
select coalesce(a25, a26) from babel_726_t1
GO
select coalesce(a26, a25) from babel_726_t1
GO

-- varbinary and binary
select coalesce(a26, a27) from babel_726_t1
GO
select coalesce(a27, a26) from babel_726_t1
GO

EXEC sp_babelfish_configure 'babelfishpg_tsql.escape_hatch_rowversion', 'strict';
go

create table babel_726_t2 (a int, b varchar(10), c float)
go

insert into babel_726_t2 values (1, 'abcde', 1.02)
insert into babel_726_t2 values (NULL, '2.01', 1.02)
insert into babel_726_t2 values (NULL, NULL, 1.02)
go

select coalesce(a,b,c) from babel_726_t2
go

insert into babel_726_t2 values (NULL, 'abcde', 1.02)
go

select coalesce(a,b,c) from babel_726_t2
go

drop table babel_726_t1
go

drop table babel_726_t2
go
