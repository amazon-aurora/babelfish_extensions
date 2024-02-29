CREATE TABLE upper_lower_dt (a VARCHAR(20), b NVARCHAR(24), c CHAR(20), d NCHAR(24))
GO
INSERT INTO upper_lower_dt(a,b,c,d) values(UPPER('Anikait '), LOWER('Agrawal '), LOWER('Anikait '), UPPER('Agrawal '))
GO
INSERT INTO upper_lower_dt(a,b,c,d) values(UPPER(' Anikait'), LOWER(' Agrawal'), LOWER(' Anikait'), UPPER(' Agrawal'))
GO
INSERT INTO upper_lower_dt(a,b,c,d) values(UPPER('   A'),LOWER(N'   🤣😃'),LOWER('   A'),UPPER(N'   🤣😃'))
GO
INSERT INTO upper_lower_dt(a,b,c,d) values(LOWER(' '),UPPER(' '),UPPER(' '),LOWER(' '))
GO
INSERT INTO upper_lower_dt(a,b,c,d) values(LOWER(' '),UPPER(N'😊😋😎😍😅😆'),UPPER(' '),LOWER(N'😊😋😎😍😅😆'))
GO
INSERT INTO upper_lower_dt(a,b,c,d) values(LOWER(''),UPPER(''),UPPER(''),LOWER(''))
GO
INSERT INTO upper_lower_dt(a,b,c,d) values(UPPER('a'),LOWER('A'),UPPER('a'),LOWER('A'))
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
select UPPER(a) AS upper_a, UPPER(b) AS upper_b, UPPER(c) AS upper_c, UPPER(d) AS upper_d, UPPER(NULL) AS upper_n from upper_lower_dt;
GO

CREATE PROC dep_proc_upper AS
select UPPER(a), UPPER(b), UPPER(c), UPPER(d), UPPER(NULL) from upper_lower_dt;
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
select UPPER(a) AS lower_a, UPPER(b) AS lower_b, UPPER(c) AS lower_c, UPPER(d) AS lower_d, UPPER(NULL) AS lower_n from upper_lower_dt;
GO

CREATE PROC dep_proc_lower AS
select LOWER(a), LOWER(b), LOWER(c), LOWER(d), LOWER(NULL) from upper_lower_dt;
GO

CREATE FUNCTION dbo.dep_func_lower()
RETURNS VARCHAR
AS
BEGIN
RETURN (select TOP 1 LOWER(a) from upper_lower_dt);
END
GO
