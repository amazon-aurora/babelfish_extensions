#include "postgres.h"
#include "fmgr.h"
#include "utils/builtins.h"
#include "utils/memutils.h"
#include "fts_data.h"

PG_FUNCTION_INFO_V1(babelfish_fts_rewrite);

Datum 
babelfish_fts_rewrite(PG_FUNCTION_ARGS)
{
    text* input_text = PG_GETARG_TEXT_P(0);
    char* input_str = text_to_cstring(input_text);
    char* translated_query;
    text* result_text = NULL; // Initialize result_text to NULL
    
    PG_TRY();
    {
        // Switch to a suitable memory context if necessary
        if (!CurrentMemoryContext) {
            MemoryContextSwitchTo(TopMemoryContext);
        }
        fts_scanner_init(input_str);

        if (fts_yyparse(&translated_query) != 0)
            fts_yyerror(&translated_query, "fts parser failed");

        fts_scanner_finish();
    }
    PG_CATCH();
    {
        // Handle errors and reset memory context if needed
        if (translated_query) {
            pfree(translated_query);
        }
        PG_RE_THROW();
    }
    PG_END_TRY();

    if (translated_query) {
        result_text = cstring_to_text(translated_query);
    }

    // Make sure to free allocated memory
    pfree(input_str);

    if (result_text) {
        PG_RETURN_TEXT_P(result_text);
    } else {
        PG_RETURN_NULL();
    }
}
