SELECT CAST('1' AS CHAR(10)) AS Col1
UNION
SELECT NULL AS Col1
ORDER BY 1
GO

SELECT NULL AS Col1
UNION
SELECT CAST('1' AS CHAR(10)) AS Col1
ORDER BY 1
GO

SELECT CAST('1' AS NCHAR(10)) AS Col1
UNION
SELECT NULL AS Col1
ORDER BY 1
GO

SELECT NULL AS Col1
UNION
SELECT CAST('1' AS NCHAR(10)) AS Col1
ORDER BY 1
GO

SELECT CAST(1 AS BINARY(10)) AS Col1
UNION
SELECT NULL AS Col1
ORDER BY 1
GO

SELECT NULL AS Col1
UNION
SELECT CAST(1 AS BINARY(10)) AS Col1
ORDER BY 1
GO

SELECT CAST(1 AS CHAR(1)) AS Col1
UNION
SELECT NULL AS Col1
ORDER BY 1
GO

SELECT CAST('1' AS CHAR(255)) AS Col1
UNION
SELECT NULL AS Col1
ORDER BY 1
GO

SELECT CAST('1' AS CHAR(15)) AS Col1
UNION
SELECT CAST('2' AS CHAR(10)) AS Col1
ORDER BY 1
GO

SELECT CAST('1' AS CHAR(10)) AS Col1
UNION
SELECT CAST('2' AS CHAR(15)) AS Col1
ORDER BY 1
GO

SELECT CAST('1' AS NCHAR(15)) AS Col1
UNION
SELECT CAST('2' AS NCHAR(10)) AS Col1
ORDER BY 1
GO

SELECT CAST('1' AS NCHAR(10)) AS Col1
UNION
SELECT CAST('2' AS NCHAR(15)) AS Col1
ORDER BY 1
GO

SELECT CAST(N'ΘЖऌฒ' AS NCHAR(10)) AS Col1
UNION
SELECT NULL AS Col1
ORDER BY 1
GO

SELECT NULL AS Col1
UNION
SELECT CAST(N'ΘЖऌฒ' AS NCHAR(10)) AS Col1
ORDER BY 1
GO

SELECT CAST(1 AS BINARY(4)) AS Col1
UNION
SELECT CAST(2 AS BINARY(8)) AS Col1
ORDER BY 1
GO

SELECT CAST(1 AS BINARY(4)) AS Col1
UNION
SELECT CAST(2 AS BINARY(8)) AS Col1
ORDER BY 1
GO

SELECT CAST('1' AS CHAR(4)) AS Col1
UNION
SELECT CAST(N'ΘЖऌฒ' AS NCHAR(8)) AS Col1
ORDER BY 1
GO

SELECT CAST(N'ΘЖऌฒ' AS NCHAR(8)) AS Col1
UNION
SELECT CAST('1' AS CHAR(4)) AS Col1
ORDER BY 1
GO

SELECT CAST('1' AS CHAR(4))
INTERSECT
SELECT CAST('1' AS CHAR(8))
ORDER BY 1
GO

SELECT CAST('1' AS CHAR(8))
INTERSECT
SELECT CAST('1' AS CHAR(4))
ORDER BY 1
GO

SELECT CAST('1' AS CHAR(4))
EXCEPT
SELECT CAST('1' AS CHAR(8))
ORDER BY 1
GO

SELECT CAST('1' AS CHAR(8))
EXCEPT
SELECT CAST('1' AS CHAR(4))
ORDER BY 1
GO

-- Multiple Unions --
SELECT CAST('1' AS CHAR(8))
UNION 
SELECT NULL
UNION
SELECT NULL
ORDER BY 1
GO

SELECT NULL
UNION 
SELECT CAST('1' AS CHAR(8))
UNION
SELECT NULL
ORDER BY 1
GO

SELECT NULL
UNION
SELECT NULL
GO

SELECT NULL
UNION ALL
SELECT NULL
GO

SELECT NULL
UNION 
SELECT NULL
UNION
SELECT CAST('1' AS CHAR(8))
ORDER BY 1
GO

SELECT NULL
UNION 
SELECT NULL
UNION
SELECT CAST(N'ΘЖऌฒ' AS NCHAR(8))
ORDER BY 1
GO

SELECT CAST('2' AS CHAR(16))
UNION 
SELECT CAST('1' AS CHAR(8))
UNION
SELECT NULL
ORDER BY 1
GO

SELECT CAST('2' AS CHAR(16))
UNION 
SELECT CAST('1' AS NCHAR(8))
UNION
SELECT NULL
ORDER BY 1
GO

SELECT CAST('2' AS NCHAR(16))
UNION 
SELECT CAST('1' AS NCHAR(8))
UNION
SELECT NULL
ORDER BY 1
GO

SELECT CAST('2' AS NCHAR(16))
UNION ALL
SELECT CAST('1' AS NCHAR(8))
UNION ALL
SELECT NULL
ORDER BY 1
GO

SELECT NULL
UNION ALL
SELECT NULL
UNION ALL
SELECT CAST(N'ΘЖऌฒ' AS NCHAR(15))
ORDER BY 1
GO

SELECT CAST('1' AS NCHAR(16))
INTERSECT 
SELECT CAST('1' AS NCHAR(8))
INTERSECT
SELECT CAST('1' AS NCHAR(4))
ORDER BY 1
GO

SELECT CAST('1' AS NCHAR(16))
INTERSECT 
SELECT CAST('2' AS NCHAR(8))
INTERSECT
SELECT CAST('1' AS NCHAR(4))
ORDER BY 1
GO

SELECT NULL
INTERSECT 
SELECT NULL
INTERSECT
SELECT CAST(N'ΘЖऌฒ' AS NCHAR(15))
ORDER BY 1
GO

CREATE TABLE babel3392_nchar_tbl(a NCHAR(20))
GO

INSERT INTO babel3392_nchar_tbl (a)
    SELECT CAST(N'ΘЖऌฒ' AS NCHAR(10)) AS Col1
    UNION
    SELECT NULL AS Col1
    ORDER BY 1
GO

DROP TABLE babel3392_nchar_tbl
GO

-- Should error
WITH babel3392_recursive_cte(a)
AS (
    SELECT NULL
    UNION ALL
    SELECT CAST(a + 'a' AS CHAR(10)) from babel3392_recursive_cte where a != 'aaaaa'
)
SELECT a from babel3392_recursive_cte order by a
GO

WITH babel3392_recursive_cte(a)
AS (
    SELECT 'a'
    UNION ALL
    SELECT CAST(a + 'a' AS CHAR(10)) from babel3392_recursive_cte where a != 'aaaaa'
)
SELECT a from babel3392_recursive_cte order by a
GO

-- CASE
CREATE TABLE babel3392_case(a INT)
GO

INSERT INTO babel3392_case (a) VALUES (1), (2), (3)
GO

SELECT CASE a
    WHEN 1 THEN NULL
    WHEN 2 THEN CAST('char' AS CHAR(10))
END
FROM babel3392_case
GO

DROP TABLE babel3392_case;
GO

-- COALESCE / ISNULL
SELECT ISNULL(null, cast(N'ΘЖऌฒ' as NCHAR(15)))
GO

-- BABEL-1874
SELECT NULL
GO

SELECT DISTINCT NULL
GO

SELECT CAST( 1 AS BIT) AS Col1
UNION 
SELECT DISTINCT NULL AS Col1
ORDER BY 1
GO

-- BABEL-4157
SELECT tbl.babel4157_c1 INTO babel4157_tbl FROM (
    SELECT 'string' AS babel4157_c1 
    UNION
    SELECT CAST('varchar' AS VARCHAR(40)) AS babel4157_c1
) AS tbl
GO

SELECT name, max_length FROM sys.columns WHERE name = 'babel4157_c1'
GO

DROP TABLE babel4157_tbl
GO

-- VALUES
select tbl.babel3392_c1 into babel3392_vals from (
    values (CAST('1' AS CHAR(10))), (CAST(N'ΘЖऌฒ' AS NCHAR(15))), (NULL)
) as tbl(babel3392_c1)
GO

SELECT * FROM babel3392_vals;
GO

SELECT name, max_length FROM sys.columns WHERE name = 'babel3392_c1'
GO

DROP TABLE babel3392_vals;
GO

-- GREATEST / LEAST
SELECT GREATEST(CAST('1' AS CHAR(20)), CAST(N'A' AS NCHAR(10)), NULL)
GO

SELECT LEAST(CAST('1' AS CHAR(20)), CAST(N'A' AS NCHAR(10)), NULL)
GO

-- Hypothetical-Set Aggregations
SELECT RANK(CAST('E' AS CHAR(10)), NULL) WITHIN GROUP (ORDER BY c1, c2)
FROM (
    values ((NULL, CAST(N'ΘЖऌฒ' as NCHAR(15))), (CAST(N'A' AS NCHAR(15)), CAST(N'A' AS NCHAR(15))))
) AS s(c1, c2);
GO

-- Arrays
SELECT '{CAST('A' AS NCHAR(15)), CAST('B' AS CHAR(10)), NULL}'
GO

