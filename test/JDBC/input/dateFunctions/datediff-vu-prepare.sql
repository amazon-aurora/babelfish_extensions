-- 123
CREATE PROCEDURE datediff_p1 as (select datediff(year, cast('1900-01-01' as datetime), cast('2023-01-02' as datetime)));
GO

-- -30
CREATE PROCEDURE datediff_p2 as (select datediff(year, cast('2020-01-01' as datetime), cast('1990-01-02' as datetime)));
GO

-- -120
CREATE PROCEDURE datediff_p3 as (select datediff(quarter, cast('2020-01-01' as datetime), cast('1990-01-02' as datetime)));
GO

-- 24
CREATE PROCEDURE datediff_p4 as (select datediff(month, cast('2020-01-01' as datetime), cast('2022-01-02' as datetime)));
GO

-- 105
CREATE PROCEDURE datediff_p5 as (select datediff(week, cast('2020-01-01' as datetime2), cast('2022-01-02' as datetime2)));
GO

-- -10957
CREATE PROCEDURE datediff_p6 as (select datediff(day, cast('2020-01-01' as smalldatetime), cast('1990-01-01' as smalldatetime)));
GO

-- -262963
CREATE PROCEDURE datediff_p7 as (select datediff(hour, cast('2020-01-01 01:01:20.99' as smalldatetime), cast('1990-01-01 06:01:20.99' as smalldatetime)));
GO
-- -15777780
CREATE PROCEDURE datediff_p8 as (select datediff(minute, cast('2020-01-01 01:01:20.99' as datetime), cast('1990-01-01 06:01:20.99' as smalldatetime)));
GO

-- 157885200
CREATE PROCEDURE datediff_p9 as (select datediff(second, cast('2000-01-01 01:01:20.99' as datetime), cast('2005-01-01 10:01:20.99' as datetime)));
GO

-- 32400000
CREATE PROCEDURE datediff_p10 as (select datediff(millisecond, cast('2005-01-01 01:01:20.99' as datetime), cast('2005-01-01 10:01:20.99' as datetime)));
GO

-- 1200000000
CREATE PROCEDURE datediff_p11 as (select datediff(microsecond, cast('2005-01-01 01:01:20.99' as datetime), cast('2005-01-01 1:21:20.99' as datetime)));
GO

-- overflow
CREATE PROCEDURE datediff_p12 as (select datediff(nanosecond, cast('2005-01-01 01:01:20.99' as datetime), cast('2005-01-01 1:21:20.99' as datetime)));
GO

-- 1200000000000
CREATE PROCEDURE datediff_p13 as (select datediff_big(nanosecond, cast('2005-01-01 01:01:20.99' as datetime), cast('2005-01-01 1:21:20.99' as datetime)));
GO

-- 15
CREATE PROCEDURE datediff_p14 as (select datediff(hour, cast('2020-01-01 01:01:20.99 +10:00' as datetimeoffset), cast('2020-01-01 06:01:20.99' as datetimeoffset)));
GO

CREATE PROCEDURE datediff_p15 as (select datediff(dayofyear, cast('2020-01-01 01:01:20.99 +10:00' as datetimeoffset), cast('2023-01-01 06:01:20.99' as datetimeoffset)));

