/*-------------------------------------------------------------------------
 *
 * json_funcs.c
 *   JSON function support for Babelfish
 *
 *-------------------------------------------------------------------------
 */
#include "postgres.h"

#include "common/jsonapi.h"
#include "catalog/pg_type.h"
#include "utils/builtins.h"
#include "utils/json.h"
#include "utils/jsonb.h"
#include "utils/jsonfuncs.h"
#include "parser/parser.h"
#include "utils/jsonpath.h"
#include "utils/varlena.h"
#include "catalog/pg_collation_d.h"

Datum tsql_jsonb_in(text *json_text);
Datum tsql_jsonb_path_query_first(Datum jsonb_datum, Datum jsonpath_datum);
JsonParseErrorType tsql_parse_json(text *json_text, JsonLexContext *lex, JsonSemAction *sem);

PG_FUNCTION_INFO_V1(tsql_isjson);
PG_FUNCTION_INFO_V1(tsql_json_value);
PG_FUNCTION_INFO_V1(tsql_json_query);

/*
 * tsql_isjson()
 *
 * Returns 1 if the string contains valid JSON; otherwise, returns 0. 
 * 
 * Returns null if expression is null and does not return errors.
 */
Datum
tsql_isjson(PG_FUNCTION_ARGS)
{
    JsonParseErrorType result;
    JsonLexContext *lex;
    text           *json_text = PG_GETARG_TEXT_PP(0);

    /* set up lex context and parse json expression */
    lex = makeJsonLexContext(json_text, false);
    result = tsql_parse_json(json_text, lex, &nullSemAction);

    PG_RETURN_INT32((result == JSON_SUCCESS) ? 1 : 0);
}

/*
 * tsql_parse_json()
 *
 * Wrapper around PG json parser, pg_parse_json(), with additional logic
 * to handle edge case where input expression is bare scalar
 */
JsonParseErrorType
tsql_parse_json(text *json_text, JsonLexContext *lex, JsonSemAction *sem)
{   
    JsonParseErrorType result_first_token;
    JsonLexContext *lex_first_token;
    JsonTokenType tok;

    /* Short circuit when first token is scalar */
    lex_first_token = makeJsonLexContext(json_text, false);
	result_first_token = json_lex(lex_first_token);
	tok = lex_first_token->token_type;
    if (result_first_token != JSON_SUCCESS || 
        (tok != JSON_TOKEN_OBJECT_START && tok != JSON_TOKEN_ARRAY_START))
        return JSON_EXPECTED_JSON;
    
    /* validate rest of json expression */
    return pg_parse_json(lex, sem);
}

/*
 * tsql_jsonb_in
 *
 * Turns json string into a jsonb Datum.
 *
 * Uses the json parser (with hooks) to construct a jsonb.
 */
Datum
tsql_jsonb_in(text *json_text)
{
	JsonParseErrorType result_first_token;
    JsonLexContext *lex_first_token;
    JsonTokenType tok;

    /* Short circuit when first token is scalar */
    lex_first_token = makeJsonLexContext(json_text, false);
	result_first_token = json_lex(lex_first_token);
	tok = lex_first_token->token_type;
	if (result_first_token != JSON_SUCCESS || 
		(tok != JSON_TOKEN_OBJECT_START && tok != JSON_TOKEN_ARRAY_START))
		json_ereport_error(JSON_EXPECTED_JSON, lex_first_token);
	
	/* convert json expression to jsonb */
	return DirectFunctionCall1(jsonb_in, CStringGetDatum(text_to_cstring(json_text)));
}

/*
 * tsql_json_value()
 *
 * Extracts a scalar value from a json expression string
 * 
 * 'json_text' - target document for jsonpath evaluation
 * 'jsonpath_text' - jsonpath to be executed
 */
Datum
tsql_json_value(PG_FUNCTION_ARGS)
{
	
	text	*json_text,
			*jsonpath_text;
	char	*result_cstring;
	Datum	result,
			jsonb,
			jsonpath;
	Jsonb	*result_jsonb;
	VarChar *result_varchar;
	bool	islax;
	int		prev_sql_dialect;

	if (PG_ARGISNULL(0))
		PG_RETURN_NULL();
	if (PG_ARGISNULL(1))
		elog(ERROR, "The JSON_VALUE function requires 2 arguments");

	/* set sql_dialect to tsql, which is needed for jsonb parsing and processing */
	sql_dialect = SQL_DIALECT_TSQL;
	prev_sql_dialect = sql_dialect;

	/* read in arguments */
	json_text = PG_GETARG_TEXT_PP(0);
	jsonb = tsql_jsonb_in(json_text);
	jsonpath_text = PG_GETARG_TEXT_PP(1);
	jsonpath = DirectFunctionCall1(jsonpath_in, CStringGetDatum(text_to_cstring(jsonpath_text)));

	/* jsonb_path_query_first */
	result = tsql_jsonb_path_query_first(jsonb, jsonpath);

	/* reset sql_dialect */
	sql_dialect = prev_sql_dialect;

	/* Check for null result */
	if (!result)
		PG_RETURN_NULL();

	islax = (DatumGetJsonPathP(jsonpath)->header & JSONPATH_LAX) != 0;
	result_jsonb = DatumGetJsonbP(result);
	/* check value is scalar */
	if (result_jsonb && JB_ROOT_IS_SCALAR(result_jsonb))
	{
        /* handle cases where value is greater than 4000 characters */
        result_cstring = JsonbToCString(NULL, &result_jsonb->root, -1);
        if (strlen(result_cstring) > 4000)
        {
            if (islax)
                PG_RETURN_NULL();
            else 
                elog(ERROR, "The JSON_VALUE function requires 2 arguments");
        }
        result_varchar = (VarChar *) cstring_to_text(result_cstring);
        PG_RETURN_VARCHAR_P(result_varchar);
	} 
	/* result is not a scalar value */
	else if (!islax) 
		elog(ERROR, "Scalar value cannot be found in the specified JSON path.");
	
	PG_RETURN_NULL();
}

/*
 * tsql_json_query()
 *
 * Extracts a json object or array from a json expression string
 * 
 * 'json_text' - target document for jsonpath evaluation
 * 'jsonpath_text' - jsonpath to be executed
 */
Datum
tsql_json_query(PG_FUNCTION_ARGS)
{
	text	*json_text,
			*jsonpath_text;
	Datum	result,
			jsonb,
			jsonpath;
	Jsonb	*result_jsonb;
	VarChar *result_varchar;
	bool islax;
	int		prev_sql_dialect;

	if (PG_ARGISNULL(0))
		PG_RETURN_NULL();

	/* set sql_dialect to tsql, which is needed for jsonb parsing and processing */
	sql_dialect = SQL_DIALECT_TSQL;
	prev_sql_dialect = sql_dialect;

	/* read in arguments */
	json_text = PG_GETARG_TEXT_PP(0);
	jsonb = tsql_jsonb_in(json_text);
	jsonpath_text = PG_ARGISNULL(1) ? cstring_to_text("$") : PG_GETARG_TEXT_PP(1);
	jsonpath = DirectFunctionCall1(jsonpath_in, CStringGetDatum(text_to_cstring(jsonpath_text)));

	/* jsonb_path_query_first */
	result = tsql_jsonb_path_query_first(jsonb, jsonpath);

	/* reset sql_dialect */
	sql_dialect = prev_sql_dialect;

	/* Check for null result*/
	if (!result)
		PG_RETURN_NULL();

	islax = (DatumGetJsonPathP(jsonpath)->header & JSONPATH_LAX) != 0;
	result_jsonb = DatumGetJsonbP(result);
    /* check if value is json object or array */
    if (result_jsonb 
        && !JB_ROOT_IS_SCALAR(result_jsonb) 
        && (JB_ROOT_IS_OBJECT(result_jsonb) || JB_ROOT_IS_ARRAY(result_jsonb)))
    {
        result_varchar = (VarChar *) cstring_to_text(JsonbToCString(NULL, &result_jsonb->root, -1));
        PG_RETURN_VARCHAR_P(result_varchar);
    } 
	/* result is not an array or object */
	else if (!islax)
		elog(ERROR, "Object or array cannot be found in the specified JSON path.");

    PG_RETURN_NULL();
}

Datum
tsql_jsonb_path_query_first(Datum jsonb_datum, Datum jsonpath_datum)
{
	LOCAL_FCINFO(fcinfo, 4);
	Datum	result,
			vars;

	vars = DirectFunctionCall1(jsonb_in, CStringGetDatum("{}"));

	InitFunctionCallInfoData(*fcinfo, NULL, 4, PG_GET_COLLATION(), NULL, NULL);

	fcinfo->args[0].value = jsonb_datum;
	fcinfo->args[0].isnull = false;
	fcinfo->args[1].value = jsonpath_datum;
	fcinfo->args[1].isnull = false;
	fcinfo->args[2].value = vars;
	fcinfo->args[2].isnull = false;
	fcinfo->args[3].value = false;
	fcinfo->args[3].isnull = false;

	result = (*jsonb_path_query_first) (fcinfo);

	return result;
}
