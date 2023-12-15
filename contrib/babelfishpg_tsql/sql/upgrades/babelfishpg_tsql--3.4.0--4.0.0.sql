-- complain if script is sourced in psql, rather than via ALTER EXTENSION
\echo Use "ALTER EXTENSION ""babelfishpg_tsql"" UPDATE TO '4.0.0'" to load this file. \quit

-- add 'sys' to search path for the convenience
SELECT set_config('search_path', 'sys, '||current_setting('search_path'), false);

-- please add your SQL here

-- for 4.0.0 we need to give CREATEROLE privileges to <db_name>_db_owner
do
LANGUAGE plpgsql
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

do
LANGUAGE plpgsql
$$
DECLARE db TEXT;
BEGIN
    db := current_database();
    raise warning 'Current database: %', db;
END;
$$;

-- Give the Babelfish SA admin privileges on every Babelfish role
do
LANGUAGE plpgsql
$$
DECLARE sa TEXT;
DECLARE temprow RECORD;
DECLARE query TEXT;
BEGIN
    sa := rolname from pg_roles, pg_database where datdba = pg_roles.oid and datname = current_database();
    FOR temprow IN
        SELECT DISTINCT role_name FROM information_schema.applicable_roles WHERE NOT (role_name = 'sysadmin' OR role_name LIKE 'pg_%')
    LOOP
        query := pg_catalog.format('GRANT %I to %I WITH ADMIN TRUE;', temprow.role_name, sa);
        EXECUTE query;
    END LOOP;
END;
$$;

-- Reset search_path to not affect any subsequent scripts
SELECT set_config('search_path', trim(leading 'sys, ' from current_setting('search_path')), false);