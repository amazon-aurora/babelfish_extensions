-- complain if script is sourced in psql, rather than via ALTER EXTENSION
\echo Use "ALTER EXTENSION ""babelfishpg_tsql"" UPDATE TO '2.2.0'" to load this file. \quit

-- add 'sys' to search path for the convenience
SELECT set_config('search_path', 'sys, '||current_setting('search_path'), false);

-- Drops a view if it does not have any dependent objects.
-- Is a temporary procedure for use by the upgrade script. Will be dropped at the end of the upgrade.
-- Please have this be one of the first statements executed in this upgrade script. 
CREATE OR REPLACE PROCEDURE babelfish_drop_deprecated_view(schema_name varchar, view_name varchar) AS
$$
DECLARE
    error_msg text;
    query1 text;
    query2 text;
BEGIN
    query1 := format('alter extension babelfishpg_tsql drop view %s.%s', schema_name, view_name);
    query2 := format('drop view %s.%s', schema_name, view_name);
    execute query1;
    execute query2;
EXCEPTION
    when object_not_in_prerequisite_state then --if 'alter extension' statement fails
        GET STACKED DIAGNOSTICS error_msg = MESSAGE_TEXT;
        raise warning '%', error_msg;
    when dependent_objects_still_exist then --if 'drop view' statement fails
        GET STACKED DIAGNOSTICS error_msg = MESSAGE_TEXT;
        raise warning '%', error_msg;
end
$$
LANGUAGE plpgsql;

-- Removes a member object from the extension. The object is not dropped, only disassociated from the extension.
-- It is a temporary procedure for use by the upgrade script. Will be dropped at the end of the upgrade.
CREATE OR REPLACE PROCEDURE babelfish_remove_object_from_extension(obj_type varchar, qualified_obj_name varchar) AS
$$
DECLARE
    error_msg text;
    query text;
BEGIN
    query := format('alter extension babelfishpg_tsql drop %s %s', obj_type, qualified_obj_name);
    execute query;
EXCEPTION
    when object_not_in_prerequisite_state then --if 'alter extension' statement fails
        GET STACKED DIAGNOSTICS error_msg = MESSAGE_TEXT;
        raise warning '%', error_msg;
END
$$
LANGUAGE plpgsql;

-- please add your SQL here

CREATE OR REPLACE FUNCTION sys.DBTS()
RETURNS sys.ROWVERSION AS
$$
DECLARE
    eh_setting text;
BEGIN
    eh_setting = (select s.setting FROM pg_catalog.pg_settings s where name = 'babelfishpg_tsql.escape_hatch_rowversion');
    IF eh_setting = 'strict' THEN
        RAISE EXCEPTION 'DBTS is not currently supported in Babelfish. please use babelfishpg_tsql.escape_hatch_rowversion to ignore';
    ELSE
        RETURN sys.get_current_full_xact_id()::sys.ROWVERSION;
    END IF;
END;
$$
STRICT
LANGUAGE plpgsql;

-- Disassociate msdb objects from the extension
CALL sys.babelfish_remove_object_from_extension('view', 'msdb_dbo.sysdatabases');
CALL sys.babelfish_remove_object_from_extension('schema', 'msdb_dbo');
-- Disassociate procedures under master_dbo schema from the extension
CALL sys.babelfish_remove_object_from_extension('procedure', 'master_dbo.xp_qv(sys.nvarchar, sys.nvarchar)');
CALL sys.babelfish_remove_object_from_extension('procedure', 'master_dbo.xp_instance_regread(sys.nvarchar, sys.sysname, sys.nvarchar, int)');
CALL sys.babelfish_remove_object_from_extension('procedure', 'master_dbo.xp_instance_regread(sys.nvarchar, sys.sysname, sys.nvarchar, sys.nvarchar)');

-- Drops the temporary procedure used by the upgrade script.
-- Please have this be one of the last statements executed in this upgrade script.
DROP PROCEDURE sys.babelfish_drop_deprecated_view(varchar, varchar);
DROP PROCEDURE sys.babelfish_remove_object_from_extension(varchar, varchar);

-- Reset search_path to not affect any subsequent scripts
SELECT set_config('search_path', trim(leading 'sys, ' from current_setting('search_path')), false);