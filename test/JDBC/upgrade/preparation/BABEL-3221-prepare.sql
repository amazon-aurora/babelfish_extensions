CREATE DATABASE db_babel_3221;
go

USE db_babel_3221;
go

CREATE TABLE babel_3221_table_1 (id INT, unique_id varchar(200), amount money);
INSERT INTO babel_3221_table_1(id, unique_id, amount) VALUES(1, '0E984725-C51C-4BF4-9960-E1C80E27ABA0', $2);
go

CREATE TABLE babel_3221_table_2 (id INT, unique_id uniqueidentifier, amount varchar(10));
INSERT INTO babel_3221_table_2(id, unique_id, amount) VALUES(1, '0E984725-C51C-4BF4-9960-E1C80E27ABA0', $2);
go

-- union of columns with different types (varchar to uniqueidentifier) and (money to varchar)
CREATE VIEW babel_3221_view
AS
	SELECT id, unique_id, amount FROM babel_3221_table_1
	UNION
	SELECT id, unique_id, amount FROM babel_3221_table_2
	WHERE id = 1;
;
go

SELECT * FROM babel_3221_view;
go