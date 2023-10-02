DROP TRIGGER IF EXISTS babel_2170_vu_employees_view_iot_insert;
GO

DROP TRIGGER IF EXISTS babel_2170_vu_employees_view_iot_update;
GO

DROP TRIGGER IF EXISTS babel_2170_vu_employees_view_iot_delete;
GO

DROP VIEW IF EXISTS babel_2170_vu_employees_view;
GO

DROP TABLE IF EXISTS babel_2170_vu_employees;
GO

SELECT name FROM sys.sysobjects WHERE name LIKE 'babel_2170%' ORDER BY name;
GO