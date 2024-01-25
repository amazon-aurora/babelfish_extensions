-- Verify that newly created temp tables have toasts in ENR. 

CREATE TABLE #babel_4554_temp_table(a varchar(4000), b nvarchar(MAX), c sysname)
GO

SELECT COUNT(*) FROM sys.babelfish_get_enr_list()
GO
