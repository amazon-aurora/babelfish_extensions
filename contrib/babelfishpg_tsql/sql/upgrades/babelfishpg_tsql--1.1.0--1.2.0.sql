-- complain if script is sourced in psql, rather than via ALTER EXTENSION
\echo Use "ALTER EXTENSION ""babelfishpg_tsql"" UPDATE TO '1.2.0'" to load this file. \quit

SELECT set_config('search_path', 'sys, '||current_setting('search_path'), false);

CREATE OR REPLACE FUNCTION sys.lock_timeout()
RETURNS integer
LANGUAGE plpgsql
STRICT
AS $$
declare return_value integer;
begin
    return_value := (select s.setting FROM pg_catalog.pg_settings s where name = 'babelfishpg_tsql.lock_timeout');
    RETURN return_value;
EXCEPTION
    WHEN others THEN
        RETURN NULL;
END;
$$;
GRANT EXECUTE ON FUNCTION sys.lock_timeout() TO PUBLIC;

CREATE OR REPLACE FUNCTION COLUMNS_UPDATED ()
	 	   RETURNS sys.VARBINARY AS 'babelfishpg_tsql', 'columnsupdated' LANGUAGE C;

CREATE OR REPLACE FUNCTION UPDATE (TEXT)
	 	   RETURNS BOOLEAN AS 'babelfishpg_tsql', 'updated' LANGUAGE C;

-- Added for BABEL-1544
CREATE OR REPLACE FUNCTION sys.len(expr sys.BBF_VARBINARY) RETURNS INTEGER AS
'babelfishpg_common', 'varbinary_length'
STRICT
LANGUAGE C IMMUTABLE PARALLEL SAFE;

CREATE OR REPLACE PROCEDURE sys.sp_babelfish_configure(IN "@option_name" varchar(128),  IN "@option_value" varchar(128), IN "@option_scope" varchar(128))
AS $$
DECLARE
  normalized_name varchar(256);
  default_value text;
  cnt int;
  cur refcursor;
  eh_name varchar(256);
  server boolean := false;
  prev_user text;
BEGIN
  IF lower("@option_name") like 'babelfishpg_tsql.%' THEN
    SELECT "@option_name" INTO normalized_name;
  ELSE
    SELECT concat('babelfishpg_tsql.',"@option_name") INTO normalized_name;
  END IF;

  IF lower("@option_scope") = 'server' THEN
    server := true;
  ELSIF btrim("@option_scope") != '' THEN
    RAISE EXCEPTION 'invalid option: %', "@option_scope";
  END IF;

  SELECT COUNT(*) INTO cnt FROM pg_catalog.pg_settings WHERE name like normalized_name and name like '%escape_hatch%';
  IF cnt = 0 THEN
    RAISE EXCEPTION 'unknown configuration: %', normalized_name;
  END IF;

  OPEN cur FOR SELECT name FROM pg_catalog.pg_settings WHERE name like normalized_name and name like '%escape_hatch%';

  LOOP
    FETCH NEXT FROM cur into eh_name;
    exit when not found;

    -- Each setting has a boot_val which is the wired-in default value
    -- Assuming that escape hatches cannot be modified using ALTER SYTEM/config file
    -- we are setting the boot_val as the default value for the escape hatches
    SELECT boot_val INTO default_value FROM pg_catalog.pg_settings WHERE name = eh_name;
    IF lower("@option_value") = 'default' THEN
        PERFORM pg_catalog.set_config(eh_name, default_value, 'false');
    ELSE
        PERFORM pg_catalog.set_config(eh_name, "@option_value", 'false');
    END IF;
    IF server THEN
      SELECT current_user INTO prev_user;
      PERFORM sys.babelfish_set_role(session_user);
      IF lower("@option_value") = 'default' THEN
        EXECUTE format('ALTER DATABASE %s SET %s = %s', CURRENT_DATABASE(), eh_name, default_value);
      ELSE
        -- store the setting in PG master database so that it can be applied to all bbf databases
        EXECUTE format('ALTER DATABASE %s SET %s = %s', CURRENT_DATABASE(), eh_name, "@option_value");
      END IF;
      PERFORM sys.babelfish_set_role(prev_user);
    END IF;
  END LOOP;

  CLOSE cur;

END;
$$ LANGUAGE plpgsql;
GRANT EXECUTE ON PROCEDURE sys.sp_babelfish_configure(
	IN varchar(128), IN varchar(128), IN varchar(128)
) TO PUBLIC;

-- For getting host os from PG_VERSION_STR
CREATE OR REPLACE FUNCTION sys.get_host_os()
RETURNS sys.NVARCHAR
AS 'babelfishpg_tsql', 'host_os' LANGUAGE C IMMUTABLE PARALLEL SAFE;

CREATE OR REPLACE VIEW sys.dm_os_host_info AS
SELECT
  -- get_host_os() depends on a Postgres function created separately.
  cast( sys.get_host_os() as sys.nvarchar(256) ) as host_platform
  -- Hardcoded at the moment. Should likely be GUC with default '' (empty string).
  , cast( (select setting FROM pg_settings WHERE name = 'babelfishpg_tsql.host_distribution') as sys.nvarchar(256) ) as host_distribution
  -- documentation on one hand states this is empty string on linux, but otoh shows an example with "ubuntu 16.04"
  , cast( (select setting FROM pg_settings WHERE name = 'babelfishpg_tsql.host_release') as sys.nvarchar(256) ) as host_release
  -- empty string on linux.
  , cast( (select setting FROM pg_settings WHERE name = 'babelfishpg_tsql.host_service_pack_level') as sys.nvarchar(256) )
    as host_service_pack_level
  -- windows stock keeping unit. null on linux.
  , cast( null as int ) as host_sku
  -- lcid
  , cast( sys.collationproperty( (select setting FROM pg_settings WHERE name = 'babelfishpg_tsql.server_collation_name') , 'lcid') as int )
    as "os_language_version";
GRANT SELECT ON sys.dm_os_host_info TO PUBLIC;

create or replace view sys.tables as
select
  t.relname as name
  , t.oid as object_id
  , null::integer as principal_id
  , sch.schema_id as schema_id
  , 0 as parent_object_id
  , 'U'::varchar(2) as type
  , 'USER_TABLE'::varchar(60) as type_desc
  , null::timestamp as create_date
  , null::timestamp as modify_date
  , 0 as is_ms_shipped
  , 0 as is_published
  , 0 as is_schema_published
  , case reltoastrelid when 0 then 0 else 1 end as lob_data_space_id
  , null::integer as filestream_data_space_id
  , relnatts as max_column_id_used
  , 0 as lock_on_bulk_load
  , 1 as uses_ansi_nulls
  , 0 as is_replicated
  , 0 as has_replication_filter
  , 0 as is_merge_published
  , 0 as is_sync_tran_subscribed
  , 0 as has_unchecked_assembly_data
  , 0 as text_in_row_limit
  , 0 as large_value_types_out_of_row
  , 0 as is_tracked_by_cdc
  , 0 as lock_escalation
  , 'TABLE'::varchar(60) as lock_escalation_desc
  , 0 as is_filetable
  , 0 as durability
  , 'SCHEMA_AND_DATA'::varchar(60) as durability_desc
  , 0 as is_memory_optimized
  , case relpersistence when 't' then 2 else 0 end as temporal_type
  , case relpersistence when 't' then 'SYSTEM_VERSIONED_TEMPORAL_TABLE' else 'NON_TEMPORAL_TABLE' end as temporal_type_desc
  , null::integer as history_table_id
  , 0 as is_remote_data_archive_enabled
  , 0 as is_external
from pg_class t inner join sys.schemas sch on t.relnamespace = sch.schema_id
where t.relpersistence in ('p', 'u', 't')
and t.relkind = 'r'
and has_schema_privilege(sch.schema_id, 'USAGE')
and has_table_privilege(t.oid, 'SELECT,INSERT,UPDATE,DELETE,TRUNCATE,TRIGGER');
GRANT SELECT ON sys.tables TO PUBLIC;

create or replace view sys.views as 
select 
  t.relname as name
  , t.oid as object_id
  , null::integer as principal_id
  , sch.schema_id as schema_id
  , 0 as parent_object_id
  , 'V'::varchar(2) as type 
  , 'VIEW'::varchar(60) as type_desc
  , null::timestamp as create_date
  , null::timestamp as modify_date
  , 0 as is_ms_shipped 
  , 0 as is_published 
  , 0 as is_schema_published 
  , 0 as with_check_option 
  , 0 as is_date_correlation_view 
  , 0 as is_tracked_by_cdc 
from pg_class t inner join sys.schemas sch on t.relnamespace = sch.schema_id 
where t.relkind = 'v'
and has_schema_privilege(sch.schema_id, 'USAGE')
and has_table_privilege(t.oid, 'SELECT,INSERT,UPDATE,DELETE,TRUNCATE,TRIGGER');
GRANT SELECT ON sys.views TO PUBLIC;

CREATE OR REPLACE FUNCTION sys.tsql_type_scale_helper(IN type TEXT, IN typemod INT) RETURNS sys.TINYINT
AS $$
DECLARE
  scale INT;
BEGIN
  IF type IS NULL THEN 
    RETURN -1;
  END IF;

  CASE type
  WHEN 'decimal' THEN scale = (typemod - 4) & 65535;
  WHEN 'numeric' THEN scale = (typemod - 4) & 65535;
  WHEN 'money' THEN scale = 4;
  WHEN 'smallmoney' THEN scale = 4;
  WHEN 'datetime' THEN scale = 3;
  WHEN 'datetime2' THEN
    CASE typemod 
    WHEN 0 THEN scale = 0;
    WHEN 1 THEN scale = 1;
    WHEN 2 THEN scale = 2;
    WHEN 3 THEN scale = 3;
    WHEN 4 THEN scale = 4;
    WHEN 5 THEN scale = 5;
    WHEN 6 THEN scale = 6;
    -- typemod = 7 is not possible for datetime2 in Babelfish but
    -- adding the case just in case we support it in future
    WHEN 7 THEN scale = 7;
    END CASE;
  WHEN 'datetimeoffset' THEN
    CASE typemod
    WHEN -1 THEN scale = 7;
    WHEN 0 THEN scale = 0;
    WHEN 1 THEN scale = 1;
    WHEN 2 THEN scale = 2;
    WHEN 3 THEN scale = 3;
    WHEN 4 THEN scale = 4;
    WHEN 5 THEN scale = 5;
    WHEN 6 THEN scale = 6;
    -- typemod = 7 is not possible for datetimeoffset in Babelfish
    -- but adding the case just in case we support it in future
    WHEN 7 THEN scale = 7;
    END CASE;
  WHEN 'time' THEN
    CASE typemod
    WHEN -1 THEN scale = 7;
    WHEN 0 THEN scale = 0;
    WHEN 1 THEN scale = 1;
    WHEN 2 THEN scale = 2;
    WHEN 3 THEN scale = 3;
    WHEN 4 THEN scale = 4;
    WHEN 5 THEN scale = 5;
    WHEN 6 THEN scale = 6;
    -- typemod = 7 is not possible for time in Babelfish but
    -- adding the case just in case we support it in future
    WHEN 7 THEN scale = 7;
    END CASE;
  ELSE scale = 0;
  END CASE;
  RETURN scale;
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT;

CREATE OR REPLACE FUNCTION sys.tsql_type_precision_helper(IN type TEXT, IN typemod INT) RETURNS sys.TINYINT
AS $$
DECLARE
  precision INT;
BEGIN
  IF type IS NULL THEN 
    RETURN -1;
  END IF;

  CASE type
  WHEN 'bigint' THEN precision = 19;
  WHEN 'int' THEN precision = 10;
  WHEN 'smallint' THEN precision = 5;
  WHEN 'tinyint' THEN precision = 3;
  WHEN 'bit' THEN precision = 1;
  WHEN 'numeric' THEN precision = ((typemod - 4) >> 16) & 65535;
  WHEN 'decimal' THEN precision = ((typemod - 4) >> 16) & 65535;
  WHEN 'float' THEN precision = 53;
  WHEN 'real' THEN precision = 24;
  WHEN 'money' THEN precision = 19;
  WHEN 'smallmoney' THEN precision = 10;
  WHEN 'date' THEN precision = 10;
  WHEN 'datetime' THEN precision = 23;
  WHEN 'datetime2' THEN 
    CASE typemod 
    WHEN 0 THEN precision = 19;
    WHEN 1 THEN precision = 21;
    WHEN 2 THEN precision = 22;
    WHEN 3 THEN precision = 23;
    WHEN 4 THEN precision = 24;
    WHEN 5 THEN precision = 25;
    WHEN 6 THEN precision = 26;
    -- typemod = 7 is not possible for datetime2 in Babelfish but
    -- adding the case just in case we support it in future
    WHEN 7 THEN precision = 27;
    END CASE;
  WHEN 'datetimeoffset' THEN
    CASE typemod
    WHEN -1 THEN precision = 34;
    WHEN 0 THEN precision = 26;
    WHEN 1 THEN precision = 28;
    WHEN 2 THEN precision = 29;
    WHEN 3 THEN precision = 30;
    WHEN 4 THEN precision = 31;
    WHEN 5 THEN precision = 32;
    WHEN 6 THEN precision = 33;
    -- typemod = 7 is not possible for datetimeoffset in Babelfish
    -- but adding the case just in case we support it in future
    WHEN 7 THEN precision = 34;
    END CASE;
  WHEN 'smalldatetime' THEN precision = 16;
  WHEN 'time' THEN
    CASE typemod
    WHEN -1 THEN precision = 16;
    WHEN 0 THEN precision = 8;
    WHEN 1 THEN precision = 10;
    WHEN 2 THEN precision = 11;
    WHEN 3 THEN precision = 12;
    WHEN 4 THEN precision = 13;
    WHEN 5 THEN precision = 14;
    WHEN 6 THEN precision = 15;
    -- typemod = 7 is not possible for time in Babelfish but
    -- adding the case just in case we support it in future
    WHEN 7 THEN precision = 16;
    END CASE;
  ELSE precision = 0;
  END CASE;
  RETURN precision;
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT;


CREATE OR REPLACE FUNCTION sys.tsql_type_max_length_helper(IN type TEXT, IN typelen INT, IN typemod INT)
RETURNS SMALLINT
AS $$
DECLARE
  max_length SMALLINT;
  precision INT;
BEGIN
  -- unknown tsql type
  IF type IS NULL THEN
    RETURN typelen::SMALLINT;
  END IF;

  IF typelen != -1 THEN
    CASE type
    WHEN 'tinyint' THEN max_length = 1;
    WHEN 'date' THEN max_length = 3;
    WHEN 'smalldatetime' THEN max_length = 4;
    WHEN 'smallmoney' THEN max_length = 4;
    WHEN 'datetime2' THEN
      IF typemod <= 2 THEN max_length = 6;
      ELSIF typemod <= 4 THEN max_length = 7;
      ELSEIF typemod <= 7 THEN max_length = 8;
      -- typemod = 7 is not possible for datetime2 in Babel
      END IF;
    WHEN 'datetimeoffset' THEN
      IF typemod = -1 THEN max_length = 10;
      ELSIF typemod <= 2 THEN max_length = 8;
      ELSIF typemod <= 4 THEN max_length = 9;
      ELSIF typemod <= 7 THEN max_length = 10;
      -- typemod = 7 is not possible for datetimeoffset in Babel
      END IF;
    WHEN 'time' THEN
      IF typemod = -1 THEN max_length = 5;
      ELSIF typemod <= 2 THEN max_length = 3;
      ELSIF typemod <= 4 THEN max_length = 4;
      ELSIF typemod <= 7 THEN max_length = 5;
      END IF;
    ELSE max_length = typelen;
    END CASE;
    RETURN max_length;
  END IF;

  IF typemod = -1 THEN
    CASE 
    WHEN type in ('image', 'text', 'ntext') THEN max_length = 16;
    WHEN type = 'sql_variant' THEN max_length = 8016;
    ELSE max_length = typemod;
    END CASE;
    RETURN max_length;
  END IF;

  CASE
  WHEN type in ('char', 'bpchar', 'varchar', 'binary', 'varbinary') THEN max_length = typemod - 4;
  WHEN type in ('nchar', 'nvarchar') THEN max_length = (typemod - 4) * 2;
  WHEN type = 'sysname' THEN max_length = (typemod - 4) * 2;
  WHEN type in ('numeric', 'decimal') THEN
    precision = ((typemod - 4) >> 16) & 65535;
    IF precision >= 1 and precision <= 9 THEN max_length = 5;
    ELSIF precision <= 19 THEN max_length = 9;
    ELSIF precision <= 28 THEN max_length = 13;
    ELSIF precision <= 38 THEN max_length = 17;
  ELSE max_length = typelen;
  END IF;
  ELSE
    max_length = typemod;
  END CASE;
  RETURN max_length;
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT;

-- internal function in order to workaround BABEL-1597
CREATE OR REPLACE FUNCTION sys.columns_internal()
RETURNS TABLE (
    out_object_id int,
    out_name sys.sysname,
    out_column_id int,
    out_system_type_id int,
    out_user_type_id int,
    out_max_length smallint,
    out_precision sys.tinyint,
    out_scale sys.tinyint,
    out_collation_name sys.sysname,
    out_collation_id int,
    out_offset smallint,
    out_is_nullable sys.bit,
    out_is_ansi_padded sys.bit,
    out_is_rowguidcol sys.bit,
    out_is_identity sys.bit,
    out_is_computed sys.bit,
    out_is_filestream sys.bit,
    out_is_replicated sys.bit,
    out_is_non_sql_subscribed sys.bit,
    out_is_merge_published sys.bit,
    out_is_dts_replicated sys.bit,
    out_is_xml_document sys.bit,
    out_xml_collection_id int,
    out_default_object_id int,
    out_rule_object_id int,
    out_is_sparse sys.bit,
    out_is_column_set sys.bit,
    out_generated_always_type sys.tinyint,
    out_generated_always_type_desc sys.nvarchar(60),
    out_encryption_type int,
    out_encryption_type_desc sys.nvarchar(64),
    out_encryption_algorithm_name sys.sysname,
    out_column_encryption_key_id int,
    out_column_encryption_key_database_name sys.sysname,
    out_is_hidden sys.bit,
    out_is_masked sys.bit,
    out_graph_type int,
    out_graph_type_desc sys.nvarchar(60)
)
AS
$$
BEGIN
  RETURN QUERY
    SELECT CAST(c.oid AS int),
      CAST(a.attname AS sys.sysname),
      CAST(a.attnum AS int),
      CASE 
      WHEN tsql_type_name IS NOT NULL OR t.typbasetype = 0 THEN
        -- either tsql or PG base type 
        CAST(a.atttypid AS int)
      ELSE 
        CAST(t.typbasetype AS int)
      END,
      CAST(a.atttypid AS int),
      CASE
      WHEN a.atttypmod != -1 THEN 
        sys.tsql_type_max_length_helper(coalesce(tsql_type_name, tsql_base_type_name), a.attlen, a.atttypmod)
      ELSE 
        sys.tsql_type_max_length_helper(coalesce(tsql_type_name, tsql_base_type_name), a.attlen, t.typtypmod)
      END,
      CASE
      WHEN a.atttypmod != -1 THEN 
        sys.tsql_type_precision_helper(coalesce(tsql_type_name, tsql_base_type_name), a.atttypmod)
      ELSE 
        sys.tsql_type_precision_helper(coalesce(tsql_type_name, tsql_base_type_name), t.typtypmod)
      END,
      CASE
      WHEN a.atttypmod != -1 THEN 
        sys.tsql_type_scale_helper(coalesce(tsql_type_name, tsql_base_type_name), a.atttypmod)
      ELSE 
        sys.tsql_type_scale_helper(coalesce(tsql_type_name, tsql_base_type_name), t.typtypmod)
      END,
      CAST(coll.collname AS sys.sysname),
      CAST(a.attcollation AS int),
      CAST(a.attnum AS smallint),
      CAST(case when a.attnotnull then 0 else 1 end AS sys.bit),
      CAST(case when t.typname in ('bpchar', 'nchar', 'binary') then 1 else 0 end AS sys.bit),
      CAST(0 AS sys.bit),
      CAST(case when a.attidentity <> ''::"char" then 1 else 0 end AS sys.bit),
      CAST(case when a.attgenerated <> ''::"char" then 1 else 0 end AS sys.bit),
      CAST(0 AS sys.bit),
      CAST(0 AS sys.bit),
      CAST(0 AS sys.bit),
      CAST(0 AS sys.bit),
      CAST(0 AS sys.bit),
      CAST(0 AS sys.bit),
      CAST(0 AS int),
      CAST(coalesce(d.oid, 0) AS int),
      CAST(coalesce((select oid from pg_constraint where conrelid = t.oid
            and contype = 'c' and a.attnum = any(conkey) limit 1), 0) AS int),
      CAST(0 AS sys.bit),
      CAST(0 AS sys.bit),
      CAST(0 AS sys.tinyint),
      CAST('NOT_APPLICABLE' AS sys.nvarchar(60)),
      CAST(null AS int),
      CAST(null AS sys.nvarchar(64)),
      CAST(null AS sys.sysname),
      CAST(null AS int),
      CAST(null AS sys.sysname),
      CAST(0 AS sys.bit),
      CAST(0 AS sys.bit),
      CAST(null AS int),
      CAST(null AS sys.nvarchar(60))
    FROM pg_attribute a
    INNER JOIN pg_class c ON c.oid = a.attrelid
    INNER JOIN pg_type t ON t.oid = a.atttypid
    INNER JOIN sys.schemas sch on c.relnamespace = sch.schema_id 
    INNER JOIN sys.pg_namespace_ext ext on sch.schema_id = ext.oid 
    INNER JOIN information_schema.columns isc ON c.relname = isc.table_name AND ext.nspname = isc.table_schema AND a.attname = isc.column_name
    LEFT JOIN pg_attrdef d ON c.oid = d.adrelid AND a.attnum = d.adnum
    LEFT JOIN pg_collation coll ON coll.oid = a.attcollation
    , sys.translate_pg_type_to_tsql(a.atttypid) AS tsql_type_name
    , sys.translate_pg_type_to_tsql(t.typbasetype) AS tsql_base_type_name
    WHERE NOT a.attisdropped
    AND a.attnum > 0
    -- r = ordinary table, i = index, S = sequence, t = TOAST table, v = view, m = materialized view, c = composite type, f = foreign table, p = partitioned table
    AND c.relkind IN ('r', 'v', 'm', 'f', 'p')
    AND has_schema_privilege(sch.schema_id, 'USAGE')
    AND has_column_privilege(a.attrelid, a.attname, 'SELECT,INSERT,UPDATE,REFERENCES')
    union all
    -- system tables information
    SELECT CAST(c.oid AS int),
      CAST(a.attname AS sys.sysname),
      CAST(a.attnum AS int),
      CASE 
      WHEN tsql_type_name IS NOT NULL OR t.typbasetype = 0 THEN
        -- either tsql or PG base type 
        CAST(a.atttypid AS int)
      ELSE 
        CAST(t.typbasetype AS int)
      END,
      CAST(a.atttypid AS int),
      CASE
      WHEN a.atttypmod != -1 THEN 
        sys.tsql_type_max_length_helper(coalesce(tsql_type_name, tsql_base_type_name), a.attlen, a.atttypmod)
      ELSE 
        sys.tsql_type_max_length_helper(coalesce(tsql_type_name, tsql_base_type_name), a.attlen, t.typtypmod)
      END,
      CASE
      WHEN a.atttypmod != -1 THEN 
        sys.tsql_type_precision_helper(coalesce(tsql_type_name, tsql_base_type_name), a.atttypmod)
      ELSE 
        sys.tsql_type_precision_helper(coalesce(tsql_type_name, tsql_base_type_name), t.typtypmod)
      END,
      CASE
      WHEN a.atttypmod != -1 THEN 
        sys.tsql_type_scale_helper(coalesce(tsql_type_name, tsql_base_type_name), a.atttypmod)
      ELSE 
        sys.tsql_type_scale_helper(coalesce(tsql_type_name, tsql_base_type_name), t.typtypmod)
      END,
      CAST(coll.collname AS sys.sysname),
      CAST(a.attcollation AS int),
      CAST(a.attnum AS smallint),
      CAST(case when a.attnotnull then 0 else 1 end AS sys.bit),
      CAST(case when t.typname in ('bpchar', 'nchar', 'binary') then 1 else 0 end AS sys.bit),
      CAST(0 AS sys.bit),
      CAST(case when a.attidentity <> ''::"char" then 1 else 0 end AS sys.bit),
      CAST(case when a.attgenerated <> ''::"char" then 1 else 0 end AS sys.bit),
      CAST(0 AS sys.bit),
      CAST(0 AS sys.bit),
      CAST(0 AS sys.bit),
      CAST(0 AS sys.bit),
      CAST(0 AS sys.bit),
      CAST(0 AS sys.bit),
      CAST(0 AS int),
      CAST(coalesce(d.oid, 0) AS int),
      CAST(coalesce((select oid from pg_constraint where conrelid = t.oid
            and contype = 'c' and a.attnum = any(conkey) limit 1), 0) AS int),
      CAST(0 AS sys.bit),
      CAST(0 AS sys.bit),
      CAST(0 AS sys.tinyint),
      CAST('NOT_APPLICABLE' AS sys.nvarchar(60)),
      CAST(null AS int),
      CAST(null AS sys.nvarchar(64)),
      CAST(null AS sys.sysname),
      CAST(null AS int),
      CAST(null AS sys.sysname),
      CAST(0 AS sys.bit),
      CAST(0 AS sys.bit),
      CAST(null AS int),
      CAST(null AS sys.nvarchar(60))
    FROM pg_attribute a
    INNER JOIN pg_class c ON c.oid = a.attrelid
    INNER JOIN pg_type t ON t.oid = a.atttypid
    INNER JOIN pg_namespace nsp ON (nsp.oid = c.relnamespace and nsp.nspname = 'sys')
    INNER JOIN information_schema.columns isc ON c.relname = isc.table_name AND nsp.nspname = isc.table_schema AND a.attname = isc.column_name
    LEFT JOIN pg_attrdef d ON c.oid = d.adrelid AND a.attnum = d.adnum
    LEFT JOIN pg_collation coll ON coll.oid = a.attcollation
    , sys.translate_pg_type_to_tsql(a.atttypid) AS tsql_type_name
    , sys.translate_pg_type_to_tsql(t.typbasetype) AS tsql_base_type_name
    WHERE NOT a.attisdropped
    AND a.attnum > 0
    AND c.relkind = 'r'
    AND has_schema_privilege(nsp.oid, 'USAGE')
    AND has_column_privilege(a.attrelid, a.attname, 'SELECT,INSERT,UPDATE,REFERENCES');
END;
$$
language plpgsql;

create or replace view sys.types As
-- For System types
select sys.translate_pg_type_to_tsql(t.oid) as name
  , t.oid as system_type_id
  , t.oid as user_type_id
  , s.oid as schema_id
  , null::integer as principal_id
  , t.typlen as max_length
  , 0 as precision
  , 0 as scale
  , c.collname as collation_name
  , case when typnotnull then 0 else 1 end as is_nullable
  , 0 as is_user_defined
  , 0 as is_assembly_type
  , 0 as default_object_id
  , 0 as rule_object_id
  , 0 as is_table_type
from pg_type t
inner join pg_namespace s on s.oid = t.typnamespace
left join pg_collation c on c.oid = t.typcollation
where sys.translate_pg_type_to_tsql(t.oid) IS NOT NULL
and pg_type_is_visible(t.oid)
and (s.nspname = 'pg_catalog' OR s.nspname = 'sys')
union all 
-- For User Defined Types
select cast(t.typname as text) as name
  , t.typbasetype as system_type_id
  , t.oid as user_type_id
  , s.oid as schema_id
  , null::integer as principal_id
  , t.typlen as max_length
  , 0 as precision
  , 0 as scale
  , c.collname as collation_name
  , case when typnotnull then 0 else 1 end as is_nullable
  -- CREATE TYPE ... FROM is implemented as CREATE DOMAIN in babel
  , 1 as is_user_defined
  , 0 as is_assembly_type
  , 0 as default_object_id
  , 0 as rule_object_id
  , 0 as is_table_type
from pg_type t
inner join pg_namespace s on s.oid = t.typnamespace
left join pg_collation c on c.oid = t.typcollation
-- we want to show details of user defined datatypes created under babelfish database
where sys.translate_pg_type_to_tsql(t.oid) IS NULL
and pg_type_is_visible(t.oid)
and s.nspname <> 'pg_catalog' AND s.nspname <> 'sys'
and t.typtype = 'd' ;
GRANT SELECT ON sys.types TO PUBLIC;

create or replace view sys.default_constraints
AS
select CAST(('DF_' || tab.name || '_' || d.oid) as sys.sysname) as name
  , d.oid as object_id
  , null::int as principal_id
  , tab.schema_id as schema_id
  , d.adrelid as parent_object_id
  , 'D'::char(2) as type
  , 'DEFAULT_CONSTRAINT'::sys.nvarchar(60) AS type_desc
  , null::timestamp as create_date
  , null::timestamp as modified_date
  , 0::sys.bit as is_ms_shipped
  , 0::sys.bit as is_published
  , 0::sys.bit as is_schema_published
  , d.adnum::int as parent_column_id
  , pg_get_expr(d.adbin, d.adrelid) as definition
  , 1::sys.bit as is_system_named
from pg_catalog.pg_attrdef as d
inner join pg_attribute a on a.attrelid = d.adrelid and d.adnum = a.attnum
inner join sys.tables tab on d.adrelid = tab.object_id
WHERE a.atthasdef = 't' and a.attgenerated = ''
AND has_schema_privilege(tab.schema_id, 'USAGE')
AND has_column_privilege(a.attrelid, a.attname, 'SELECT,INSERT,UPDATE,REFERENCES');
GRANT SELECT ON sys.default_constraints TO PUBLIC;

create or replace view sys.index_columns
as
select i.indrelid::integer as object_id
  , i.indexrelid::integer as index_id
  , a.attrelid::integer as index_column_id
  , a.attnum::integer as column_id
  , a.attnum::sys.tinyint as key_ordinal
  , 0::sys.tinyint as partition_ordinal
  , 0::sys.bit as is_descending_key
  , 1::sys.bit as is_included_column
from pg_index as i
inner join pg_catalog.pg_attribute a on i.indexrelid = a.attrelid
inner join pg_class c on i.indrelid = c.oid
inner join sys.schemas sch on sch.schema_id = c.relnamespace
where has_schema_privilege(sch.schema_id, 'USAGE')
and has_table_privilege(c.oid, 'SELECT,INSERT,UPDATE,DELETE,TRUNCATE,TRIGGER');
GRANT SELECT ON sys.index_columns TO PUBLIC;

create or replace view sys.foreign_keys as
select
  c.conname as name
  , c.oid as object_id
  , null::integer as principal_id
  , sch.schema_id as schema_id
  , c.conrelid as parent_object_id
  , 'F'::varchar(2) as type
  , 'FOREIGN_KEY_CONSTRAINT'::varchar(60) as type_desc
  , null::timestamp as create_date
  , null::timestamp as modify_date
  , 0 as is_ms_shipped
  , 0 as is_published
  , 0 as is_schema_published
  , c.confrelid as referenced_object_id
  , c.confkey as key_index_id
  , 0 as is_disabled
  , 0 as is_not_for_replication
  , 0 as is_not_trusted
  , case c.confdeltype
      when 'a' then 0
      when 'r' then 0
      when 'c' then 1
      when 'n' then 2
      when 'd' then 3
    end as delete_referential_action
  , case c.confdeltype
      when 'a' then 'NO_ACTION'
      when 'r' then 'NO_ACTION'
      when 'c' then 'CASCADE'
      when 'n' then 'SET_NULL'
      when 'd' then 'SET_DEFAULT'
    end as delete_referential_action_desc
  , case c.confupdtype
      when 'a' then 0
      when 'r' then 0
      when 'c' then 1
      when 'n' then 2
      when 'd' then 3
    end as update_referential_action
  , case c.confupdtype
      when 'a' then 'NO_ACTION'
      when 'r' then 'NO_ACTION'
      when 'c' then 'CASCADE'
      when 'n' then 'SET_NULL'
      when 'd' then 'SET_DEFAULT'
    end as update_referential_action_desc
  , 1 as is_system_named
from pg_constraint c
inner join sys.schemas sch on sch.schema_id = c.connamespace
where has_schema_privilege(sch.schema_id, 'USAGE')
and c.contype = 'f';
GRANT SELECT ON sys.foreign_keys TO PUBLIC;

create or replace view sys.key_constraints as
select
  c.conname as name
  , c.oid as object_id
  , null::integer as principal_id
  , sch.schema_id as schema_id
  , c.conrelid as parent_object_id
  , case contype
      when 'p' then 'PK'::varchar(2)
      when 'u' then 'UQ'::varchar(2)
    end as type
  , case contype
      when 'p' then 'PRIMARY_KEY_CONSTRAINT'::varchar(60)
      when 'u' then 'UNIQUE_CONSTRAINT'::varchar(60)
    end  as type_desc
  , null::timestamp as create_date
  , null::timestamp as modify_date
  , c.conindid as unique_index_id
  , 0 as is_ms_shipped
  , 0 as is_published
  , 0 as is_schema_published
from pg_constraint c
inner join sys.schemas sch on sch.schema_id = c.connamespace
where has_schema_privilege(sch.schema_id, 'USAGE')
and c.contype in ('p', 'u');
GRANT SELECT ON sys.key_constraints TO PUBLIC;

create or replace view sys.procedures as
select
  p.proname as name
  , p.oid as object_id
  , null::integer as principal_id
  , sch.schema_id as schema_id
  , cast (case when tr.tgrelid is not null 
      then tr.tgrelid 
      else 0 end as int) 
    as parent_object_id
  , case p.prokind
      when 'p' then 'P'::varchar(2)
      when 'a' then 'AF'::varchar(2)
      else
        case format_type(p.prorettype, null) when 'trigger'
          then 'TR'::varchar(2)
          else 'FN'::varchar(2)
        end
    end as type
  , case p.prokind
      when 'p' then 'SQL_STORED_PROCEDURE'::varchar(60)
      when 'a' then 'AGGREGATE_FUNCTION'::varchar(60)
      else
        case format_type(p.prorettype, null) when 'trigger'
          then 'SQL_TRIGGER'::varchar(60)
          else 'SQL_SCALAR_FUNCTION'::varchar(60)
        end
    end as type_desc
  , null::timestamp as create_date
  , null::timestamp as modify_date
  , 0 as is_ms_shipped
  , 0 as is_published
  , 0 as is_schema_published
from pg_proc p
inner join sys.schemas sch on sch.schema_id = p.pronamespace
left join pg_trigger tr on tr.tgfoid = p.oid
where has_schema_privilege(sch.schema_id, 'USAGE')
and has_function_privilege(p.oid, 'EXECUTE');
GRANT SELECT ON sys.procedures TO PUBLIC;

CREATE or replace VIEW sys.check_constraints AS
SELECT CAST(c.conname as sys.sysname) as name
  , oid::integer as object_id
  , NULL::integer as principal_id 
  , c.connamespace::integer as schema_id
  , conrelid::integer as parent_object_id
  , 'C'::char(2) as type
  , 'CHECK_CONSTRAINT'::sys.nvarchar(60) as type_desc
  , null::sys.datetime as create_date
  , null::sys.datetime as modify_date
  , 0::sys.bit as is_ms_shipped
  , 0::sys.bit as is_published
  , 0::sys.bit as is_schema_published
  , 0::sys.bit as is_disabled
  , 0::sys.bit as is_not_for_replication
  , 0::sys.bit as is_not_trusted
  , c.conkey[1]::integer AS parent_column_id
  , substring(pg_get_constraintdef(c.oid) from 7) AS definition
  , 1::sys.bit as uses_database_collation
  , 0::sys.bit as is_system_named
FROM pg_catalog.pg_constraint as c
INNER JOIN sys.schemas s on c.connamespace = s.schema_id
WHERE has_schema_privilege(s.schema_id, 'USAGE')
AND c.contype = 'c' and c.conrelid != 0;
GRANT SELECT ON sys.check_constraints TO PUBLIC;

create or replace view sys.objects as
select
      t.name
    , t.object_id
    , t.principal_id
    , t.schema_id
    , t.parent_object_id
    , 'U' as type
    , 'USER_TABLE' as type_desc
    , t.create_date
    , t.modify_date
    , t.is_ms_shipped
    , t.is_published
    , t.is_schema_published
from  sys.tables t
union all
select
      v.name
    , v.object_id
    , v.principal_id
    , v.schema_id
    , v.parent_object_id
    , 'V' as type
    , 'VIEW' as type_desc
    , v.create_date
    , v.modify_date
    , v.is_ms_shipped
    , v.is_published
    , v.is_schema_published
from  sys.views v
union all
select
      f.name
    , f.object_id
    , f.principal_id
    , f.schema_id
    , f.parent_object_id
    , 'F' as type
    , 'FOREIGN_KEY_CONSTRAINT'
    , f.create_date
    , f.modify_date
    , f.is_ms_shipped
    , f.is_published
    , f.is_schema_published
 from sys.foreign_keys f
union all
select
      p.name
    , p.object_id
    , p.principal_id
    , p.schema_id
    , p.parent_object_id
    , 'PK' as type
    , 'PRIMARY_KEY_CONSTRAINT' as type_desc
    , p.create_date
    , p.modify_date
    , p.is_ms_shipped
    , p.is_published
    , p.is_schema_published
from sys.key_constraints p
where p.type = 'PK'
union all
select
      pr.name
    , pr.object_id
    , pr.principal_id
    , pr.schema_id
    , pr.parent_object_id
    , pr.type
    , pr.type_desc
    , pr.create_date
    , pr.modify_date
    , pr.is_ms_shipped
    , pr.is_published
    , pr.is_schema_published
 from sys.procedures pr
union all
select
    def.name::name
  , def.object_id
  , def.principal_id
  , def.schema_id
  , def.parent_object_id
  , def.type
  , def.type_desc
  , def.create_date
  , def.modified_date as modify_date
  , def.is_ms_shipped::int
  , def.is_published::int
  , def.is_schema_published::int
  from sys.default_constraints def
union all
select
    chk.name::name
  , chk.object_id
  , chk.principal_id
  , chk.schema_id
  , chk.parent_object_id
  , chk.type
  , chk.type_desc
  , chk.create_date
  , chk.modify_date
  , chk.is_ms_shipped::int
  , chk.is_published::int
  , chk.is_schema_published::int
  from sys.check_constraints chk
union all
select
   p.relname as name
  ,p.oid as object_id
  , null::integer as principal_id
  , s.schema_id as schema_id
  , 0 as parent_object_id
  , 'SO'::varchar(2) as type
  , 'SEQUENCE_OBJECT'::varchar(60) as type_desc
  , null::timestamp as create_date
  , null::timestamp as modify_date
  , 0 as is_ms_shipped
  , 0 as is_published
  , 0 as is_schema_published
from pg_class p
inner join sys.schemas s on s.schema_id = p.relnamespace
and p.relkind = 'S'
and has_schema_privilege(s.schema_id, 'USAGE');
GRANT SELECT ON sys.objects TO PUBLIC;

create or replace view sys.indexes as
select
  i.indrelid as object_id
  , c.relname as name
  , case when i.indisclustered then 1 else 2 end as type
  , case when i.indisclustered then 'CLUSTERED'::varchar(60) else 'NONCLUSTERED'::varchar(60) end as type_desc
  , case when i.indisunique then 1 else 0 end as is_unique
  , c.reltablespace as data_space_id
  , 0 as ignore_dup_key
  , case when i.indisprimary then 1 else 0 end as is_primary_key
  , case when constr.oid is null then 0 else 1 end as is_unique_constraint
  , 0 as fill_factor
  , case when i.indpred is null then 0 else 1 end as is_padded
  , case when i.indisready then 0 else 1 end is_disabled
  , 0 as is_hypothetical
  , 1 as allow_row_locks
  , 1 as allow_page_locks
  , 0 as has_filter
  , null::varchar as filter_definition
  , 0 as auto_created
  , c.oid as index_id
from pg_class c
inner join sys.schemas sch on c.relnamespace = sch.schema_id
inner join pg_index i on i.indexrelid = c.oid
left join pg_constraint constr on constr.conindid = c.oid
where c.relkind = 'i' and i.indislive
and has_schema_privilege(sch.schema_id, 'USAGE');
GRANT SELECT ON sys.indexes TO PUBLIC;

create or replace view sys.sql_modules as
select
  p.oid as object_id
  , pg_get_functiondef(p.oid) as definition
  , 1 as uses_ansi_nulls
  , 1 as uses_quoted_identifier
  , 0 as is_schema_bound
  , 0 as uses_database_collation
  , 0 as is_recompiled
  , case when p.proisstrict then 1 else 0 end as null_on_null_input
  , null::integer as execute_as_principal_id
  , 0 as uses_native_compilation
from pg_proc p
inner join sys.schemas s on s.schema_id = p.pronamespace
inner join pg_type t on t.oid = p.prorettype
left join pg_collation c on c.oid = t.typcollation
where has_schema_privilege(s.schema_id, 'USAGE')
and has_function_privilege(p.oid, 'EXECUTE');
GRANT SELECT ON sys.sql_modules TO PUBLIC;

create or replace view sys.identity_columns AS
select out_object_id::bigint as object_id
  , out_name::name as name
  , out_column_id::smallint as column_id
  , out_system_type_id::oid as system_type_id
  , out_user_type_id::oid as user_type_id
  , out_max_length as max_length
  , out_precision::integer as precision
  , out_scale::integer as scale
  , out_collation_name::name as collation_name
  , out_is_nullable::integer as is_nullable
  , out_is_ansi_padded::integer as is_ansi_padded
  , out_is_rowguidcol::integer as is_rowguidcol
  , out_is_identity::integer as is_identity
  , out_is_computed::integer as is_computed
  , out_is_filestream::integer as is_filestream
  , out_is_replicated::integer as is_replicated
  , out_is_non_sql_subscribed::integer as is_non_sql_subscribed
  , out_is_merge_published::integer as is_merge_published
  , out_is_dts_replicated::integer as is_dts_replicated
  , out_is_xml_document::integer as is_xml_document
  , out_xml_collection_id::integer as xml_collection_id
  , out_default_object_id::oid as default_object_id
  , out_rule_object_id::oid as rule_object_id
  , out_is_sparse::integer as is_sparse
  , out_is_column_set::integer as is_column_set
  , out_generated_always_type::integer as generated_always_type
  , out_generated_always_type_desc::character varying(60) as generated_always_type_desc
  , out_encryption_type::integer as encryption_type
  , out_encryption_type_desc::character varying(64)  as encryption_type_desc
  , out_encryption_algorithm_name::character varying as encryption_algorithm_name
  , out_column_encryption_key_id::integer as column_encryption_key_id
  , out_column_encryption_key_database_name::character varying as column_encryption_key_database_name
  , out_is_hidden::integer as is_hidden
  , out_is_masked::integer as is_masked
  , sys.ident_seed(OBJECT_NAME(sc.out_object_id))::bigint as seed_value
  , sys.ident_incr(OBJECT_NAME(sc.out_object_id))::bigint as increment_value
  , sys.babelfish_get_sequence_value(pg_get_serial_sequence(quote_ident(ext.nspname)||'.'||quote_ident(c.relname), a.attname)) as last_value
from sys.columns_internal() sc
INNER JOIN pg_attribute a ON sc.out_name = a.attname AND sc.out_column_id = a.attnum
inner join pg_class c on c.oid = a.attrelid
inner join sys.pg_namespace_ext ext on ext.oid = c.relnamespace
where not a.attisdropped
and sc.out_is_identity::integer = 1
and pg_get_serial_sequence(quote_ident(ext.nspname)||'.'||quote_ident(c.relname), a.attname)  is not null
and has_sequence_privilege(pg_get_serial_sequence(quote_ident(ext.nspname)||'.'||quote_ident(c.relname), a.attname), 'USAGE,SELECT,UPDATE');
GRANT SELECT ON sys.identity_columns TO PUBLIC;

CREATE OR REPLACE FUNCTION sys.proc_param_helper()
RETURNS TABLE (
    name sys.sysname,
    id int,
    xtype int,
    colid smallint,
    collationid int,
    prec smallint,
    scale int,
    isoutparam int,
    collation sys.sysname
)
AS
$$
BEGIN
RETURN QUERY
select params.parameter_name::sys.sysname
  , pgproc.oid::int
  , CAST(case when pgproc.proallargtypes is null then split_part(pgproc.proargtypes::varchar, ' ', params.ordinal_position)
    else split_part(btrim(pgproc.proallargtypes::text,'{}'), ',', params.ordinal_position) end AS int)
  , params.ordinal_position::smallint
  , coll.oid::int
  , params.numeric_precision::smallint
  , params.numeric_scale::int
  , case params.parameter_mode when 'OUT' then 1 when 'INOUT' then 1 else 0 end
  , params.collation_name::sys.sysname
from information_schema.routines routine
left join information_schema.parameters params
  on routine.specific_schema = params.specific_schema
  and routine.specific_name = params.specific_name
left join pg_collation coll on coll.collname = params.collation_name
/* assuming routine.specific_name is constructed by concatenating procedure name and oid */
left join pg_proc pgproc on routine.specific_name = nameconcatoid(pgproc.proname, pgproc.oid)
left join sys.schemas sch on sch.schema_id = pgproc.pronamespace
where has_schema_privilege(sch.schema_id, 'USAGE');
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE VIEW sys.syscolumns AS
SELECT out_name as name
  , out_object_id as id
  , out_system_type_id as xtype
  , 0::sys.tinyint as typestat
  , (case when out_user_type_id < 32767 then out_user_type_id else null end)::smallint as xusertype
  , out_max_length as length
  , 0::sys.tinyint as xprec
  , 0::sys.tinyint as xscale
  , out_column_id::smallint as colid
  , 0::smallint as xoffset
  , 0::sys.tinyint as bitpos
  , 0::sys.tinyint as reserved
  , 0::smallint as colstat
  , out_default_object_id::int as cdefault
  , out_rule_object_id::int as domain
  , 0::smallint as number
  , 0::smallint as colorder
  , null::sys.varbinary(8000) as autoval
  , out_offset as offset
  , out_collation_id as collationid
  , (case out_is_nullable::int when 1 then 8    else 0 end +
     case out_is_identity::int when 1 then 128  else 0 end)::sys.tinyint as status
  , out_system_type_id as type
  , (case when out_user_type_id < 32767 then out_user_type_id else null end)::smallint as usertype
  , null::varchar(255) as printfmt
  , out_precision::smallint as prec
  , out_scale::int as scale
  , out_is_computed::int as iscomputed
  , 0::int as isoutparam
  , out_is_nullable::int as isnullable
  , out_collation_name::sys.sysname as collation
FROM sys.columns_internal()
union all
SELECT p.name
  , p.id
  , p.xtype
  , 0::sys.tinyint as typestat
  , (case when p.xtype < 32767 then p.xtype else null end)::smallint as xusertype
  , null as length
  , 0::sys.tinyint as xprec
  , 0::sys.tinyint as xscale
  , p.colid
  , 0::smallint as xoffset
  , 0::sys.tinyint as bitpos
  , 0::sys.tinyint as reserved
  , 0::smallint as colstat
  , null::int as cdefault
  , null::int as domain
  , 0::smallint as number
  , 0::smallint as colorder
  , null::sys.varbinary(8000) as autoval
  , 0::smallint as offset
  , collationid
  , (case p.isoutparam when 1 then 64 else 0 end)::sys.tinyint as status
  , p.xtype as type
  , (case when p.xtype < 32767 then p.xtype else null end)::smallint as usertype
  , null::varchar(255) as printfmt
  , p.prec
  , p.scale
  , 0::int as iscomputed
  , p.isoutparam
  , 1::int as isnullable
  , p.collation
FROM sys.proc_param_helper() as p;
GRANT SELECT ON sys.syscolumns TO PUBLIC;

create or replace view sys.all_views as
select
  t.relname as name
  , t.oid as object_id
  , null::integer as principal_id
  , s.oid as schema_id
  , 0 as parent_object_id
  , 'V'::varchar(2) as type
  , 'VIEW'::varchar(60) as type_desc
  , null::timestamp as create_date
  , null::timestamp as modify_date
  , 0 as is_ms_shipped
  , 0 as is_published
  , 0 as is_schema_published
  , 0 as with_check_option
  , 0 as is_date_correlation_view
  , 0 as is_tracked_by_cdc
from pg_class t inner join pg_namespace s on s.oid = t.relnamespace
where t.relkind = 'v'
and (s.oid in (select schema_id from sys.schemas) or s.nspname = 'sys')
and has_schema_privilege(s.oid, 'USAGE')
and has_table_privilege(quote_ident(s.nspname) ||'.'||quote_ident(t.relname), 'SELECT,INSERT,UPDATE,DELETE,TRUNCATE,TRIGGER');
GRANT SELECT ON sys.all_views TO PUBLIC;

create or replace view sys.all_objects as
-- details of user defined and system tables
select
    t.relname as name
  , t.oid as object_id
  , null::integer as principal_id
  , s.oid as schema_id
  , 0 as parent_object_id
  , 'U' as type
  , 'USER_TABLE' as type_desc
  , null::timestamp as create_date
  , null::timestamp as modify_date
  , 0 as is_ms_shipped
  , 0 as is_published
  , 0 as is_schema_published
from pg_class t inner join pg_namespace s on s.oid = t.relnamespace
where t.relpersistence in ('p', 'u', 't')
and t.relkind = 'r'
and (s.oid in (select schema_id from sys.schemas) or s.nspname = 'sys')
and has_schema_privilege(s.oid, 'USAGE')
and has_table_privilege(t.oid, 'SELECT,INSERT,UPDATE,DELETE,TRUNCATE,TRIGGER')
union all
-- details of user defined and system views
select
    v.name
  , v.object_id
  , v.principal_id
  , v.schema_id
  , v.parent_object_id
  , 'V' as type
  , 'VIEW' as type_desc
  , v.create_date
  , v.modify_date
  , v.is_ms_shipped
  , v.is_published
  , v.is_schema_published
from  sys.all_views v
union all
-- details of user defined and system foreign key constraints
select
    c.conname as name
  , c.oid as object_id
  , null::integer as principal_id
  , s.oid as schema_id
  , c.conrelid as parent_object_id
  , 'F' as type
  , 'FOREIGN_KEY_CONSTRAINT'
  , null::timestamp as create_date
  , null::timestamp as modify_date
  , 0 as is_ms_shipped
  , 0 as is_published
  , 0 as is_schema_published
from pg_constraint c
inner join pg_namespace s on s.oid = c.connamespace
where (s.oid in (select schema_id from sys.schemas) or s.nspname = 'sys')
and has_schema_privilege(s.oid, 'USAGE')
and c.contype = 'f'
union all
-- details of user defined and system primary key constraints
select
    c.conname as name
  , c.oid as object_id
  , null::integer as principal_id
  , s.oid as schema_id
  , c.conrelid as parent_object_id
  , 'PK' as type
  , 'PRIMARY_KEY_CONSTRAINT' as type_desc
  , null::timestamp as create_date
  , null::timestamp as modify_date
  , 0 as is_ms_shipped
  , 0 as is_published
  , 0 as is_schema_published
from pg_constraint c
inner join pg_namespace s on s.oid = c.connamespace
where (s.oid in (select schema_id from sys.schemas) or s.nspname = 'sys')
and has_schema_privilege(s.oid, 'USAGE')
and c.contype = 'p'
union all
-- details of user defined and system defined procedures
select
    p.proname as name
  , p.oid as object_id
  , null::integer as principal_id
  , s.oid as schema_id
  , 0 as parent_object_id
  , case p.prokind
      when 'p' then 'P'::varchar(2)
      when 'a' then 'AF'::varchar(2)
      else
        case format_type(p.prorettype, null) when 'trigger'
          then 'TR'::varchar(2)
          else 'FN'::varchar(2)
        end
    end as type
  , case p.prokind
      when 'p' then 'SQL_STORED_PROCEDURE'::varchar(60)
      when 'a' then 'AGGREGATE_FUNCTION'::varchar(60)
      else
        case format_type(p.prorettype, null) when 'trigger'
          then 'SQL_TRIGGER'::varchar(60)
          else 'SQL_SCALAR_FUNCTION'::varchar(60)
        end
    end as type_desc
  , null::timestamp as create_date
  , null::timestamp as modify_date
  , 0 as is_ms_shipped
  , 0 as is_published
  , 0 as is_schema_published
from pg_proc p
inner join pg_namespace s on s.oid = p.pronamespace
where (s.oid in (select schema_id from sys.schemas) or s.nspname = 'sys')
and has_schema_privilege(s.oid, 'USAGE')
and has_function_privilege(p.oid, 'EXECUTE')
union all
-- details of all default constraints
select
    ('DF_' || o.relname || '_' || d.oid)::name as name
  , d.oid as object_id
  , null::int as principal_id
  , o.relnamespace as schema_id
  , d.adrelid as parent_object_id
  , 'D'::char(2) as type
  , 'DEFAULT_CONSTRAINT'::sys.nvarchar(60) AS type_desc
  , null::timestamp as create_date
  , null::timestamp as modify_date
  , 0 as is_ms_shipped
  , 0 as is_published
  , 0 as is_schema_published
from pg_catalog.pg_attrdef d
inner join pg_attribute a on a.attrelid = d.adrelid and d.adnum = a.attnum
inner join pg_class o on d.adrelid = o.oid
inner join pg_namespace s on s.oid = o.relnamespace
where a.atthasdef = 't' and a.attgenerated = ''
and (s.oid in (select schema_id from sys.schemas) or s.nspname = 'sys')
and has_schema_privilege(s.oid, 'USAGE')
and has_column_privilege(a.attrelid, a.attname, 'SELECT,INSERT,UPDATE,REFERENCES')
union all
-- details of all check constraints
select
    c.conname::name
  , c.oid::integer as object_id
  , NULL::integer as principal_id 
  , c.connamespace::integer as schema_id
  , c.conrelid::integer as parent_object_id
  , 'C'::char(2) as type
  , 'CHECK_CONSTRAINT'::sys.nvarchar(60) as type_desc
  , null::sys.datetime as create_date
  , null::sys.datetime as modify_date
  , 0 as is_ms_shipped
  , 0 as is_published
  , 0 as is_schema_published
from pg_catalog.pg_constraint as c
inner join pg_namespace s on s.oid = c.connamespace
where (s.oid in (select schema_id from sys.schemas) or s.nspname = 'sys')
and has_schema_privilege(s.oid, 'USAGE')
and c.contype = 'c' and c.conrelid != 0
union all
-- details of user defined and system defined sequence objects
select
  p.relname as name
  , p.oid as object_id
  , null::integer as principal_id
  , s.oid as schema_id
  , 0 as parent_object_id
  , 'SO'::varchar(2) as type
  , 'SEQUENCE_OBJECT'::varchar(60) as type_desc
  , null::timestamp as create_date
  , null::timestamp as modify_date
  , 0 as is_ms_shipped
  , 0 as is_published
  , 0 as is_schema_published
from pg_class p
inner join pg_namespace s on s.oid = p.relnamespace
where p.relkind = 'S'
and (s.oid in (select schema_id from sys.schemas) or s.nspname = 'sys')
and has_schema_privilege(s.oid, 'USAGE');
GRANT SELECT ON sys.all_objects TO PUBLIC;

create or replace view sys.system_objects as
select * from sys.all_objects o
inner join pg_namespace s on s.oid = o.schema_id
where s.nspname = 'sys';
GRANT SELECT ON sys.system_objects TO PUBLIC;

create or replace view sys.all_columns as
select c.oid as object_id
  , a.attname as name
  , a.attnum as column_id
  , t.oid as system_type_id
  , t.oid as user_type_id
  , a.attlen as max_length
  , null::integer as precision
  , null::integer as scale
  , coll.collname as collation_name
  , case when a.attnotnull then 0 else 1 end as is_nullable
  , 0 as is_ansi_padded
  , 0 as is_rowguidcol
  , 0 as is_identity
  , 0 as is_computed
  , 0 as is_filestream
  , 0 as is_replicated
  , 0 as is_non_sql_subscribed
  , 0 as is_merge_published
  , 0 as is_dts_replicated
  , 0 as is_xml_document
  , 0 as xml_collection_id
  , coalesce(d.oid, 0) as default_object_id
  , coalesce((select oid from pg_constraint where conrelid = t.oid and contype = 'c' and a.attnum = any(conkey) limit 1), 0) as rule_object_id
  , 0 as is_sparse
  , 0 as is_column_set
  , 0 as generated_always_type
  , 'NOT_APPLICABLE'::varchar(60) as generated_always_type_desc
  , null::integer as encryption_type
  , null::varchar(64) as encryption_type_desc
  , null::varchar as encryption_algorithm_name
  , null::integer as column_encryption_key_id
  , null::varchar as column_encryption_key_database_name
  , 0 as is_hidden
  , 0 as is_masked
from pg_attribute a
inner join pg_class c on c.oid = a.attrelid
inner join pg_type t on t.oid = a.atttypid
inner join pg_namespace s on s.oid = c.relnamespace
left join pg_attrdef d on c.oid = d.adrelid and a.attnum = d.adnum
left join pg_collation coll on coll.oid = a.attcollation
where not a.attisdropped
and (s.oid in (select schema_id from sys.schemas) or s.nspname = 'sys')
-- r = ordinary table, i = index, S = sequence, t = TOAST table, v = view, m = materialized view, c = composite type, f = foreign table, p = partitioned table
and c.relkind in ('r', 'v', 'm', 'f', 'p')
and has_schema_privilege(s.oid, 'USAGE')
and has_column_privilege(quote_ident(s.nspname) ||'.'||quote_ident(c.relname), a.attname, 'SELECT,INSERT,UPDATE,REFERENCES')
and a.attnum > 0;
GRANT SELECT ON sys.all_columns TO PUBLIC;

CREATE OR REPLACE VIEW sys.sp_tables_view AS
SELECT
t2.dbname AS TABLE_QUALIFIER,
t3.rolname AS TABLE_OWNER,
t1.relname AS TABLE_NAME,
case
  when t1.relkind = 'v' then 'VIEW'
  else 'TABLE'
end AS TABLE_TYPE,
CAST(NULL AS varchar(254)) AS remarks
FROM pg_catalog.pg_class AS t1, sys.pg_namespace_ext AS t2, pg_catalog.pg_roles AS t3
WHERE t1.relowner = t3.oid AND t1.relnamespace = t2.oid
AND (t1.relnamespace IN (SELECT schema_id FROM sys.schemas))
AND has_schema_privilege(t1.relnamespace, 'USAGE')
AND has_table_privilege(t1.oid, 'SELECT,INSERT,UPDATE,DELETE,TRUNCATE,TRIGGER');
GRANT SELECT on sys.sp_tables_view TO PUBLIC;

create or replace view sys.foreign_key_columns as
select distinct
  c.oid as constraint_object_id
  , c.confkey as constraint_column_id
  , c.conrelid as parent_object_id
  , a_con.attnum as parent_column_id
  , c.confrelid as referenced_object_id
  , a_conf.attnum as referenced_column_id
from pg_constraint c
inner join pg_attribute a_con on a_con.attrelid = c.conrelid and a_con.attnum = any(c.conkey)
inner join pg_attribute a_conf on a_conf.attrelid = c.confrelid and a_conf.attnum = any(c.confkey)
where c.contype = 'f'
and (c.connamespace in (select schema_id from sys.schemas))
and has_schema_privilege(c.connamespace, 'USAGE');
GRANT SELECT ON sys.foreign_key_columns TO PUBLIC;

create or replace view sys.sysforeignkeys as
select
  c.conname as name
  , c.oid as object_id
  , c.conrelid as fkeyid
  , c.confrelid as rkeyid
  , a_con.attnum as fkey
  , a_conf.attnum as rkey
  , a_conf.attnum as keyno
from pg_constraint c
inner join pg_attribute a_con on a_con.attrelid = c.conrelid and a_con.attnum = any(c.conkey)
inner join pg_attribute a_conf on a_conf.attrelid = c.confrelid and a_conf.attnum = any(c.confkey)
where c.contype = 'f'
and (c.connamespace in (select schema_id from sys.schemas))
and has_schema_privilege(c.connamespace, 'USAGE');
GRANT SELECT ON sys.sysforeignkeys TO PUBLIC;

CREATE OR REPLACE FUNCTION sys.DBTS()
RETURNS sys.ROWVERSION AS
$BODY$
SELECT txid_snapshot_xmin(txid_current_snapshot())::sys.ROWVERSION as dbts;
$BODY$
STRICT
LANGUAGE SQL;

CREATE OR REPLACE FUNCTION sys.schema_id()
RETURNS INT
LANGUAGE plpgsql
STRICT
AS $$
BEGIN
  RETURN (select oid from sys.pg_namespace_ext where nspname = (select current_schema()))::INT;
EXCEPTION
    WHEN others THEN
        RETURN NULL;
END;
$$;
GRANT EXECUTE ON FUNCTION sys.schema_id() TO PUBLIC;

CREATE OR REPLACE FUNCTION sys.getdate() RETURNS sys.datetime
    AS $$select date_trunc('millisecond', clock_timestamp()::pg_catalog.timestamp)::sys.datetime;$$
    LANGUAGE SQL;
GRANT EXECUTE ON FUNCTION sys.getdate() TO PUBLIC; 

CREATE SCHEMA information_schema_tsql;
GRANT USAGE ON SCHEMA information_schema_tsql TO PUBLIC;

CREATE OR REPLACE FUNCTION information_schema_tsql._pgtsql_truetypid(nt pg_namespace, at pg_attribute, tp pg_type) RETURNS oid
  LANGUAGE sql
  IMMUTABLE
  PARALLEL SAFE
  RETURNS NULL ON NULL INPUT
  AS
$$SELECT CASE WHEN nt.nspname = 'pg_catalog' OR nt.nspname = 'sys' THEN at.atttypid ELSE tp.typbasetype END$$;

CREATE OR REPLACE FUNCTION information_schema_tsql._pgtsql_truetypmod(nt pg_namespace, at pg_attribute, tp pg_type) RETURNS int4
  LANGUAGE sql
  IMMUTABLE
  PARALLEL SAFE
  RETURNS NULL ON NULL INPUT
  AS
$$SELECT CASE WHEN nt.nspname = 'pg_catalog' OR nt.nspname = 'sys' THEN at.atttypmod ELSE tp.typtypmod END$$;


CREATE OR REPLACE FUNCTION information_schema_tsql._pgtsql_char_max_length(type text, typmod int4) RETURNS integer
  LANGUAGE sql
  IMMUTABLE
  PARALLEL SAFE
  RETURNS NULL ON NULL INPUT
  AS
$$SELECT
  CASE WHEN type IN ('char', 'nchar', 'varchar', 'nvarchar', 'binary', 'varbinary')
    THEN CASE WHEN typmod = -1
      THEN -1
      ELSE typmod - 4
      END
    WHEN type IN ('text', 'image')
    THEN 2147483647
    WHEN type = 'ntext'
    THEN 1073741823
    WHEN type = 'xml'
    THEN -1
    WHEN type = 'sql_variant'
    THEN 0
    ELSE null
  END$$;

CREATE OR REPLACE FUNCTION information_schema_tsql._pgtsql_char_octet_length(type text, typmod int4) RETURNS integer
  LANGUAGE sql
  IMMUTABLE
  PARALLEL SAFE
  RETURNS NULL ON NULL INPUT
  AS
$$SELECT
  CASE WHEN type IN ('char', 'varchar', 'binary', 'varbinary')
    THEN CASE WHEN typmod = -1 /* default typmod */
      THEN CAST(2147483646 AS integer) /* 2^30 */
      ELSE typmod - 4
      END
    WHEN type IN ('nchar', 'nvarchar')
    THEN CASE WHEN typmod = -1 /* default typmod */
      THEN CAST(2147483646 AS integer) /* 2^30 */
      ELSE (typmod - 4) * 2
      END
    WHEN type IN ('text', 'image')
    THEN 2147483647 /* 2^30 + 1 */
    WHEN type = 'ntext'
    THEN 2147483646 /* 2^30 */
    WHEN type = 'sql_variant'
    THEN 0
    WHEN type = 'xml'
    THEN -1
     ELSE null
  END$$;

CREATE OR REPLACE FUNCTION information_schema_tsql._pgtsql_numeric_precision(typid oid, typmod int4) RETURNS integer
  LANGUAGE sql
  IMMUTABLE
  PARALLEL SAFE
  RETURNS NULL ON NULL INPUT
  AS
$$SELECT
  CASE typid
     WHEN 21 /*int2*/ THEN 5
     WHEN 23 /*int4*/ THEN 10
     WHEN 20 /*int8*/ THEN 19
     WHEN 1700 /*numeric*/ THEN
        CASE WHEN typmod = -1
           THEN null
           ELSE ((typmod - 4) >> 16) & 65535
           END
     WHEN 700 /*float4*/ THEN 24
     WHEN 701 /*float8*/ THEN 53
     ELSE null
  END$$;

CREATE OR REPLACE FUNCTION information_schema_tsql._pgtsql_numeric_precision_radix(typid oid, typmod int4) RETURNS integer
  LANGUAGE sql
  IMMUTABLE
  PARALLEL SAFE
  RETURNS NULL ON NULL INPUT
  AS
$$SELECT
  CASE WHEN typid IN (700, 701) THEN 2
    WHEN typid IN (20, 21, 23, 1700) THEN 10
    ELSE null
  END$$;

CREATE OR REPLACE FUNCTION information_schema_tsql._pgtsql_numeric_scale(typid oid, typmod int4) RETURNS integer
  LANGUAGE sql
  IMMUTABLE
  PARALLEL SAFE
  RETURNS NULL ON NULL INPUT
  AS
$$SELECT
  CASE WHEN typid IN (21, 23, 20) THEN 0
    WHEN typid IN (1700) THEN
      CASE WHEN typmod = -1
         THEN null
         ELSE (typmod - 4) & 65535
         END
    ELSE null
  END$$;

CREATE OR REPLACE FUNCTION information_schema_tsql._pgtsql_datetime_precision(type text, typmod int4) RETURNS integer
  LANGUAGE sql
  IMMUTABLE
  PARALLEL SAFE
  RETURNS NULL ON NULL INPUT
  AS
$$SELECT
  CASE WHEN type = 'date'
       THEN 0
    WHEN type = 'datetime'
    THEN 3
     WHEN type IN ('time', 'datetime2', 'smalldatetime')
       THEN CASE WHEN typmod < 0 THEN 6 ELSE typmod END
     ELSE null
  END$$;

CREATE OR REPLACE VIEW information_schema_tsql.columns AS
  SELECT CAST(nc.dbname AS sys.nvarchar(128)) AS "TABLE_CATALOG",
      CAST(ext.orig_name AS sys.nvarchar(128)) AS "TABLE_SCHEMA",
      CAST(c.relname AS sys.nvarchar(128)) AS "TABLE_NAME",
      CAST(a.attname AS sys.nvarchar(128)) AS "COLUMN_NAME",
      CAST(a.attnum AS int) AS "ORDINAL_POSITION",
      CAST(CASE WHEN a.attgenerated = '' THEN pg_get_expr(ad.adbin, ad.adrelid) END AS sys.nvarchar(4000)) AS "COLUMN_DEFAULT",
      CAST(CASE WHEN a.attnotnull OR (t.typtype = 'd' AND t.typnotnull) THEN 'NO' ELSE 'YES' END
        AS varchar(3))
        AS "IS_NULLABLE",

      CAST(
        sys.translate_pg_type_to_tsql(information_schema_tsql._pgtsql_truetypid(nt, a, t)) AS sys.nvarchar(128))
        AS "DATA_TYPE",

      CAST(
        information_schema_tsql._pgtsql_char_max_length(sys.translate_pg_type_to_tsql(information_schema_tsql._pgtsql_truetypid(nt, a, t)),
          information_schema_tsql._pgtsql_truetypmod(nt, a, t))
        AS int)
        AS "CHARACTER_MAXIMUM_LENGTH",

      CAST(
        information_schema_tsql._pgtsql_char_octet_length(sys.translate_pg_type_to_tsql(information_schema_tsql._pgtsql_truetypid(nt, a, t)),
          information_schema_tsql._pgtsql_truetypmod(nt, a, t))
        AS int)
        AS "CHARACTER_OCTET_LENGTH",

      CAST(
        /* Handle Tinyint separately */
        CASE WHEN sys.translate_pg_type_to_tsql(information_schema_tsql._pgtsql_truetypid(nt, a, t)) = 'tinyint'
          THEN 3
          ELSE information_schema_tsql._pgtsql_numeric_precision(information_schema_tsql._pgtsql_truetypid(nt, a, t),
            information_schema_tsql._pgtsql_truetypmod(nt, a, t))
          END
        AS sys.tinyint)
        AS "NUMERIC_PRECISION",

      CAST(
        information_schema_tsql._pgtsql_numeric_precision_radix(information_schema_tsql._pgtsql_truetypid(nt, a, t),
          information_schema_tsql._pgtsql_truetypmod(nt, a, t))
        AS smallint)
        AS "NUMERIC_PRECISION_RADIX",

      CAST(
        information_schema_tsql._pgtsql_numeric_scale(information_schema_tsql._pgtsql_truetypid(nt, a, t),
          information_schema_tsql._pgtsql_truetypmod(nt, a, t))
        AS int)
        AS "NUMERIC_SCALE",

      CAST(
        information_schema_tsql._pgtsql_datetime_precision(sys.translate_pg_type_to_tsql(information_schema_tsql._pgtsql_truetypid(nt, a, t)),
          information_schema_tsql._pgtsql_truetypmod(nt, a, t))
        AS smallint)
        AS "DATETIME_PRECISION",

      CAST(null AS sys.nvarchar(128)) AS "CHARACTER_SET_CATALOG",
      CAST(null AS sys.nvarchar(128)) AS "CHARACTER_SET_SCHEMA",
      /*
       * TODO: We need to first create mapping of collation name to char-set name;
       * Until then return null.
       */
      CAST(null AS sys.nvarchar(128)) AS "CHARACTER_SET_NAME",

      CAST(NULL as sys.nvarchar(128)) AS "COLLATION_CATALOG",
      CAST(NULL as sys.nvarchar(128)) AS "COLLATION_SCHEMA",

      /* Returns Babelfish specific collation name. */
      CAST(co.collname AS sys.nvarchar(128)) AS "COLLATION_NAME",

      CAST(CASE WHEN t.typtype = 'd' AND nt.nspname <> 'pg_catalog' AND nt.nspname <> 'sys'
        THEN nc.dbname ELSE null END
        AS sys.nvarchar(128)) AS "DOMAIN_CATALOG",
      CAST(CASE WHEN t.typtype = 'd' AND nt.nspname <> 'pg_catalog' AND nt.nspname <> 'sys'
        THEN ext.orig_name ELSE null END
        AS sys.nvarchar(128)) AS "DOMAIN_SCHEMA",
      CAST(CASE WHEN t.typtype = 'd' AND nt.nspname <> 'pg_catalog' AND nt.nspname <> 'sys'
        THEN t.typname ELSE null END
        AS sys.nvarchar(128)) AS "DOMAIN_NAME"

  FROM (pg_attribute a LEFT JOIN pg_attrdef ad ON attrelid = adrelid AND attnum = adnum)
    JOIN (pg_class c JOIN sys.pg_namespace_ext nc ON (c.relnamespace = nc.oid)) ON a.attrelid = c.oid
    JOIN (pg_type t JOIN pg_namespace nt ON (t.typnamespace = nt.oid)) ON a.atttypid = t.oid
    LEFT JOIN (pg_type bt JOIN pg_namespace nbt ON (bt.typnamespace = nbt.oid))
      ON (t.typtype = 'd' AND t.typbasetype = bt.oid)
    LEFT JOIN pg_collation co on co.oid = a.attcollation
    LEFT OUTER JOIN sys.babelfish_namespace_ext ext on nc.nspname = ext.nspname

  WHERE (NOT pg_is_other_temp_schema(nc.oid))
    AND a.attnum > 0 AND NOT a.attisdropped
    AND c.relkind IN ('r', 'v', 'p')
    AND (pg_has_role(c.relowner, 'USAGE')
      OR has_column_privilege(c.oid, a.attnum,
                  'SELECT, INSERT, UPDATE, REFERENCES'))
    AND ext.dbid = cast(sys.db_id() as oid);
GRANT SELECT ON information_schema_tsql.columns TO PUBLIC;

CREATE VIEW information_schema_tsql.tables AS
  SELECT CAST(nc.dbname AS sys.nvarchar(128)) AS "TABLE_CATALOG",
       CAST(ext.orig_name AS sys.nvarchar(128)) AS "TABLE_SCHEMA",
       CAST(c.relname AS sys.sysname) AS "TABLE_NAME",

       CAST(
       CASE WHEN c.relkind IN ('r', 'p') THEN 'BASE TABLE'
          WHEN c.relkind = 'v' THEN 'VIEW'
          ELSE null END
       AS varchar(10)) AS "TABLE_TYPE"

  FROM sys.pg_namespace_ext nc JOIN pg_class c ON (nc.oid = c.relnamespace)
       LEFT OUTER JOIN sys.babelfish_namespace_ext ext on nc.nspname = ext.nspname

  WHERE c.relkind IN ('r', 'v', 'p')
    AND (NOT pg_is_other_temp_schema(nc.oid))
    AND (pg_has_role(c.relowner, 'USAGE')
      OR has_table_privilege(c.oid, 'SELECT, INSERT, UPDATE, DELETE, TRUNCATE, REFERENCES, TRIGGER')
      OR has_any_column_privilege(c.oid, 'SELECT, INSERT, UPDATE, REFERENCES') )
    AND ext.dbid = cast(sys.db_id() as oid);
GRANT SELECT ON information_schema_tsql.tables TO PUBLIC;

CREATE OR REPLACE VIEW sys.spt_columns_view_managed AS
SELECT
    o.object_id                     AS OBJECT_ID,
    isc."TABLE_CATALOG"::information_schema.sql_identifier               AS TABLE_CATALOG,
    isc."TABLE_SCHEMA"::information_schema.sql_identifier                AS TABLE_SCHEMA,
    o.name                          AS TABLE_NAME,
    c.name                          AS COLUMN_NAME,
    isc."ORDINAL_POSITION"::information_schema.cardinal_number           AS ORDINAL_POSITION,
    isc."COLUMN_DEFAULT"::information_schema.character_data              AS COLUMN_DEFAULT,
    isc."IS_NULLABLE"::information_schema.yes_or_no                      AS IS_NULLABLE,
    isc."DATA_TYPE"::information_schema.character_data                   AS DATA_TYPE,

    CAST (CASE WHEN isc."CHARACTER_MAXIMUM_LENGTH" < 0 THEN 0 ELSE isc."CHARACTER_MAXIMUM_LENGTH" END
    AS information_schema.cardinal_number) AS CHARACTER_MAXIMUM_LENGTH,

    CAST (CASE WHEN isc."CHARACTER_OCTET_LENGTH" < 0 THEN 0 ELSE isc."CHARACTER_OCTET_LENGTH" END
    AS information_schema.cardinal_number)      AS CHARACTER_OCTET_LENGTH,

    CAST (CASE WHEN isc."NUMERIC_PRECISION" < 0 THEN 0 ELSE isc."NUMERIC_PRECISION" END
    AS information_schema.cardinal_number)      AS NUMERIC_PRECISION,

    CAST (CASE WHEN isc."NUMERIC_PRECISION_RADIX" < 0 THEN 0 ELSE isc."NUMERIC_PRECISION_RADIX" END
    AS information_schema.cardinal_number)      AS NUMERIC_PRECISION_RADIX,

    CAST (CASE WHEN isc."NUMERIC_SCALE" < 0 THEN 0 ELSE isc."NUMERIC_SCALE" END
    AS information_schema.cardinal_number)      AS NUMERIC_SCALE,

    CAST (CASE WHEN isc."DATETIME_PRECISION" < 0 THEN 0 ELSE isc."DATETIME_PRECISION" END
    AS information_schema.cardinal_number)      AS DATETIME_PRECISION,

    isc."CHARACTER_SET_CATALOG"::information_schema.sql_identifier       AS CHARACTER_SET_CATALOG,
    isc."CHARACTER_SET_SCHEMA"::information_schema.sql_identifier        AS CHARACTER_SET_SCHEMA,
    isc."CHARACTER_SET_NAME"::information_schema.sql_identifier          AS CHARACTER_SET_NAME,
    isc."COLLATION_CATALOG"::information_schema.sql_identifier           AS COLLATION_CATALOG,
    isc."COLLATION_SCHEMA"::information_schema.sql_identifier            AS COLLATION_SCHEMA,
    c.collation_name                                                     AS COLLATION_NAME,
    isc."DOMAIN_CATALOG"::information_schema.sql_identifier              AS DOMAIN_CATALOG,
    isc."DOMAIN_SCHEMA"::information_schema.sql_identifier               AS DOMAIN_SCHEMA,
    isc."DOMAIN_NAME"::information_schema.sql_identifier                 AS DOMAIN_NAME,
    c.is_sparse                     AS IS_SPARSE,
    c.is_column_set                 AS IS_COLUMN_SET,
    c.is_filestream                 AS IS_FILESTREAM
FROM
    sys.objects o JOIN sys.columns c ON
        (
            c.object_id = o.object_id and
            o.type in ('U', 'V')  -- limit columns to tables and views
        )
    LEFT JOIN information_schema_tsql.columns isc ON
        (
            sys.schema_name(o.schema_id) = isc."TABLE_SCHEMA" and
            o.name = isc."TABLE_NAME" and
            c.name = isc."COLUMN_NAME"
        )
    WHERE CAST("COLUMN_NAME" AS sys.nvarchar(128)) NOT IN ('cmin', 'cmax', 'xmin', 'xmax', 'ctid', 'tableoid');
GRANT SELECT ON sys.spt_columns_view_managed TO PUBLIC;

CREATE OR REPLACE FUNCTION sys.sp_columns_managed_internal(
    in_catalog sys.nvarchar(128), 
    in_owner sys.nvarchar(128),
    in_table sys.nvarchar(128),
    in_column sys.nvarchar(128),
    in_schematype int)
RETURNS TABLE (
    out_table_catalog sys.nvarchar(128),
    out_table_schema sys.nvarchar(128),
    out_table_name sys.nvarchar(128),
    out_column_name sys.nvarchar(128),
    out_ordinal_position int,
    out_column_default sys.nvarchar(4000),
    out_is_nullable sys.nvarchar(3),
    out_data_type sys.nvarchar,
    out_character_maximum_length int,
    out_character_octet_length int,
    out_numeric_precision int,
    out_numeric_precision_radix int,
    out_numeric_scale int,
    out_datetime_precision int,
    out_character_set_catalog sys.nvarchar(128),
    out_character_set_schema sys.nvarchar(128),
    out_character_set_name sys.nvarchar(128),
    out_collation_catalog sys.nvarchar(128),
    out_is_sparse int,
    out_is_column_set int,
    out_is_filestream int
    )
AS
$$
BEGIN
    RETURN QUERY 
        SELECT CAST(table_catalog AS sys.nvarchar(128)),
            CAST(table_schema AS sys.nvarchar(128)),
            CAST(table_name AS sys.nvarchar(128)),
            CAST(column_name AS sys.nvarchar(128)),
            CAST(ordinal_position AS int),
            CAST(column_default AS sys.nvarchar(4000)),
            CAST(is_nullable AS sys.nvarchar(3)),
            CAST(data_type AS sys.nvarchar),
            CAST(character_maximum_length AS int),
            CAST(character_octet_length AS int),
            CAST(numeric_precision AS int),
            CAST(numeric_precision_radix AS int),
            CAST(numeric_scale AS int),
            CAST(datetime_precision AS int),
            CAST(character_set_catalog AS sys.nvarchar(128)),
            CAST(character_set_schema AS sys.nvarchar(128)),
            CAST(character_set_name AS sys.nvarchar(128)),
            CAST(collation_catalog AS sys.nvarchar(128)),
            CAST(is_sparse AS int),
            CAST(is_column_set AS int),
            CAST(is_filestream AS int)
        FROM sys.spt_columns_view_managed s_cv
        WHERE
        (in_catalog IS NULL OR s_cv.TABLE_CATALOG LIKE LOWER(in_catalog)) AND
        (in_owner IS NULL OR s_cv.TABLE_SCHEMA LIKE LOWER(in_owner)) AND
        (in_table IS NULL OR s_cv.TABLE_NAME LIKE LOWER(in_table)) AND
        (in_column IS NULL OR s_cv.COLUMN_NAME LIKE LOWER(in_column)) AND
        (in_schematype = 0 AND (s_cv.IS_SPARSE = 0) OR in_schematype = 1 OR in_schematype = 2 AND (s_cv.IS_SPARSE = 1));
END;
$$
language plpgsql;

CREATE OR REPLACE PROCEDURE sys.sp_columns_managed
(
    "@Catalog"          nvarchar(128) = NULL,
    "@Owner"            nvarchar(128) = NULL,
    "@Table"            nvarchar(128) = NULL,
    "@Column"           nvarchar(128) = NULL,
    "@SchemaType"       nvarchar(128) = 0)        --  0 = 'select *' behavior (default), 1 = all columns, 2 = columnset columns
AS
$$
BEGIN
    SELECT
        out_TABLE_CATALOG AS TABLE_CATALOG,
        out_TABLE_SCHEMA AS TABLE_SCHEMA,
        out_TABLE_NAME AS TABLE_NAME,
        out_COLUMN_NAME AS COLUMN_NAME,
        out_ORDINAL_POSITION AS ORDINAL_POSITION,
        out_COLUMN_DEFAULT AS COLUMN_DEFAULT,
        out_IS_NULLABLE AS IS_NULLABLE,
        out_DATA_TYPE AS DATA_TYPE,
        out_CHARACTER_MAXIMUM_LENGTH AS CHARACTER_MAXIMUM_LENGTH,
        out_CHARACTER_OCTET_LENGTH AS CHARACTER_OCTET_LENGTH,
        out_NUMERIC_PRECISION AS NUMERIC_PRECISION,
        out_NUMERIC_PRECISION_RADIX AS NUMERIC_PRECISION_RADIX,
        out_NUMERIC_SCALE AS NUMERIC_SCALE,
        out_DATETIME_PRECISION AS DATETIME_PRECISION,
        out_CHARACTER_SET_CATALOG AS CHARACTER_SET_CATALOG,
        out_CHARACTER_SET_SCHEMA AS CHARACTER_SET_SCHEMA,
        out_CHARACTER_SET_NAME AS CHARACTER_SET_NAME,
        out_COLLATION_CATALOG AS COLLATION_CATALOG,
        out_IS_SPARSE AS IS_SPARSE,
        out_IS_COLUMN_SET AS IS_COLUMN_SET,
        out_IS_FILESTREAM AS IS_FILESTREAM
    FROM
        sys.sp_columns_managed_internal(@Catalog, @Owner, @Table, @Column, @SchemaType) s_cv
    ORDER BY TABLE_CATALOG, TABLE_SCHEMA, TABLE_NAME, IS_NULLABLE;
END;
$$
LANGUAGE 'pltsql';
GRANT ALL on PROCEDURE sys.sp_columns_managed TO PUBLIC;

CREATE OR REPLACE FUNCTION sys.tsql_stat_get_activity(
  IN view_name text,
  OUT procid int,
  OUT client_version int,
  OUT library_name VARCHAR(32),
  OUT language VARCHAR(128),
  OUT quoted_identifier bool,
  OUT arithabort bool,
  OUT ansi_null_dflt_on bool,
  OUT ansi_defaults bool,
  OUT ansi_warnings bool,
  OUT ansi_padding bool,
  OUT ansi_nulls bool,
  OUT concat_null_yields_null bool,
  OUT textsize int,
  OUT datefirst int,
  OUT lock_timeout int,
  OUT transaction_isolation int2,
  OUT client_pid int,
  OUT row_count bigint,
  OUT error int,
  OUT trancount int,
  OUT protocol_version int,
  OUT packet_size int,
  OUT encrypyt_option VARCHAR(40),
  OUT database_id int2)
AS 'babelfishpg_tsql', 'tsql_stat_get_activity'
LANGUAGE C VOLATILE STRICT;

create or replace view sys.dm_exec_sessions
  as
  select a.pid as session_id
    , a.backend_start::sys.datetime as login_time
    , a.client_hostname::sys.nvarchar(128) as host_name
    , a.application_name::sys.nvarchar(128) as program_name
    , d.client_pid as host_process_id
    , d.client_version as client_version
    , d.library_name::sys.nvarchar(32) as client_interface_name
    , null::sys.varbinary(85) as security_id
    , a.usename::sys.nvarchar(128) as login_name
    , (select sys.default_domain())::sys.nvarchar(128) as nt_domain
    , null::sys.nvarchar(128) as nt_user_name
    , a.state::sys.nvarchar(30) as status
    , null::sys.nvarchar(128) as context_info
    , null::integer as cpu_time
    , null::integer as memory_usage
    , null::integer as total_scheduled_time
    , null::integer as total_elapsed_time
    , a.client_port as endpoint_id
    , a.query_start::sys.datetime as last_request_start_time
    , a.state_change::sys.datetime as last_request_end_time
    , null::bigint as "reads"
    , null::bigint as "writes"
    , null::bigint as logical_reads
    , case when a.client_port > 0 then 1::sys.bit else 0::sys.bit end as is_user_process
    , d.textsize as text_size
    , d.language::sys.nvarchar(128) as language
    , 'ymd'::sys.nvarchar(3) as date_format-- Bld 173 lacks support for SET DATEFORMAT and always expects ymd
    , d.datefirst::smallint as date_first -- Bld 173 lacks support for SET DATEFIRST and always returns 7
    , d.quoted_identifier as quoted_identifier
    , d.arithabort as arithabort
    , d.ansi_null_dflt_on as ansi_null_dflt_on
    , d.ansi_defaults as ansi_defaults
    , d.ansi_warnings as ansi_warnings
    , d.ansi_padding as ansi_padding
    , d.ansi_nulls as ansi_nulls
    , d.concat_null_yields_null as concat_null_yields_null
    , d.transaction_isolation::smallint as transaction_isolation_level
    , d.lock_timeout as lock_timeout
    , 0 as deadlock_priority
    , d.row_count as row_count
    , d.error as prev_error
    , null::sys.varbinary(85) as original_security_id
    , a.usename::sys.nvarchar(128) as original_login_name
    , null::sys.datetime as last_successful_logon
    , null::sys.datetime as last_unsuccessful_logon
    , null::bigint as unsuccessful_logons
    , null::int as group_id
    , d.database_id::smallint as database_id
    , 0 as authenticating_database_id
    , d.trancount as open_transaction_count
  from pg_catalog.pg_stat_activity AS a
  RIGHT JOIN sys.tsql_stat_get_activity('sessions') AS d ON (a.pid = d.procid);
  GRANT SELECT ON sys.dm_exec_sessions TO PUBLIC;

create or replace view sys.dm_exec_connections
 as
 select a.pid as session_id
   , a.pid as most_recent_session_id
   , a.backend_start::sys.datetime as connect_time
   , 'TCP'::sys.nvarchar(40) as net_transport
   , 'TSQL'::sys.nvarchar(40) as protocol_type
   , d.protocol_version as protocol_version
   , a.client_port as endpoint_id
   , d.encrypyt_option::sys.nvarchar(40) as encrypt_option
   , null::sys.nvarchar(40) as auth_scheme
   , null::smallint as node_affinity
   , null::int as num_reads
   , null::int as num_writes
   , null::sys.datetime as last_read
   , null::sys.datetime as last_write
   , d.packet_size as net_packet_size
   , a.client_addr::varchar(48) as client_net_address
   , a.client_port as client_tcp_port
   , null::varchar(48) as local_net_address
   , null::int as local_tcp_port
   , null::sys.uniqueidentifier as connection_id
   , null::sys.uniqueidentifier as parent_connection_id
   , a.pid::sys.varbinary(64) as most_recent_sql_handle
 from pg_catalog.pg_stat_activity AS a
 RIGHT JOIN sys.tsql_stat_get_activity('connections') AS d ON (a.pid = d.procid);
 GRANT SELECT ON sys.dm_exec_connections TO PUBLIC;

create or replace view sys.sysprocesses as
select
  a.pid as spid
  , null::integer as kpid
  , coalesce(blocking_activity.pid, 0) as blocked
  , null::bytea as waittype
  , 0 as waittime
  , a.wait_event_type as lastwaittype
  , null::text as waitresource
  , coalesce(t.database_id, a.datid) as dbid
  , a.usesysid as uid
  , 0 as cpu
  , 0 as physical_io
  , 0 as memusage
  , a.backend_start as login_time
  , a.query_start as last_batch
  , 0 as ecid
  , 0 as open_tran
  , a.state as status
  , null::bytea as sid
  , a.client_hostname as hostname
  , a.application_name as program_name
  , null::varchar(10) as hostprocess
  , a.query as cmd
  , null::varchar(128) as nt_domain
  , null::varchar(128) as nt_username
  , null::varchar(12) as net_address
  , null::varchar(12) as net_library
  , a.usename as loginname
  , null::bytea as context_info
  , null::bytea as sql_handle
  , 0 as stmt_start
  , 0 as stmt_end
  , 0 as request_id
from pg_stat_activity a
left join sys.tsql_stat_get_activity('sessions') as t on a.pid = t.procid
left join pg_catalog.pg_locks as blocked_locks on a.pid = blocked_locks.pid
left join pg_catalog.pg_locks         blocking_locks
        ON blocking_locks.locktype = blocked_locks.locktype
        AND blocking_locks.DATABASE IS NOT DISTINCT FROM blocked_locks.DATABASE
        AND blocking_locks.relation IS NOT DISTINCT FROM blocked_locks.relation
        AND blocking_locks.page IS NOT DISTINCT FROM blocked_locks.page
        AND blocking_locks.tuple IS NOT DISTINCT FROM blocked_locks.tuple
        AND blocking_locks.virtualxid IS NOT DISTINCT FROM blocked_locks.virtualxid
        AND blocking_locks.transactionid IS NOT DISTINCT FROM blocked_locks.transactionid
        AND blocking_locks.classid IS NOT DISTINCT FROM blocked_locks.classid
        AND blocking_locks.objid IS NOT DISTINCT FROM blocked_locks.objid
        AND blocking_locks.objsubid IS NOT DISTINCT FROM blocked_locks.objsubid
        AND blocking_locks.pid != blocked_locks.pid
 left join pg_catalog.pg_stat_activity blocking_activity ON blocking_activity.pid = blocking_locks.pid;
GRANT SELECT ON sys.sysprocesses TO PUBLIC;

-- Reset search_path to not affect any subsequent scripts
SELECT set_config('search_path', trim(leading 'sys, ' from current_setting('search_path')), false);
