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
    a27 binary,
    a28 numeric
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
    1,
    234.546
)
go

EXEC sp_babelfish_configure 'babelfishpg_tsql.escape_hatch_rowversion', 'strict';
go

create table babel_726_t2 (a int, b varchar(10), c float)
go

insert into babel_726_t2 values (1, 'abcde', 1.02)
insert into babel_726_t2 values (NULL, '2.01', 1.02)
insert into babel_726_t2 values (NULL, NULL, 1.02)
go

-- dependency testing
CREATE VIEW babel_726_v1 AS
SELECT COALESCE(CAST('x'AS VARBINARY), CAST('x' AS NVARCHAR(4000)), 'x')
GO

CREATE FUNCTION babel_726_f1() RETURNS NVARCHAR(4000) AS
BEGIN
    DECLARE @ans NVARCHAR(4000)
    SELECT @ans = COALESCE(CAST('x'AS VARBINARY), CAST('x' AS NVARCHAR(4000)), 'x')
    RETURN @ans
END
GO

CREATE PROCEDURE babel_726_p1 AS 
SELECT COALESCE(CAST('x'AS VARBINARY), CAST('x' AS NVARCHAR(4000)), 'x')
GO
