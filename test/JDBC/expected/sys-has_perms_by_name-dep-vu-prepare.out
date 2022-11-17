CREATE FUNCTION has_perms_by_name_func(@securable AS SYS.SYSNAME,
    @securable_class AS SYS.NVARCHAR(60),
    @permission AS SYS.SYSNAME,
    @sub_securable AS SYS.SYSNAME = NULL,
    @sub_securable_class AS SYS.NVARCHAR(60) = NULL)
RETURNS INT
AS
BEGIN
    RETURN (SELECT HAS_PERMS_BY_NAME(@securable, @securable_class, @permission, @sub_securable, @sub_securable_class));
END
GO
