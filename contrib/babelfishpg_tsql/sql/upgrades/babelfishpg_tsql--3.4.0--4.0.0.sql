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

-- Give bbf_role_admin privileges on every Babelfish role
-- Need to create the role if it doesn't exist (e.g. from upgrade)
do
LANGUAGE plpgsql
$$
DECLARE bbf_role_admin TEXT;
DECLARE temprow RECORD;
DECLARE query TEXT;
BEGIN
    IF EXISTS (
               SELECT FROM pg_catalog.pg_roles
               WHERE  rolname = 'bbf_role_admin') 
        THEN
            RAISE NOTICE 'Role "bbf_role_admin" already exists. Skipping.';
    ELSE
        EXECUTE format('CREATE ROLE bbf_role_admin WITH CREATEDB CREATEROLE INHERIT PASSWORD NULL');
        EXECUTE format('GRANT CREATE ON DATABASE %s TO bbf_role_admin WITH GRANT OPTION', CURRENT_DATABASE());
	    EXECUTE format('GRANT sysadmin TO bbf_role_admin WITH ADMIN TRUE');
    END IF;
    FOR temprow IN
        SELECT DISTINCT role_name FROM information_schema.applicable_roles WHERE NOT (role_name = 'sysadmin' OR role_name LIKE 'pg_%')
    LOOP
        query := pg_catalog.format('GRANT %I to bbf_role_admin WITH ADMIN TRUE INHERIT TRUE;', temprow.role_name);
        EXECUTE query;
    END LOOP;
END;
$$;

-- Reset search_path to not affect any subsequent scripts
SELECT set_config('search_path', trim(leading 'sys, ' from current_setting('search_path')), false);