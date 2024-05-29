-- Convert BIGINT valid operations
CREATE VIEW BABEL_3486_vu_prepare_v13 as (SELECT TRY_CONVERT(bigint, 5));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p13 as (SELECT TRY_CONVERT(bigint, 5));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f13()
RETURNS BIGINT AS
BEGIN
RETURN (SELECT TRY_CONVERT(bigint, 5));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v14 as (SELECT TRY_CONVERT(bigint, -5));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p14 as (SELECT TRY_CONVERT(bigint, -5));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f14()
RETURNS BIGINT AS
BEGIN
RETURN (SELECT TRY_CONVERT(bigint, -5));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v15 as (SELECT TRY_CONVERT(bigint, 9223372036854775808));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p15 as (SELECT TRY_CONVERT(bigint, 9223372036854775808));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f15()
RETURNS BIGINT AS
BEGIN
RETURN (SELECT TRY_CONVERT(bigint, 9223372036854775808));
END
GO

-- Convert int valid operations
CREATE VIEW BABEL_3486_vu_prepare_v16 as (SELECT TRY_CONVERT(int, 5));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p16 as (SELECT TRY_CONVERT(int, 5));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f16()
RETURNS INT AS
BEGIN
RETURN (SELECT TRY_CONVERT(int, 5));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v17 as (SELECT TRY_CONVERT(int, -5));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p17 as (SELECT TRY_CONVERT(int, -5));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f17()
RETURNS int AS
BEGIN
RETURN (SELECT TRY_CONVERT(int, -5));
END
GO

-- Convert int invalid operations
CREATE VIEW BABEL_3486_vu_prepare_v18 as (SELECT TRY_CONVERT(int, 'a'));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p18 as (SELECT TRY_CONVERT(int, 'a'));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f18()
RETURNS int AS
BEGIN
RETURN (SELECT TRY_CONVERT(int, 'a'));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v19 as (SELECT TRY_CONVERT(int, 2147483648));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p19 as (SELECT TRY_CONVERT(int, 2147483648));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f19()
RETURNS int AS
BEGIN
RETURN (SELECT TRY_CONVERT(int, 2147483648));
END
GO

-- Convert smallint valid operations
CREATE VIEW BABEL_3486_vu_prepare_v20 as (SELECT TRY_CONVERT(smallint, 5));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p20 as (SELECT TRY_CONVERT(smallint, 5));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f20()
RETURNS smallint AS
BEGIN
RETURN (SELECT TRY_CONVERT(smallint, 5));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v21 as (SELECT TRY_CONVERT(smallint, -5));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p21 as (SELECT TRY_CONVERT(smallint, -5));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f21()
RETURNS smallint AS
BEGIN
RETURN (SELECT TRY_CONVERT(smallint, -5));
END
GO

-- Convert smallint invalid operations
CREATE VIEW BABEL_3486_vu_prepare_v22 as (SELECT TRY_CONVERT(smallint, 'a'));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p22 as (SELECT TRY_CONVERT(smallint, 'a'));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f22()
RETURNS smallint AS
BEGIN
RETURN (SELECT TRY_CONVERT(smallint, 'a'));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v23 as (SELECT TRY_CONVERT(smallint, 32768));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p23 as (SELECT TRY_CONVERT(smallint, 32768));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f23()
RETURNS smallint AS
BEGIN
RETURN (SELECT TRY_CONVERT(smallint, 32768));
END
GO

-- Convert bit valid operations
CREATE VIEW BABEL_3486_vu_prepare_v24 as (SELECT TRY_CONVERT(bit, 1));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p24 as (SELECT TRY_CONVERT(bit, 1));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f24()
RETURNS bit AS
BEGIN
RETURN (SELECT TRY_CONVERT(bit, 1));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v25 as (SELECT TRY_CONVERT(bit, 0));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p25 as (SELECT TRY_CONVERT(bit, 0));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f25()
RETURNS bit AS
BEGIN
RETURN (SELECT TRY_CONVERT(bit, 0));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v26 as (SELECT TRY_CONVERT(bit, 5));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p26 as (SELECT TRY_CONVERT(bit, 5));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f26()
RETURNS bit AS
BEGIN
RETURN (SELECT TRY_CONVERT(bit, 5));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v27 as (SELECT TRY_CONVERT(bit, CAST(5.0 AS decimal)));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p27 as (SELECT TRY_CONVERT(bit, CAST(5.0 AS decimal)));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f27()
RETURNS bit AS
BEGIN
RETURN (SELECT TRY_CONVERT(bit, CAST(5.0 AS decimal)));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v28 as (SELECT TRY_CONVERT(bit, null));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p28 as (SELECT TRY_CONVERT(bit, null));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f28()
RETURNS bit AS
BEGIN
RETURN (SELECT TRY_CONVERT(bit, null));
END
GO

-- Convert bit invalid operations
CREATE VIEW BABEL_3486_vu_prepare_v29 as (SELECT TRY_CONVERT(bit, 'a'));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p29 as (SELECT TRY_CONVERT(bit, 'a'));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f29()
RETURNS bit AS
BEGIN
RETURN (SELECT TRY_CONVERT(bit, 'a'));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v29_2 as (SELECT TRY_CONVERT(bit, CAST('13:01:59' AS time)));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p29_2 as (SELECT TRY_CONVERT(bit, CAST('13:01:59' AS time)));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f29_2()
RETURNS bit AS
BEGIN
RETURN (SELECT TRY_CONVERT(bit, CAST('13:01:59' AS time)));
END
GO

-- Convert numeric valid
CREATE VIEW BABEL_3486_vu_prepare_v30 as (SELECT TRY_CONVERT(numeric(3,2), 5.33));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p30 as (SELECT TRY_CONVERT(numeric(3,2), 5.33));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f30()
RETURNS numeric AS
BEGIN
RETURN (SELECT TRY_CONVERT(numeric(3,2), 5.33));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v31 as (SELECT TRY_CONVERT(numeric(2,1), -5.34));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p31 as (SELECT TRY_CONVERT(numeric(2,1), -5.34));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f31()
RETURNS numeric AS
BEGIN
RETURN (SELECT TRY_CONVERT(numeric(2,1), -5.34));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v32 as (SELECT TRY_CONVERT(numeric(2,1), CAST(5.0 AS decimal)));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p32 as (SELECT TRY_CONVERT(numeric(2,1), CAST(5.0 AS decimal)));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f32()
RETURNS numeric AS
BEGIN
RETURN (SELECT TRY_CONVERT(numeric(2,1), CAST(5.0 AS decimal)));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v33 as (SELECT TRY_CONVERT(numeric(2,1), CAST(5.0 AS decimal(2,1))));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p33 as (SELECT TRY_CONVERT(numeric(2,1), CAST(5.0 AS decimal(2,1))));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f33()
RETURNS numeric AS
BEGIN
RETURN (SELECT TRY_CONVERT(numeric(2,1), CAST(5.0 AS decimal(2,1))));
END
GO

-- Convert numeric invalid operations
CREATE VIEW BABEL_3486_vu_prepare_v34 as (SELECT TRY_CONVERT(numeric(2,1), 'a'));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p34 as (SELECT TRY_CONVERT(numeric(2,1), 'a'));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f34()
RETURNS numeric AS
BEGIN
RETURN (SELECT TRY_CONVERT(numeric(2,1), 'a'));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v35 as (SELECT TRY_CONVERT(numeric(2,1), CAST('13:01:59' AS time)));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p35 as (SELECT TRY_CONVERT(numeric(2,1), CAST('13:01:59' AS time)));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f35()
RETURNS numeric AS
BEGIN
RETURN (SELECT TRY_CONVERT(numeric(2,1), CAST('13:01:59' AS time)));
END
GO


CREATE PROCEDURE BABEL_3486_vu_prepare_p35_2 as (SELECT TRY_CONVERT(numeric(1,2), CAST(5.0 AS decimal)));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f35_2()
RETURNS numeric AS
BEGIN
RETURN (SELECT TRY_CONVERT(numeric(1,2), CAST(5.0 AS decimal)));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v36 as (SELECT TRY_CONVERT(numeric(1,1), CAST(5.0 AS decimal)));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p36 as (SELECT TRY_CONVERT(numeric(1,1), CAST(5.0 AS decimal)));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f36()
RETURNS numeric AS
BEGIN
RETURN (SELECT TRY_CONVERT(numeric(1,1), CAST(5.0 AS decimal)));
END
GO

-- Convert decimal valid operations
CREATE VIEW BABEL_3486_vu_prepare_v37 as (SELECT TRY_CONVERT(decimal(3,2), 5.33));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p37 as (SELECT TRY_CONVERT(decimal(3,2), 5.33));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f37()
RETURNS decimal AS
BEGIN
RETURN (SELECT TRY_CONVERT(decimal(3,2), 5.33));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v38 as (SELECT TRY_CONVERT(decimal(1,0), -5.34));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p38 as (SELECT TRY_CONVERT(decimal(1,0), -5.34));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f38()
RETURNS decimal AS
BEGIN
RETURN (SELECT TRY_CONVERT(decimal(1,0), -5.34));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v39 as (SELECT TRY_CONVERT(decimal(1,0), CAST(5.0 AS numeric(2,1))));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p39 as (SELECT TRY_CONVERT(decimal(1,0), CAST(5.0 AS numeric(2,1))));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f39()
RETURNS decimal AS
BEGIN
RETURN (SELECT TRY_CONVERT(decimal(1,0), CAST(5.0 AS numeric(2,1))));
END
GO

-- Convert decimal invalid operations
CREATE VIEW BABEL_3486_vu_prepare_v40 as (SELECT TRY_CONVERT(decimal, 'a'));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p40 as (SELECT TRY_CONVERT(decimal, 'a'));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f40()
RETURNS decimal AS
BEGIN
RETURN (SELECT TRY_CONVERT(decimal, 'a'));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v41 as (SELECT TRY_CONVERT(decimal(1,1), -5.34));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p41 as (SELECT TRY_CONVERT(decimal(1,1), -5.34));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f41()
RETURNS decimal AS
BEGIN
RETURN (SELECT TRY_CONVERT(decimal(1,1), -5.34));
END
GO


CREATE PROCEDURE BABEL_3486_vu_prepare_p42 as (SELECT TRY_CONVERT(decimal(1,2), CAST(5.0 AS numeric(2,1))));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f42()
RETURNS decimal AS
BEGIN
RETURN (SELECT TRY_CONVERT(decimal(1,2), CAST(5.0 AS numeric(2,1))));
END
GO


-- Convert money valid operations
CREATE VIEW BABEL_3486_vu_prepare_v43 as (SELECT TRY_CONVERT(MONEY, 5.33));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p43 as (SELECT TRY_CONVERT(MONEY, 5.33));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f43()
RETURNS MONEY AS
BEGIN
RETURN (SELECT TRY_CONVERT(MONEY, 5.33));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v44 as (SELECT TRY_CONVERT(MONEY, 5.335432));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p44 as (SELECT TRY_CONVERT(MONEY, 5.335432));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f44()
RETURNS MONEY AS
BEGIN
RETURN (SELECT TRY_CONVERT(MONEY, 5.335432));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v45 as (SELECT TRY_CONVERT(MONEY, -5.33));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p45 as (SELECT TRY_CONVERT(MONEY, -5.33));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f45()
RETURNS MONEY AS
BEGIN
RETURN (SELECT TRY_CONVERT(MONEY, -5.33));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v46 as (SELECT TRY_CONVERT(MONEY, '-5.33'));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p46 as (SELECT TRY_CONVERT(MONEY, '-5.33'));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f46()
RETURNS MONEY AS
BEGIN
RETURN (SELECT TRY_CONVERT(MONEY, '-5.33'));
END
GO

-- Convert money invalid operations
CREATE VIEW BABEL_3486_vu_prepare_v47 as (SELECT TRY_CONVERT(MONEY, 'a'));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p47 as (SELECT TRY_CONVERT(MONEY, 'a'));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f47()
RETURNS MONEY AS
BEGIN
RETURN (SELECT TRY_CONVERT(MONEY, 'a'));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v47_2 as (SELECT TRY_CONVERT(MONEY, CAST('2017-08-25' AS date)));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p47_2 as (SELECT TRY_CONVERT(MONEY, CAST('2017-08-25' AS date)));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f47_2()
RETURNS MONEY AS
BEGIN
RETURN (SELECT TRY_CONVERT(MONEY, CAST('2017-08-25' AS date)));
END
GO

-- Convert float valid operations
CREATE VIEW BABEL_3486_vu_prepare_v48 as (SELECT TRY_CONVERT(float, 5.33));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p48 as (SELECT TRY_CONVERT(float, 5.33));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f48()
RETURNS float AS
BEGIN
RETURN (SELECT TRY_CONVERT(float, 5.33));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v49 as (SELECT TRY_CONVERT(float, -5.335432));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p49 as (SELECT TRY_CONVERT(float, -5.335432));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f49()
RETURNS float AS
BEGIN
RETURN (SELECT TRY_CONVERT(float, -5.335432));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v50 as (SELECT TRY_CONVERT(float, CAST(5.0 AS numeric(2,0))));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p50 as (SELECT TRY_CONVERT(float, CAST(5.0 AS numeric(2,0))));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f50()
RETURNS float AS
BEGIN
RETURN (SELECT TRY_CONVERT(float, CAST(5.0 AS numeric(2,0))));
END
GO

-- Convert float invalid operations
CREATE VIEW BABEL_3486_vu_prepare_v51 as (SELECT TRY_CONVERT(float, 'a'));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p51 as (SELECT TRY_CONVERT(float, 'a'));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f51()
RETURNS float AS
BEGIN
RETURN (SELECT TRY_CONVERT(float, 'a'));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v52 as (SELECT TRY_CONVERT(float, CAST('2017-08-25' AS date)));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p52 as (SELECT TRY_CONVERT(float, CAST('2017-08-25' AS date)));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f52()
RETURNS float AS
BEGIN
RETURN (SELECT TRY_CONVERT(float, CAST('2017-08-25' AS date)));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v53 as (SELECT TRY_CONVERT(float, CAST('13:01:59' AS time)));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p53 as (SELECT TRY_CONVERT(float, CAST('13:01:59' AS time)));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f53()
RETURNS float AS
BEGIN
RETURN (SELECT TRY_CONVERT(float, CAST('13:01:59' AS time)));
END
GO

-- Convert varchar valid operations
CREATE VIEW BABEL_3486_vu_prepare_v54 as (SELECT TRY_CONVERT(varchar(30), CAST(5 AS MONEY)));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p54 as (SELECT TRY_CONVERT(varchar(30), CAST(5 AS MONEY)));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f54()
RETURNS varchar AS
BEGIN
RETURN (SELECT TRY_CONVERT(varchar(30), CAST(5 AS MONEY), 1));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v55 as (SELECT TRY_CONVERT(varchar(30), CAST('13:01:59' AS time), 8));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p55 as (SELECT TRY_CONVERT(varchar(30), CAST('13:01:59' AS time), 8));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f55()
RETURNS varchar AS
BEGIN
RETURN (SELECT TRY_CONVERT(varchar(30), CAST('13:01:59' AS time), 8));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v56 as (SELECT TRY_CONVERT(varchar(2), CAST('13:01:59' AS time), 8));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p56 as (SELECT TRY_CONVERT(varchar(2), CAST('13:01:59' AS time), 8));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f56()
RETURNS varchar AS
BEGIN
RETURN (SELECT TRY_CONVERT(varchar(2), CAST('13:01:59' AS time), 8));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v57 as (SELECT TRY_CONVERT(varchar(30), CAST(5 AS bigint), 8));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p57 as (SELECT TRY_CONVERT(varchar(30), CAST(5 AS bigint), 8));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f57()
RETURNS varchar AS
BEGIN
RETURN (SELECT TRY_CONVERT(varchar(30), CAST(5 AS bigint), 8));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v58 as (SELECT TRY_CONVERT(varchar(30), CAST(5 AS smallint), 8));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p58 as (SELECT TRY_CONVERT(varchar(30), CAST(5 AS smallint), 8));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f58()
RETURNS varchar AS
BEGIN
RETURN (SELECT TRY_CONVERT(varchar(30), CAST(5 AS smallint), 8));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v59 as (SELECT TRY_CONVERT(varchar(30), CAST(5 AS int), 8));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p59 as (SELECT TRY_CONVERT(varchar(30), CAST(5 AS int), 8));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f59()
RETURNS varchar AS
BEGIN
RETURN (SELECT TRY_CONVERT(varchar(30), CAST(5 AS int), 8));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v60 as (SELECT TRY_CONVERT(varchar(30), CAST(5 AS numeric), 8));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p60 as (SELECT TRY_CONVERT(varchar(30), CAST(5 AS numeric), 8));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f60()
RETURNS varchar AS
BEGIN
RETURN (SELECT TRY_CONVERT(varchar(30), CAST(5 AS numeric), 8));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v61 as (SELECT TRY_CONVERT(varchar(30), CAST(5.0 AS decimal), 8));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p61 as (SELECT TRY_CONVERT(varchar(30), CAST(5.0 AS decimal), 8));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f61()
RETURNS varchar AS
BEGIN
RETURN (SELECT TRY_CONVERT(varchar(30), CAST(5.0 AS decimal), 8));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v62 as (SELECT TRY_CONVERT(varchar(30), CAST(1 AS bit), 8));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p62 as (SELECT TRY_CONVERT(varchar(30), CAST(1 AS bit), 8));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f62()
RETURNS varchar AS
BEGIN
RETURN (SELECT TRY_CONVERT(varchar(30), CAST(1 AS bit), 8));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v63 as (SELECT TRY_CONVERT(varchar(30), CAST(1 AS smallmoney), 8));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p63 as ((SELECT TRY_CONVERT(varchar(30), CAST(1 AS smallmoney), 8)));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f63()
RETURNS varchar AS
BEGIN
RETURN ((SELECT TRY_CONVERT(varchar(30), CAST(1 AS smallmoney), 8)));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v64 as (SELECT TRY_CONVERT(varchar(30), 'test', 8));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p64 as (SELECT TRY_CONVERT(varchar(30), 'test', 8));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f64()
RETURNS varchar AS
BEGIN
RETURN (SELECT TRY_CONVERT(varchar(30), 'test', 8));
END
GO

-- Convert Varchar invalid operations
CREATE VIEW BABEL_3486_vu_prepare_v65 as (SELECT TRY_CONVERT(varchar(30), CAST('2017-08-25' AS date), 8));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p65 as (SELECT TRY_CONVERT(varchar(30), CAST('2017-08-25' AS date), 8));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f65()
RETURNS varchar AS
BEGIN
RETURN (SELECT TRY_CONVERT(varchar(30), CAST('2017-08-25' AS date), 8));
END
GO

-- Convert text valid operations
CREATE VIEW BABEL_3486_vu_prepare_v66 as (SELECT TRY_CONVERT(text, CAST(5 AS MONEY), 8));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p66 as (SELECT TRY_CONVERT(text, CAST(5 AS MONEY), 8));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f66()
RETURNS varchar AS
BEGIN
RETURN (SELECT TRY_CONVERT(text, CAST(5 AS MONEY), 8));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v67 as (SELECT TRY_CONVERT(text, CAST('2017-08-25' AS date), 8));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p67 as (SELECT TRY_CONVERT(text, CAST('2017-08-25' AS date), 8));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f67()
RETURNS varchar AS
BEGIN
RETURN (SELECT TRY_CONVERT(text, CAST('2017-08-25' AS date), 8));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v68 as (SELECT TRY_CONVERT(text, CAST(5 AS bigint), 8));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p68 as (SELECT TRY_CONVERT(text, CAST(5 AS bigint), 8));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f68()
RETURNS varchar AS
BEGIN
RETURN (SELECT TRY_CONVERT(text, CAST(5 AS bigint), 8));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v69 as (SELECT TRY_CONVERT(text, CAST(5 AS smallint), 8));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p69 as (SELECT TRY_CONVERT(text, CAST(5 AS smallint), 8));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f69()
RETURNS varchar AS
BEGIN
RETURN (SELECT TRY_CONVERT(text, CAST(5 AS smallint), 8));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v70 as (SELECT TRY_CONVERT(text, CAST(5 AS int), 8));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p70 as (SELECT TRY_CONVERT(text, CAST(5 AS int), 8));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f70()
RETURNS varchar AS
BEGIN
RETURN (SELECT TRY_CONVERT(text, CAST(5 AS int), 8));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v71 as (SELECT TRY_CONVERT(text, CAST(5 AS numeric), 8));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p71 as (SELECT TRY_CONVERT(text, CAST(5 AS numeric), 8));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f71()
RETURNS varchar AS
BEGIN
RETURN (SELECT TRY_CONVERT(text, CAST(5 AS numeric), 8));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v72 as (SELECT TRY_CONVERT(text, CAST(5.0 AS decimal), 8));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p72 as (SELECT TRY_CONVERT(text, CAST(5.0 AS decimal), 8));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f72()
RETURNS varchar AS
BEGIN
RETURN (SELECT TRY_CONVERT(text, CAST(5.0 AS decimal), 8));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v73 as (SELECT TRY_CONVERT(text, CAST(1 AS bit), 8));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p73 as (SELECT TRY_CONVERT(text, CAST(1 AS bit), 8));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f73()
RETURNS varchar AS
BEGIN
RETURN (SELECT TRY_CONVERT(text, CAST(1 AS bit), 8));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v74 as (SELECT TRY_CONVERT(text, CAST(1 AS smallmoney), 8));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p74 as (SELECT TRY_CONVERT(text, CAST(1 AS smallmoney), 8));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f74()
RETURNS varchar AS
BEGIN
RETURN (SELECT TRY_CONVERT(text, CAST(1 AS smallmoney), 8));
END
GO

create table test(col varchar(10))
GO
insert into test values ('1'),('2'),('3'),('4')
GO

-- Convert text invalid operations
CREATE VIEW BABEL_3486_vu_prepare_v75 as (SELECT TRY_CONVERT(text, (select * from test), 8));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p75 as (SELECT TRY_CONVERT(text, (select * from test), 8));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f75()
RETURNS varchar AS
BEGIN
RETURN (SELECT TRY_CONVERT(text, (select * from test), 8));
END
GO

-- Convert date valid
CREATE VIEW BABEL_3486_vu_prepare_v76 as (SELECT TRY_CONVERT(date, '2017-08-25'));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p76 as (SELECT TRY_CONVERT(date, '2017-08-25'));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f76()
RETURNS date AS
BEGIN
RETURN (SELECT TRY_CONVERT(date, '2017-08-25'));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v77 as (SELECT TRY_CONVERT(date, '9999-08-25'));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p77 as (SELECT TRY_CONVERT(date, '9999-08-25'));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f77()
RETURNS date AS
BEGIN
RETURN (SELECT TRY_CONVERT(date, '9999-08-25'));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v78 as (SELECT TRY_CONVERT(date, '13:01:59'));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p78 as (SELECT TRY_CONVERT(date, '13:01:59'));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f78()
RETURNS date AS
BEGIN
RETURN (SELECT TRY_CONVERT(date, '13:01:59'));
END
GO

-- Convert date invalid
CREATE VIEW BABEL_3486_vu_prepare_v79 as (SELECT TRY_CONVERT(date, '10000-08-25'));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p79 as (SELECT TRY_CONVERT(date, '10000-08-25'));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f79()
RETURNS date AS
BEGIN
RETURN (SELECT TRY_CONVERT(date, '10000-08-25'));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v80 as (SELECT TRY_CONVERT(date, '5000-082-253'));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p80 as (SELECT TRY_CONVERT(date, '5000-082-253'));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f80()
RETURNS date AS
BEGIN
RETURN (SELECT TRY_CONVERT(date, '5000-082-253'));
END
GO

-- Convert time valid
CREATE VIEW BABEL_3486_vu_prepare_v81 as (SELECT TRY_CONVERT(time, '13:01:59'));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p81 as (SELECT TRY_CONVERT(time, '13:01:59'));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f81()
RETURNS time AS
BEGIN
RETURN (SELECT TRY_CONVERT(time, '13:01:59'));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v82 as (SELECT TRY_CONVERT(time, '00:00:00'));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p82 as (SELECT TRY_CONVERT(time, '00:00:00'));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f82()
RETURNS time AS
BEGIN
RETURN (SELECT TRY_CONVERT(time, '00:00:00'));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v83 as (SELECT TRY_CONVERT(time, '1:1:1'));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p83 as (SELECT TRY_CONVERT(time, '1:1:1'));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f83()
RETURNS time AS
BEGIN
RETURN (SELECT TRY_CONVERT(time, '1:1:1'));
END
GO

-- Convert time invalid
CREATE VIEW BABEL_3486_vu_prepare_v84 as (SELECT TRY_CONVERT(time, '9999-08-25'));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p84 as (SELECT TRY_CONVERT(time, '9999-08-25'));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f84()
RETURNS time AS
BEGIN
RETURN (SELECT TRY_CONVERT(time, '9999-08-25'));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v85 as (SELECT TRY_CONVERT(time, '28:01:59'));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p85 as (SELECT TRY_CONVERT(time, '28:01:59'));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f85()
RETURNS time AS
BEGIN
RETURN (SELECT TRY_CONVERT(time, '28:01:59'));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v86 as (SELECT TRY_CONVERT(time, '::59'));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p86 as (SELECT TRY_CONVERT(time, '::59'));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f86()
RETURNS time AS
BEGIN
RETURN (SELECT TRY_CONVERT(time, '::59'));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v87 as (SELECT TRY_CONVERT(time, '20:013:593'));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p87 as (SELECT TRY_CONVERT(time, '20:013:593'));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f87()
RETURNS time AS
BEGIN
RETURN (SELECT TRY_CONVERT(time, '20:013:593'));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v88 as (SELECT TRY_CONVERT(time, 'abc'));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p88 as (SELECT TRY_CONVERT(time, 'abc'));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f88()
RETURNS time AS
BEGIN
RETURN (SELECT TRY_CONVERT(time, 'abc'));
END
GO

-- Convert smalldatetime valid
CREATE VIEW BABEL_3486_vu_prepare_v89 as (SELECT TRY_CONVERT(smalldatetime, '2017-08-25 13:01:59'));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p89 as (SELECT TRY_CONVERT(smalldatetime, '2017-08-25 13:01:59'));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f89()
RETURNS smalldatetime AS
BEGIN
RETURN (SELECT TRY_CONVERT(smalldatetime, '2017-08-25 13:01:59'));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v90 as (SELECT TRY_CONVERT(smalldatetime, '13:01:59'));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p90 as (SELECT TRY_CONVERT(smalldatetime, '13:01:59'));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f90()
RETURNS smalldatetime AS
BEGIN
RETURN (SELECT TRY_CONVERT(smalldatetime, '13:01:59'));
END
GO

-- Convert smalldatetime invalid
CREATE VIEW BABEL_3486_vu_prepare_v91 as (SELECT TRY_CONVERT(smalldatetime, '2017-08-25 26:01:59'));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p91 as (SELECT TRY_CONVERT(smalldatetime, '2017-08-25 26:01:59'));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f91()
RETURNS smalldatetime AS
BEGIN
RETURN (SELECT TRY_CONVERT(smalldatetime, '2017-08-25 26:01:59'));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v92 as (SELECT TRY_CONVERT(smalldatetime, 'a'));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p92 as (SELECT TRY_CONVERT(smalldatetime, 'a'));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f92()
RETURNS smalldatetime AS
BEGIN
RETURN (SELECT TRY_CONVERT(smalldatetime, 'a'));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v93 as (SELECT TRY_CONVERT(smalldatetime, '1'));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p93 as (SELECT TRY_CONVERT(smalldatetime, '1'));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f93()
RETURNS smalldatetime AS
BEGIN
RETURN (SELECT TRY_CONVERT(smalldatetime, '1'));
END
GO

-- Convert datetime valid
CREATE VIEW BABEL_3486_vu_prepare_v94 as (SELECT TRY_CONVERT(datetime, '2017-08-25 13:01:59'));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p94 as (SELECT TRY_CONVERT(datetime, '2017-08-25 13:01:59'));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f94()
RETURNS datetime AS
BEGIN
RETURN (SELECT TRY_CONVERT(datetime, '2017-08-25 13:01:59'));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v95 as (SELECT TRY_CONVERT(datetime, '13:01:59'));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p95 as (SELECT TRY_CONVERT(datetime, '13:01:59'));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f95()
RETURNS datetime AS
BEGIN
RETURN (SELECT TRY_CONVERT(datetime, '13:01:59'));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v96 as (SELECT TRY_CONVERT(datetime, '1753-01-01 0:01:59'));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p96 as (SELECT TRY_CONVERT(datetime, '1753-01-01 0:01:59'));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f96()
RETURNS datetime AS
BEGIN
RETURN (SELECT TRY_CONVERT(datetime, '1753-01-01 0:01:59'));
END
GO

-- Convert datetime invalid
CREATE VIEW BABEL_3486_vu_prepare_v97 as (SELECT TRY_CONVERT(datetime, 'a'));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p97 as (SELECT TRY_CONVERT(datetime, 'a'));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f97()
RETURNS datetime AS
BEGIN
RETURN (SELECT TRY_CONVERT(datetime, 'a'));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v98 as (SELECT TRY_CONVERT(datetime, '1752-01-01 0:01:59'));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p98 as (SELECT TRY_CONVERT(datetime, '1752-01-01 0:01:59'));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f98()
RETURNS datetime AS
BEGIN
RETURN (SELECT TRY_CONVERT(datetime, '1752-01-01 0:01:59'));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v99 as (SELECT TRY_CONVERT(datetime, '0001-01-01 0:01:59'));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p99 as (SELECT TRY_CONVERT(datetime, '0001-01-01 0:01:59'));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f99()
RETURNS datetime AS
BEGIN
RETURN (SELECT TRY_CONVERT(datetime, '0001-01-01 0:01:59'));
END
GO

-- Convert datetime2 valid
CREATE VIEW BABEL_3486_vu_prepare_v100 as (SELECT TRY_CONVERT(datetime2(5), '2017-08-25 13:01:59.1234567'));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p100 as (SELECT TRY_CONVERT(datetime2(5), '2017-08-25 13:01:59.1234567'));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f100()
RETURNS DATETIME2 AS
BEGIN
RETURN (SELECT TRY_CONVERT(datetime2(5), '2017-08-25 13:01:59.1234567'));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v101 as (SELECT TRY_CONVERT(datetime2(1), CAST('2017-08-25 13:01:59' AS datetime)));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p101 as (SELECT TRY_CONVERT(datetime2(1), CAST('2017-08-25 13:01:59' AS datetime)));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f101()
RETURNS DATETIME2 AS
BEGIN
RETURN (SELECT TRY_CONVERT(datetime2(1), CAST('2017-08-25 13:01:59' AS datetime)));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v102 as (SELECT TRY_CONVERT(datetime2, '2017-08-25 13:01:59.1234567'));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p102 as (SELECT TRY_CONVERT(datetime2, '2017-08-25 13:01:59.1234567'));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f102()
RETURNS DATETIME2 AS
BEGIN
RETURN (SELECT TRY_CONVERT(datetime2, '13:01:59'));
END
GO

CREATE PROCEDURE BABEL_3486_vu_prepare_p102_2 as (SELECT TRY_CONVERT(datetime2(10), '2017-08-25 13:01:59.1234567'));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f102_2()
RETURNS DATETIME2 AS
BEGIN
RETURN (SELECT TRY_CONVERT(datetime2(10), '2017-08-25 13:01:59.1234567'));
END
GO

-- Convert datetime2 invalid
CREATE VIEW BABEL_3486_vu_prepare_v103 as (SELECT TRY_CONVERT(datetime2, 'a'));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p103 as (SELECT TRY_CONVERT(datetime2, 'a'));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f103()
RETURNS DATETIME2 AS
BEGIN
RETURN (SELECT TRY_CONVERT(datetime2, 'a'));
END
GO

-- Convert datetimeoffset valid
CREATE VIEW BABEL_3486_vu_prepare_v104 as (SELECT TRY_CONVERT(datetimeoffset, '2017-08-25 13:01:59 +12:15'));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p104 as (SELECT TRY_CONVERT(datetimeoffset, '2017-08-25 13:01:59 +12:15'));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f104()
RETURNS datetimeoffset AS
BEGIN
RETURN (SELECT TRY_CONVERT(datetimeoffset, '2017-08-25 13:01:59 +12:15'));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v105 as (SELECT TRY_CONVERT(datetimeoffset, '13:01:59 +12:15'));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p105 as (SELECT TRY_CONVERT(datetimeoffset, '13:01:59 +12:15'));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f105()
RETURNS datetimeoffset AS
BEGIN
RETURN (SELECT TRY_CONVERT(datetimeoffset, '13:01:59 +12:15'));
END
GO

-- Convert datetimeoffset invalid
CREATE VIEW BABEL_3486_vu_prepare_v106 as (SELECT TRY_CONVERT(datetimeoffset, '13:01:59 +25'));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p106 as (SELECT TRY_CONVERT(datetimeoffset, '13:01:59 +25'));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f106()
RETURNS datetimeoffset AS
BEGIN
RETURN (SELECT TRY_CONVERT(datetimeoffset, '13:01:59 +25'));
END
GO

-- Convert sql_variant valid
CREATE VIEW BABEL_3486_vu_prepare_v107 as (SELECT TRY_CONVERT(sql_variant, 1));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p107 as (SELECT TRY_CONVERT(sql_variant, 1));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f107()
RETURNS sql_variant AS
BEGIN
RETURN (SELECT TRY_CONVERT(sql_variant, 1));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v108 as (SELECT TRY_CONVERT(sql_variant, 'test'));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p108 as (SELECT TRY_CONVERT(sql_variant, 'test'));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f108()
RETURNS sql_variant AS
BEGIN
RETURN (SELECT TRY_CONVERT(sql_variant, 'test'));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v109 as (SELECT TRY_CONVERT(sql_variant, CAST(1 as MONEY)));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p109 as (SELECT TRY_CONVERT(sql_variant, CAST(1 as MONEY)));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f109()
RETURNS sql_variant AS
BEGIN
RETURN (SELECT TRY_CONVERT(sql_variant, CAST(1 as MONEY)));
END
GO

-- This test case returns 2017-08-25 13:01:59.0 where SQL Server JDBC returns 2017-08-25 13:01:59
CREATE VIEW BABEL_3486_vu_prepare_v110 as (SELECT TRY_CONVERT(sql_variant, CAST('2017-08-25 13:01:59' AS datetime)));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p110 as (SELECT TRY_CONVERT(sql_variant, CAST('2017-08-25 13:01:59' AS datetime)));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f110()
RETURNS sql_variant AS
BEGIN
RETURN (SELECT TRY_CONVERT(sql_variant, CAST('2017-08-25 13:01:59' AS datetime)));
END
GO

-- Results in error due to outdated JDBC version
-- Change when BABEL-2871 is resolved
CREATE VIEW BABEL_3486_vu_prepare_v111 as (SELECT TRY_CONVERT(sql_variant, CAST('2017-08-25 13:01:59 +12:15' AS datetimeoffset)));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p111 as (SELECT TRY_CONVERT(sql_variant, CAST('2017-08-25 13:01:59 +12:15' AS datetimeoffset)));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f111()
RETURNS sql_variant AS
BEGIN
RETURN (SELECT TRY_CONVERT(sql_variant, CAST('2017-08-25 13:01:59 +12:15' AS datetimeoffset)));
END
GO

-- Convert sql_variant invalid

CREATE VIEW BABEL_3486_vu_prepare_v113 as (SELECT TRY_CONVERT(sql_variant, CAST('test' AS text)));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p113 as (SELECT TRY_CONVERT(sql_variant, CAST('test' AS text)));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f113()
RETURNS sql_variant AS
BEGIN
RETURN (SELECT TRY_CONVERT(sql_variant, CAST('test' AS text)));
END
GO

-- Valid uniqueidentifier
CREATE VIEW BABEL_3486_vu_prepare_v114 as (SELECT TRY_CONVERT(uniqueidentifier, '6F9619FF-8B86-D011-B42D-00C04FC964FF'));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p114 as (SELECT TRY_CONVERT(uniqueidentifier, '6F9619FF-8B86-D011-B42D-00C04FC964FF'));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f114()
RETURNS sql_variant AS
BEGIN
RETURN (SELECT TRY_CONVERT(uniqueidentifier, '6F9619FF-8B86-D011-B42D-00C04FC964FF'));
END
GO

-- Invalid uniqueidentifier
CREATE VIEW BABEL_3486_vu_prepare_v116 as (SELECT TRY_CONVERT(uniqueidentifier, 'unique'));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p116 as (SELECT TRY_CONVERT(uniqueidentifier, 'unique'));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f116()
RETURNS sql_variant AS
BEGIN
RETURN (SELECT TRY_CONVERT(uniqueidentifier, 'unique'));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v117 as (SELECT TRY_CAST(TRY_CAST (TRY_CONVERT(XML, '1990-01-01') as text) as date));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p117 as (SELECT TRY_CAST(TRY_CAST (TRY_CONVERT(XML, '1990-01-01') as text) as date));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f117()
RETURNS DATE AS
BEGIN
RETURN (SELECT TRY_CAST(TRY_CAST (TRY_CONVERT(XML, '1990-01-01') as text) as date));
END
GO

CREATE VIEW BABEL_3486_vu_prepare_v118 as (SELECT TRY_CAST(TRY_CONVERT(DATETIME, CAST('1990-01-01' AS DATE)) AS TIME));
GO
CREATE PROCEDURE BABEL_3486_vu_prepare_p118 as (SELECT TRY_CAST(TRY_CONVERT(DATETIME, CAST('1990-01-01' AS DATE)) AS TIME));
GO
CREATE FUNCTION BABEL_3486_vu_prepare_f118()
RETURNS TIME AS
BEGIN
RETURN (SELECT TRY_CAST(TRY_CONVERT(DATETIME, CAST('1990-01-01' AS DATE)) AS TIME));
END
GO
