use master
go

create table dbo.unionorder1 (c1 int );
create table dbo.unionorder2 (c2 int );
create table dbo.unionorder1b (c1 int );
go

insert into unionorder1 VALUES (1), (2), (3);
insert into unionorder2 VALUES (2), (3), (4);
insert into unionorder1b VALUES (2), (3), (4);
go

SELECT u.c1 FROM unionorder1 u
UNION
SELECT u.c1 FROM unionorder1 u
ORDER BY u.c1;
go

SELECT c1 FROM unionorder1
UNION
SELECT c2 FROM unionorder2
ORDER BY unionorder1.c1;
go

SELECT c1 FROM unionorder1
intersect
SELECT c2 FROM unionorder2
ORDER BY unionorder1.c1;
go

SELECT u.c1 FROM unionorder1 u
intersect
SELECT c2 FROM unionorder2
ORDER BY u.c1;
go

SELECT c1 FROM unionorder1
except
SELECT c2 FROM unionorder2
ORDER BY unionorder1.c1;
go

SELECT c1 FROM unionorder1 u
except
SELECT c2 FROM unionorder2
ORDER BY u.c1;
go

SELECT c1 FROM dbo.unionorder1
UNION
SELECT c2 FROM dbo.unionorder2
ORDER BY dbo.unionorder1.c1;
go

SELECT c1 FROM master.dbo.unionorder1
UNION
SELECT c1 FROM master.dbo.unionorder1
ORDER BY master.dbo.unionorder1.c1;
go

SELECT c1 FROM dbo.unionorder1
UNION
SELECT c2 FROM dbo.unionorder2
ORDER BY dbo.unionorder2.c2;
go

SELECT u.* FROM unionorder1 u
UNION
SELECT u.*  FROM unionorder1 u
ORDER BY u.c1
go

SELECT u1.c1, u2.c2 FROM unionorder1 u1, unionorder2 u2 where u1.c1 = u2.c2
UNION
SELECT u1.c1, u2.c2 FROM unionorder1 u1, unionorder2 u2 where u1.c1 = u2.c2
ORDER BY u2.c2
go

select u.c2 from unionorder1 JOIN unionorder2 u on u.c2 = unionorder1.c1
union
select u.c1 from unionorder1 u
ORDER BY u.c2
go

SELECT unionorder1.c1 FROM unionorder1, unionorder1b WHERE unionorder1.c1 = unionorder1b.c1
union
SELECT u.c1 FROM unionorder1 u
ORDER BY unionorder1.c1
go

SELECT * FROM unionorder1, unionorder1b WHERE unionorder1.c1 = unionorder1b.c1
union
SELECT u.c1, u.c1 FROM unionorder1 u
ORDER BY unionorder1.c1
go

SELECT * FROM unionorder1 u1, unionorder1b u2 WHERE u1.c1 = u2.c1
union
SELECT u.c1, u.c1 FROM unionorder1 u
ORDER BY u1.c1
go

SELECT u1.c1 FROM unionorder1 u1
UNION 
SELECT c2 FROM unionorder2
WHERE c2 IN (
    SELECT TOP 5 c2 FROM unionorder2
    UNION
    SELECT TOP 5 c1 FROM unionorder1
    WHERE c1 IN (
        SELECT TOP 5 c1 FROM unionorder1
        UNION
        SELECT TOP 5 c2 FROM unionorder2
        ORDER BY unionorder1.c1
    )
    ORDER BY unionorder2.c2
)
ORDER BY u1.c1;
go

SELECT u1.c1, (SELECT TOP 1 c2 FROM unionorder2) AS col2
FROM unionorder1 u1
UNION 
SELECT c2, c2 FROM unionorder2
WHERE c2 IN (
    SELECT TOP 5 c2 FROM unionorder2
    UNION
    SELECT TOP 5 c1 FROM unionorder1
    ORDER BY unionorder2.c2
)
ORDER BY col2;
go

SELECT c1 FROM unionorder1
WHERE c1 IN (
    SELECT TOP 5 c2 FROM unionorder2
    UNION
    SELECT TOP 5 c1 FROM unionorder1
    ORDER BY unionorder2.c2
)
UNION 
SELECT c2 FROM unionorder2
ORDER BY unionorder1.c1;
go

SELECT c1 FROM unionorder1
WHERE c1 IN (
    SELECT TOP 5 c2 FROM unionorder2
    UNION
    SELECT TOP 5 c1 FROM unionorder1
    ORDER BY unionorder2.c2
)
UNION 
SELECT c2 FROM unionorder2
ORDER BY unionorder2.c2;
go

SELECT c2 FROM (
    SELECT TOP 5 c2 FROM unionorder2
    UNION
    SELECT TOP 5 c1 FROM unionorder1
    ORDER BY unionorder2.c2
) u
UNION 
SELECT c1 FROM unionorder1
ORDER BY u.c2;
go

-- Test babel_613 UNION ALL with numeric issue
create table dbo.t1 (a numeric(6,4), b numeric(6,3));
insert into t1 values (4, 16);
insert into t1 values (NULL, 101.123);
go

SELECT t.a, t.b FROM t1 t
UNION ALL
SELECT t.a, t.b FROM t1 t
ORDER BY t.b;
go

drop table dbo.t1
drop table dbo.unionorder1;
drop table dbo.unionorder2;
go
