-- complain if script is sourced in psql, rather than via ALTER EXTENSION
\echo Use "ALTER EXTENSION ""babelfishpg_tsql"" UPDATE TO '3.0.0'" to load this file. \quit

-- add 'sys' to search path for the convenience
SELECT set_config('search_path', 'sys, '||current_setting('search_path'), false);

-- please add your SQL here

-- for 4.0.0 we need to give CREATEROLE privileges to <db_name>_db_owner
do
language plpgsql
$$
DECLARE temprow RECORD;
DECLARE query TEXT;
BEGIN
    FOR temprow IN
        SELECT name FROM sys.databases
    LOOP
        query := pg_catalog.format('ALTER ROLE %I_db_owner WITH CREATEROLE;', temprow.name);
        EXECUTE query;
    END LOOP;
END;
$$;

-- Reset search_path to not affect any subsequent scripts
SELECT set_config('search_path', trim(leading 'sys, ' from current_setting('search_path')), false);