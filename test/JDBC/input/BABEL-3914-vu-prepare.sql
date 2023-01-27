--Degrees Test
CREATE VIEW BABEL_3914_vu_prepare_t_1 AS (SELECT degrees(CAST(92233720.36854775807 AS NUMERIC)));
GO

CREATE VIEW BABEL_3914_vu_prepare_t_2 AS (SELECT degrees(CAST(25555.788 AS NUMERIC)));
GO

CREATE PROCEDURE BABEL_3914_vu_prepare_t_p1 AS (SELECT degrees(CAST(992233720.36854775807 AS NUMERIC)));
GO

CREATE PROCEDURE BABEL_3914_vu_prepare_t_p2 AS (SELECT degrees(CAST(5555.788 AS NUMERIC)));
GO


CREATE VIEW BABEL_3914_vu_prepare_t_v1 AS (
	SELECT
		degrees(CAST(-92233720368547750 AS NUMERIC)) AS res1,
		degrees(CAST(92233720368547749 AS NUMERIC)) AS res2,
		degrees(CAST(NULL AS NUMERIC)) AS res3,
		degrees(CAST(8969.32 AS NUMERIC)) AS res4
	);
GO

CREATE VIEW BABEL_3914_vu_prepare_t_v2 AS (
	SELECT
		degrees(CAST(-21474836 AS NUMERIC)) AS res1,
		degrees(CAST(21474835 AS NUMERIC)) AS res2
	);
GO

CREATE VIEW BABEL_3914_vu_prepare_t_v3 AS (
	SELECT
		degrees(CAST(-32768 AS NUMERIC)) AS res1,
		degrees(CAST(32767 AS NUMERIC)) AS res2
	);
GO

CREATE VIEW BABEL_3914_vu_prepare_t_v4 AS (
	SELECT
		degrees(CAST(0 AS NUMERIC)) AS res1,
		degrees(CAST(255 AS NUMERIC)) AS res2
	);
GO


CREATE PROCEDURE BABEL_3914_vu_prepare_t_p3 AS (
	SELECT
		degrees(CAST(-92233720368547750 AS NUMERIC)),
		degrees(CAST(92233720368547749 AS NUMERIC)),
		degrees(CAST(NULL AS NUMERIC)),
		degrees(CAST(8969.32 AS NUMERIC))
	);
GO

CREATE PROCEDURE BABEL_3914_vu_prepare_t_p4 AS (
	SELECT
		degrees(CAST(-21474836 AS NUMERIC)),
		degrees(CAST(21474835 AS NUMERIC))
	);
GO

CREATE PROCEDURE BABEL_3914_vu_prepare_t_p5 AS (
	SELECT
		degrees(CAST(-32768 AS NUMERIC)),
		degrees(CAST(32767 AS NUMERIC))
	);
GO

CREATE PROCEDURE BABEL_3914_vu_prepare_t_p6 AS (
	SELECT
		degrees(CAST(0 AS NUMERIC)),
		degrees(CAST(255 AS NUMERIC)),
		degrees(CAST(100.32 AS NUMERIC))
	);
GO


---Radians Test
CREATE VIEW BABEL_3914_vu_prepare_t_3 AS (SELECT radians(CAST(92233720.36854775807 AS NUMERIC)));
GO

CREATE VIEW BABEL_3914_vu_prepare_t_4 AS (SELECT radians(CAST(25555.788 AS NUMERIC)));
GO

CREATE PROCEDURE BABEL_3914_vu_prepare_t_p7 AS (SELECT radians(CAST(992233720.36854775807 AS NUMERIC)));
GO

CREATE PROCEDURE BABEL_3914_vu_prepare_t_p8 AS (SELECT radians(CAST(5555.788 AS NUMERIC)));
GO

CREATE VIEW BABEL_3914_vu_prepare_t_v5 AS (
	SELECT
		radians(CAST(-92233720368547750 AS NUMERIC)) AS res1,
		radians(CAST(92233720368547749 AS NUMERIC)) AS res2,
		radians(CAST(NULL AS NUMERIC)) AS res3,
		radians(CAST(8969.32 AS NUMERIC)) AS res4
	);
GO

CREATE VIEW BABEL_3914_vu_prepare_t_v6 AS (
	SELECT
		radians(CAST(-21474836 AS NUMERIC)) AS res1,
		radians(CAST(21474835 AS NUMERIC)) AS res2
	);
GO

CREATE VIEW BABEL_3914_vu_prepare_t_v7 AS (
	SELECT
		radians(CAST(-32768 AS NUMERIC)) AS res1,
		radians(CAST(32767 AS NUMERIC)) AS res2
	);
GO

CREATE VIEW BABEL_3914_vu_prepare_t_v8 AS (
	SELECT
		radians(CAST(0 AS NUMERIC)) AS res1,
		radians(CAST(255 AS NUMERIC)) AS res2
	);
GO


CREATE PROCEDURE BABEL_3914_vu_prepare_t_p9 AS (
	SELECT
		radians(CAST(-92233720368547750 AS NUMERIC)),
		radians(CAST(92233720368547749 AS NUMERIC)),
		radians(CAST(NULL AS NUMERIC)),
		radians(CAST(8969.32 AS NUMERIC))
	);
GO

CREATE PROCEDURE BABEL_3914_vu_prepare_t_p10 AS (
	SELECT
		radians(CAST(-21474836 AS NUMERIC)),
		radians(CAST(21474835 AS NUMERIC))
	);
GO

CREATE PROCEDURE BABEL_3914_vu_prepare_t_p11 AS (
	SELECT
		radians(CAST(-32768 AS NUMERIC)),
		radians(CAST(32767 AS NUMERIC))
	);
GO

CREATE PROCEDURE BABEL_3914_vu_prepare_t_p12 AS (
	SELECT
		radians(CAST(0 AS NUMERIC)),
		radians(CAST(255 AS NUMERIC)),
		radians(CAST(100.32 AS NUMERIC))
	);
GO