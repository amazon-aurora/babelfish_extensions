-- FOR JSON PATH CLAUSE with nested json support for existing objects
DROP VIEW forjson_nesting_vu_v_users
GO

DROP VIEW forjson_nesting_vu_v_products
GO

DROP VIEW forjson_nesting_vu_v_orders
GO

-- FOR JSON PATH support for multiple layers of nested JSON objects
DROP VIEW forjson_nesting_vu_v_deep
GO

-- FOR JSON PATH support for multiple layers of nested JSON objects w/ join
DROP VIEW forjson_nesting_vu_v_join_deep
GO

-- FOR JSON PATH Support for key-values being inserted into mid layer of multi-layered JSON object
DROP VIEW forjson_nesting_vu_v_layered_insert
GO

-- Error related to inserting value at Json object location
DROP VIEW forjson_nesting_vu_v_error
GO

-- DROP Tables
DROP TABLE forjson_nesting_vu_t_users
GO

DROP TABLE forjson_nesting_vu_t_products
GO

DROP TABLE forjson_nesting_vu_t_orders
GO
