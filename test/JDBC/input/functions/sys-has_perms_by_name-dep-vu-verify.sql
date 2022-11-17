CREATE TABLE t_perms_by_name (col1 INT, col2 VARCHAR(16));
GO

SELECT has_perms_by_name_func('dbo.t_perms_by_name','OBJECT', 'SELECT', 'col2', 'COLUMN');
GO

SELECT has_perms_by_name_func('dBo.t_PeRmS_bY_nAmE','oBjEcT', 'sElEcT', 'CoL2', 'cOlUmN');
GO
