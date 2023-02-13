CREATE TABLE babel_3802_vu_prepare_t_1(
		a int,
		b numeric,
		c bigint,
		d smallint,
		e tinyint,
);
GO
 
INSERT INTO BABEL_3802_vu_prepare_t_1 VALUES (NULL,1, NULL, NULL, NULL);
GO
INSERT INTO BABEL_3802_vu_prepare_t_1 VALUES (2147483647, 1.1, 9223372036854, 32767, 255);
GO
INSERT INTO BABEL_3802_vu_prepare_t_1 VALUES (-2147483648, 1,-9223372036854775808, -32768, 0);
GO
INSERT INTO BABEL_3802_vu_prepare_t_1 VALUES (101.23, 1, 97777.32, 376.466, 120.32);
GO


CREATE PROCEDURE babel_3802_vu_prepare_t_p1 AS (SELECT power(CAST(100 AS SMALLINT),2));
GO


CREATE PROCEDURE babel_3802_vu_prepare_t_p2 AS (
    SELECT
        power(CAST(-32768 AS SMALLINT),1),
        power(CAST(32767 AS SMALLINT),1),
        power(CAST(NULL AS SMALLINT),1),
        power(CAST(8969.32 AS SMALLINT),1),
        power(CAST(8962 AS SMALLINT),1.1),
        power(CAST(8962 AS SMALLINT),1.2)
    );
GO
 
CREATE PROCEDURE babel_3802_vu_prepare_t_p3 AS (
    SELECT
        power(CAST(0 AS TINYINT),1),
        power(CAST(255 AS TINYINT),1),
        power(CAST(NULL AS TINYINT),1),
        power(CAST(100.32 AS TINYINT),1),
        power(CAST(100 AS TINYINT),1.1),
        power(CAST(100 AS TINYINT),1.2)
    );
GO


CREATE VIEW babel_3802_vu_prepare_t_v1 AS (
    SELECT
        power(CAST(-32768 AS SMALLINT),1) AS res1,
        power(CAST(32767 AS SMALLINT),1) AS res2,
        power(CAST(NULL AS SMALLINT),1) AS res3,
        power(CAST(899.32 AS SMALLINT),1) AS res4,
        power(CAST(8962 AS SMALLINT),1.1) AS res5,
        power(CAST(896 AS SMALLINT),1.2) AS res6
    );
GO
 
CREATE VIEW babel_3802_vu_prepare_t_v2 AS (
    SELECT
        power(CAST(0 AS TINYINT),1) AS res1,
        power(CAST(255 AS TINYINT),1) AS res2,
        power(CAST(NULL AS TINYINT),1) AS res3,
        power(CAST(89.32 AS TINYINT),1) AS res4,
        power(CAST(100 AS TINYINT),1.1) AS res5,
        power(CAST(100 AS TINYINT),1.2) AS res6
    );
GO