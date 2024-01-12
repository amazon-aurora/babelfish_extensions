CREATE TABLE forjson_auto_vu_t_users ([Id] int, [firstname] varchar(50), [lastname] varchar(50), [email] varchar(50));
CREATE TABLE forjson_auto_vu_t_orders ([Id] int, [userid] int, [productid] int, [quantity] int, [orderdate] Date);
CREATE TABLE forjson_auto_vu_t_products ([Id] int, [name] varchar(50), [price] varchar (25));
CREATE TABLE forjson_auto_vu_t_sales ([Id] int, [price] varchar(25), [totalSales] int);
CREATE TABLE forjson_auto_vu_t_times ([Id] int, [date] Date);

INSERT INTO forjson_auto_vu_t_users VALUES (1, 'j', 'o', 'testemail'), (1, 'e', 'l', 'testemail2');
INSERT INTO forjson_auto_vu_t_orders VALUES (1, 1, 1, 5, '2023-06-25'), (2, 1, 1, 6, '2023-06-25');
INSERT INTO forjson_auto_vu_t_products VALUES (1, 'A', 20), (1, 'B', 30);
INSERT INTO forjson_auto_vu_t_sales VALUES (1, 20, 50), (2, 30, 100);
INSERT INTO forjson_auto_vu_t_times VALUES (1, '2023-11-26'), (2, '2023-11-27');


GO

CREATE VIEW forjson_vu_v_1 AS 
SELECT (
    select U.Id AS "users.userid", O.productId AS "order.productId", O.Id AS "product.oid", P.price AS "product.price" FROM forjson_auto_vu_t_users U JOIN forjson_auto_vu_t_orders O ON (U.id = O.userid) JOIN forjson_auto_vu_t_products P ON (P.id = O.productid) FOR JSON AUTO
) c1
GO

CREATE VIEW forjson_vu_v_2 AS
SELECT (
    select U.Id AS "users.userid",
           U.firstname as "firstname"
    FROM forjson_auto_vu_t_users U FOR JSON AUTO
) c1
GO

CREATE VIEW forjson_vu_v_3 AS
SELECT (
    select U.Id AS "users.userid",
           U.firstname as "firstname",
           O.productId AS "order.productId"
    FROM forjson_auto_vu_t_users U JOIN forjson_auto_vu_t_orders O ON (U.id = O.userid) FOR JSON AUTO
) c1
GO

CREATE VIEW forjson_vu_v_4 AS 
SELECT (
    select U.Id AS "users.userid", O.productId AS "order.productId", O.Id AS "product.oid", P.price AS "product.price", S.totalSales AS "totalsales" FROM forjson_auto_vu_t_users U JOIN forjson_auto_vu_t_orders O ON (U.id = O.userid) JOIN forjson_auto_vu_t_products P ON (P.id = O.productid) JOIN forjson_auto_vu_t_sales S ON (P.price = S.price) FOR JSON AUTO
) c1
GO

CREATE VIEW forjson_vu_v_5 AS
SELECT (
    select forjson_auto_vu_t_users.Id,
           firstname,
           productId
    FROM forjson_auto_vu_t_users JOIN forjson_auto_vu_t_orders ON (forjson_auto_vu_t_users.id = userid) FOR JSON AUTO
) c1
GO

CREATE VIEW forjson_vu_v_6 AS
SELECT (
    select Id,
           firstname,
           lastname
    FROM forjson_auto_vu_t_users FOR JSON AUTO
) c1
GO

CREATE VIEW forjson_vu_v_7 AS
SELECT (
    select U.Id,
           name,
           price
    FROM forjson_auto_vu_t_users U JOIN forjson_auto_vu_t_products P ON (U.Id = P.Id) FOR JSON AUTO
) c1
GO

CREATE PROCEDURE forjson_vu_p_1 AS
SELECT (
    select U.Id AS "users.userid", O.productId AS "order.productId", O.Id AS "product.oid", P.price AS "product.price", S.totalSales AS "totalsales" FROM forjson_auto_vu_t_users U JOIN forjson_auto_vu_t_orders O ON (U.id = O.userid) JOIN forjson_auto_vu_t_products P ON (P.id = O.productid) JOIN forjson_auto_vu_t_sales S ON (P.price = S.price) FOR JSON AUTO
) c1
GO

INSERT INTO forjson_auto_vu_t_sales VALUES (1, NULL, NULL), (2, NULL, NULL);
GO

CREATE VIEW forjson_vu_v_8 AS 
SELECT (
    select U.Id AS "users.userid", O.productId AS "order.productId", O.Id AS "product.oid", P.price AS "product.price", S.totalSales AS "totalsales" FROM forjson_auto_vu_t_users U JOIN forjson_auto_vu_t_orders O ON (U.id = O.userid) JOIN forjson_auto_vu_t_products P ON (P.id = O.productid) JOIN forjson_auto_vu_t_sales S ON (P.price = S.price) FOR JSON AUTO
) c1
GO

CREATE VIEW forjson_vu_v_9 AS 
SELECT (
    select U.Id AS "users.userid", O.productId AS "order.productId", O.Id AS "product.oid", P.price AS "product.price", S.totalSales AS "totalsales", T.date as "date" FROM forjson_auto_vu_t_users U JOIN forjson_auto_vu_t_orders O ON (U.id = O.userid) JOIN forjson_auto_vu_t_products P ON (P.id = O.productid) JOIN forjson_auto_vu_t_sales S ON (P.price = S.price) JOIN forjson_auto_vu_t_times T ON (S.Id = T.Id) FOR JSON AUTO
) c1
GO

-- tests unique characters
CREATE VIEW forjson_vu_v_10 AS 
SELECT (
    select U.Id AS "users.userid", O.productId AS "өглөө", O.Id AS "product.oid", P.price AS "product.price", S.totalSales AS "totalsales" FROM forjson_auto_vu_t_users U JOIN forjson_auto_vu_t_orders O ON (U.id = O.userid) JOIN forjson_auto_vu_t_products P ON (P.id = O.productid) JOIN forjson_auto_vu_t_sales S ON (P.price = S.price) FOR JSON AUTO
) c1
GO

CREATE VIEW forjson_vu_v_11 AS
SELECT (
    select U.Id AS "users.ελπίδα",
           U.firstname as "爱",
           U.lastname as "كلب"
    FROM forjson_auto_vu_t_users U FOR JSON AUTO
) c1
GO

CREATE FUNCTION forjson_vu_f_1()
RETURNS sys.NVARCHAR(5000) AS
BEGIN
RETURN (select U.Id AS "users.userid", O.productId AS "өглөө", O.Id AS "product.oid", P.price AS "product.price", S.totalSales AS "totalsales" FROM forjson_auto_vu_t_users U JOIN forjson_auto_vu_t_orders O ON (U.id = O.userid) JOIN forjson_auto_vu_t_products P ON (P.id = O.productid) JOIN forjson_auto_vu_t_sales S ON (P.price = S.price) FOR JSON AUTO)
END
GO
