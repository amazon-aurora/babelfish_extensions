\echo Use "ALTER EXTENSION ""babelfishpg_common"" UPDATE TO "6.0.0"" to load this file. \quit
SELECT set_config('search_path', 'sys, '||current_setting('search_path'), false);

-- Placeholder for 6.0.0 upgrade changes
-- Add upgrade logic here as needed

SELECT set_config('search_path', trim(leading 'sys, ' from current_setting('search_path')), false);