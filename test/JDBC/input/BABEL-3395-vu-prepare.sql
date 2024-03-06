CREATE TABLE upper_lower_dt (a VARCHAR(20), b NVARCHAR(24), c CHAR(20), d NCHAR(24))
GO
INSERT INTO upper_lower_dt(a,b,c,d) values(UPPER(N'Anikait '), LOWER(N'Agrawal '), LOWER(N'Anikait '), UPPER(N'Agrawal '))
GO
INSERT INTO upper_lower_dt(a,b,c,d) values(UPPER(N' Anikait'), LOWER(N' Agrawal'), LOWER(N' Anikait'), UPPER(N' Agrawal'))
GO
INSERT INTO upper_lower_dt(a,b,c,d) values(UPPER(N'   A'),LOWER(N'   🤣😃'),LOWER(N'   A'),UPPER(N'   🤣😃'))
GO
INSERT INTO upper_lower_dt(a,b,c,d) values(LOWER(N' '),UPPER(N' '),UPPER(N' '),LOWER(N' '))
GO
INSERT INTO upper_lower_dt(a,b,c,d) values(LOWER(N' '),UPPER(N'😊😋😎😍😅😆'),UPPER(N' '),LOWER(N'😊😋😎😍😅😆'))
GO
INSERT INTO upper_lower_dt(a,b,c,d) values(LOWER(N''),UPPER(N''),UPPER(N''),LOWER(N''))
GO
INSERT INTO upper_lower_dt(a,b,c,d) values(UPPER(N'a'),LOWER(N'A'),UPPER(N'a'),LOWER(N'A'))
GO
INSERT INTO upper_lower_dt(a,b,c,d) values(UPPER(NULL),LOWER(NULL),UPPER(NULL),LOWER(NULL))
GO
INSERT INTO upper_lower_dt(a, b, c, d) values(UPPER(N'比尔·拉'), LOWER(N'比尔·拉'), LOWER(N'比尔·拉'), UPPER(N'比尔·拉'))
GO

CREATE TABLE upper_lower_text(a TEXT)
GO
INSERT INTO upper_lower_text values(CAST ('6F9619FF-8B86-D011-B42D-00C04FC964FF' AS text))
GO

CREATE TABLE upper_lower_ntext(a NTEXT)
GO
INSERT INTO upper_lower_ntext values(CAST ('6F9619FF-8B86-D011-B42D-00C04FC964FF' AS ntext))
GO

CREATE TABLE upper_lower_image(a IMAGE)
GO
INSERT INTO upper_lower_image values(CAST ('6F9619FF-8B86-D011-B42D-00C04FC964FF' AS image))
GO

-- UPPER
CREATE VIEW dep_view_upper AS
select UPPER(CAST (a AS VARCHAR(30))) AS upper_a, UPPER(CAST (b AS NVARCHAR(30))) AS upper_b, UPPER(CAST (c AS CHAR(30))) AS upper_c, UPPER(CAST (d AS NCHAR(30))) AS upper_d from upper_lower_dt WHERE UPPER(CAST (a AS VARCHAR(30))) = N'ANIKAIT' and UPPER(CAST (b AS NVARCHAR(30))) = N'AGRAWAL' and UPPER(CAST (c AS CHAR(30))) = N'ANIKAIT' and UPPER(CAST (d AS NCHAR(30))) = N'AGRAWAL';
GO

CREATE PROC dep_proc_upper AS
select UPPER(a), UPPER(b), UPPER(c), UPPER(d) from upper_lower_dt WHERE UPPER(a) = N'ANIKAIT' and UPPER(b) = N'AGRAWAL' and UPPER(c) = N'ANIKAIT' and UPPER(d) = N'AGRAWAL';
GO

CREATE FUNCTION dbo.dep_func_upper()
RETURNS VARCHAR
AS
BEGIN
RETURN (select TOP 1 UPPER(a) from upper_lower_dt);
END
GO

-- LOWER
CREATE VIEW dep_view_lower AS
select LOWER(CAST (a AS VARCHAR(30))) AS lower_a, LOWER(CAST (b AS NVARCHAR(30))) AS lower_b, LOWER(CAST (c AS CHAR(30))) AS lower_c, LOWER(CAST (d AS NCHAR(30))) AS lower_d from upper_lower_dt WHERE LOWER(CAST (a AS VARCHAR(30))) = N'anikait' and LOWER(CAST (b AS NVARCHAR(30))) = N'agrawal' and LOWER(CAST (c AS CHAR(30))) = N'anikait' and LOWER(CAST (d AS NCHAR(30))) = N'agrawal';
GO

CREATE PROC dep_proc_lower AS
select LOWER(a), LOWER(b), LOWER(c), LOWER(d) from upper_lower_dt WHERE LOWER(a) = N'anikait' and LOWER(b) = N'agrawal' and LOWER(c) = N'anikait' and LOWER(d) = N'agrawal';
GO

CREATE FUNCTION dbo.dep_func_lower()
RETURNS VARCHAR
AS
BEGIN
RETURN (select TOP 1 LOWER(a) from upper_lower_dt);
END
GO

CREATE VIEW dep_view_lower1 AS (
    select 
        lower(cast(N'ADJNFJH' as varchar)) as db1
    );
GO
