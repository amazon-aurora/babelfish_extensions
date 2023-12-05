/*-------------------------------------------------------------------------
 *
 * gramparse.h
 *		Shared definitions for the "raw" parser (flex and bison phases only)
 *
 * NOTE: this file is only meant to be included in the core parsing files,
 * ie, parser.c, gram.y, scan.l, and src/common/keywords.c.
 * Definitions that are needed outside the core parser should be in parser.h.
 *
 *
 * Portions Copyright (c) 1996-2019, PostgreSQL Global Development Group
 * Portions Copyright (c) 1994, Regents of the University of California
 *
 * src/include/parser/gramparse.h
 *
 *-------------------------------------------------------------------------
 */

#ifndef PGTSQL_GRAMPARSE_H
#define PGTSQL_GRAMPARSE_H

#include "src/backend_parser/scanner.h"

/*
 * NB: include gram-backend.h only AFTER including scanner.h, because scanner.h
 * is what #defines YYLTYPE.
 */
#include "src/backend_parser/gram-backend.h"

/*
 * NB: include gramparse.h after including gram-backend.h so that pgtsql token number is used properly
 * Community has hidden gramparse.h from header symbols, so manually import all its definitions here
 */

#ifndef GRAMPARSE_H
#define GRAMPARSE_H

#ifndef YY_BASE_YY_GRAM_H_INCLUDED
# define YY_BASE_YY_GRAM_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int base_yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    IDENT = 258,
    UIDENT = 259,
    FCONST = 260,
    SCONST = 261,
    USCONST = 262,
    BCONST = 263,
    XCONST = 264,
    Op = 265,
    ICONST = 266,
    PARAM = 267,
    TYPECAST = 268,
    DOT_DOT = 269,
    COLON_EQUALS = 270,
    EQUALS_GREATER = 271,
    LESS_EQUALS = 272,
    GREATER_EQUALS = 273,
    NOT_EQUALS = 274,
    DIALECT_TSQL = 275,
    TSQL_XCONST = 276,
    TSQL_LABEL = 277,
    ABORT_P = 278,
    ABSOLUTE_P = 279,
    ACCESS = 280,
    ACTION = 281,
    ADD_P = 282,
    ADMIN = 283,
    AFTER = 284,
    AGGREGATE = 285,
    ALL = 286,
    ALSO = 287,
    ALTER = 288,
    ALWAYS = 289,
    ANALYSE = 290,
    ANALYZE = 291,
    AND = 292,
    ANY = 293,
    ARRAY = 294,
    AS = 295,
    ASC = 296,
    ASENSITIVE = 297,
    ASSERTION = 298,
    ASSIGNMENT = 299,
    ASYMMETRIC = 300,
    ATOMIC = 301,
    AT = 302,
    ATTACH = 303,
    ATTRIBUTE = 304,
    AUTHORIZATION = 305,
    BACKWARD = 306,
    BEFORE = 307,
    BEGIN_P = 308,
    BETWEEN = 309,
    BIGINT = 310,
    BINARY = 311,
    BIT = 312,
    BOOLEAN_P = 313,
    BOTH = 314,
    BREADTH = 315,
    BY = 316,
    CACHE = 317,
    CALL = 318,
    CALLED = 319,
    CASCADE = 320,
    CASCADED = 321,
    CASE = 322,
    CAST = 323,
    CATALOG_P = 324,
    CHAIN = 325,
    CHAR_P = 326,
    CHARACTER = 327,
    CHARACTERISTICS = 328,
    CHECK = 329,
    CHECKPOINT = 330,
    CLASS = 331,
    CLOSE = 332,
    CLUSTER = 333,
    COALESCE = 334,
    COLLATE = 335,
    COLLATION = 336,
    COLUMN = 337,
    COLUMNS = 338,
    COMMENT = 339,
    COMMENTS = 340,
    COMMIT = 341,
    COMMITTED = 342,
    COMPRESSION = 343,
    CONCURRENTLY = 344,
    CONFIGURATION = 345,
    CONFLICT = 346,
    CONNECTION = 347,
    CONSTRAINT = 348,
    CONSTRAINTS = 349,
    CONTENT_P = 350,
    CONTINUE_P = 351,
    CONVERSION_P = 352,
    COPY = 353,
    COST = 354,
    CREATE = 355,
    CROSS = 356,
    CSV = 357,
    CUBE = 358,
    CURRENT_P = 359,
    CURRENT_CATALOG = 360,
    CURRENT_DATE = 361,
    CURRENT_ROLE = 362,
    CURRENT_SCHEMA = 363,
    CURRENT_TIME = 364,
    CURRENT_TIMESTAMP = 365,
    CURRENT_USER = 366,
    CURSOR = 367,
    CYCLE = 368,
    DATA_P = 369,
    DATABASE = 370,
    DAY_P = 371,
    DEALLOCATE = 372,
    DEC = 373,
    DECIMAL_P = 374,
    DECLARE = 375,
    DEFAULT = 376,
    DEFAULTS = 377,
    DEFERRABLE = 378,
    DEFERRED = 379,
    DEFINER = 380,
    DELETE_P = 381,
    DELIMITER = 382,
    DELIMITERS = 383,
    DEPENDS = 384,
    DEPTH = 385,
    DESC = 386,
    DETACH = 387,
    DICTIONARY = 388,
    DISABLE_P = 389,
    DISCARD = 390,
    DISTINCT = 391,
    DO = 392,
    DOCUMENT_P = 393,
    DOMAIN_P = 394,
    DOUBLE_P = 395,
    DROP = 396,
    EACH = 397,
    ELSE = 398,
    ENABLE_P = 399,
    ENCODING = 400,
    ENCRYPTED = 401,
    END_P = 402,
    ENUM_P = 403,
    ESCAPE = 404,
    EVENT = 405,
    EXCEPT = 406,
    EXCLUDE = 407,
    EXCLUDING = 408,
    EXCLUSIVE = 409,
    EXECUTE = 410,
    EXISTS = 411,
    EXPLAIN = 412,
    EXPRESSION = 413,
    EXTENSION = 414,
    EXTERNAL = 415,
    EXTRACT = 416,
    FALSE_P = 417,
    FAMILY = 418,
    FETCH = 419,
    FILTER = 420,
    FINALIZE = 421,
    FIRST_P = 422,
    FLOAT_P = 423,
    FOLLOWING = 424,
    FOR = 425,
    FORCE = 426,
    FOREIGN = 427,
    FORWARD = 428,
    FREEZE = 429,
    FROM = 430,
    FULL = 431,
    FUNCTION = 432,
    FUNCTIONS = 433,
    GENERATED = 434,
    GLOBAL = 435,
    GRANT = 436,
    GRANTED = 437,
    GREATEST = 438,
    GROUP_P = 439,
    GROUPING = 440,
    GROUPS = 441,
    HANDLER = 442,
    HAVING = 443,
    HEADER_P = 444,
    HOLD = 445,
    HOUR_P = 446,
    IDENTITY_P = 447,
    IF_P = 448,
    ILIKE = 449,
    IMMEDIATE = 450,
    IMMUTABLE = 451,
    IMPLICIT_P = 452,
    IMPORT_P = 453,
    IN_P = 454,
    INCLUDE = 455,
    INCLUDING = 456,
    INCREMENT = 457,
    INDEX = 458,
    INDEXES = 459,
    INHERIT = 460,
    INHERITS = 461,
    INITIALLY = 462,
    INLINE_P = 463,
    INNER_P = 464,
    INOUT = 465,
    INPUT_P = 466,
    INSENSITIVE = 467,
    INSERT = 468,
    INSTEAD = 469,
    INT_P = 470,
    INTEGER = 471,
    INTERSECT = 472,
    INTERVAL = 473,
    INTO = 474,
    INVOKER = 475,
    IS = 476,
    ISNULL = 477,
    ISOLATION = 478,
    JOIN = 479,
    KEY = 480,
    LABEL = 481,
    LANGUAGE = 482,
    LARGE_P = 483,
    LAST_P = 484,
    LATERAL_P = 485,
    LEADING = 486,
    LEAKPROOF = 487,
    LEAST = 488,
    LEFT = 489,
    LEVEL = 490,
    LIKE = 491,
    LIMIT = 492,
    LISTEN = 493,
    LOAD = 494,
    LOCAL = 495,
    LOCALTIME = 496,
    LOCALTIMESTAMP = 497,
    LOCATION = 498,
    LOCK_P = 499,
    LOCKED = 500,
    LOGGED = 501,
    MAPPING = 502,
    MATCH = 503,
    MATCHED = 504,
    MATERIALIZED = 505,
    MAXVALUE = 506,
    MERGE = 507,
    METHOD = 508,
    MINUTE_P = 509,
    MINVALUE = 510,
    MODE = 511,
    MONTH_P = 512,
    MOVE = 513,
    NAME_P = 514,
    NAMES = 515,
    NATIONAL = 516,
    NATURAL = 517,
    NCHAR = 518,
    NEW = 519,
    NEXT = 520,
    NFC = 521,
    NFD = 522,
    NFKC = 523,
    NFKD = 524,
    NO = 525,
    NONE = 526,
    NORMALIZE = 527,
    NORMALIZED = 528,
    NOT = 529,
    NOTHING = 530,
    NOTIFY = 531,
    NOTNULL = 532,
    NOWAIT = 533,
    NULL_P = 534,
    NULLIF = 535,
    NULLS_P = 536,
    NUMERIC = 537,
    OBJECT_P = 538,
    OF = 539,
    OFF = 540,
    OFFSET = 541,
    OIDS = 542,
    OLD = 543,
    ON = 544,
    ONLY = 545,
    OPERATOR = 546,
    OPTION = 547,
    OPTIONS = 548,
    OR = 549,
    ORDER = 550,
    ORDINALITY = 551,
    OTHERS = 552,
    OUT_P = 553,
    OUTER_P = 554,
    OVER = 555,
    OVERLAPS = 556,
    OVERLAY = 557,
    OVERRIDING = 558,
    OWNED = 559,
    OWNER = 560,
    PARALLEL = 561,
    PARAMETER = 562,
    PARSER = 563,
    PARTIAL = 564,
    PARTITION = 565,
    PASSING = 566,
    PASSWORD = 567,
    PLACING = 568,
    PLANS = 569,
    POLICY = 570,
    POSITION = 571,
    PRECEDING = 572,
    PRECISION = 573,
    PRESERVE = 574,
    PREPARE = 575,
    PREPARED = 576,
    PRIMARY = 577,
    PRIOR = 578,
    PRIVILEGES = 579,
    PROCEDURAL = 580,
    PROCEDURE = 581,
    PROCEDURES = 582,
    PROGRAM = 583,
    PUBLICATION = 584,
    QUOTE = 585,
    RANGE = 586,
    READ = 587,
    REAL = 588,
    REASSIGN = 589,
    RECHECK = 590,
    RECURSIVE = 591,
    REF_P = 592,
    REFERENCES = 593,
    REFERENCING = 594,
    REFRESH = 595,
    REINDEX = 596,
    RELATIVE_P = 597,
    RELEASE = 598,
    RENAME = 599,
    REPEATABLE = 600,
    REPLACE = 601,
    REPLICA = 602,
    RESET = 603,
    RESTART = 604,
    RESTRICT = 605,
    RETURN = 606,
    RETURNING = 607,
    RETURNS = 608,
    REVOKE = 609,
    RIGHT = 610,
    ROLE = 611,
    ROLLBACK = 612,
    ROLLUP = 613,
    ROUTINE = 614,
    ROUTINES = 615,
    ROW = 616,
    ROWS = 617,
    RULE = 618,
    SAVEPOINT = 619,
    SCHEMA = 620,
    SCHEMAS = 621,
    SCROLL = 622,
    SEARCH = 623,
    SECOND_P = 624,
    SECURITY = 625,
    SELECT = 626,
    SEQUENCE = 627,
    SEQUENCES = 628,
    SERIALIZABLE = 629,
    SERVER = 630,
    SESSION = 631,
    SESSION_USER = 632,
    SET = 633,
    SETS = 634,
    SETOF = 635,
    SHARE = 636,
    SHOW = 637,
    SIMILAR = 638,
    SIMPLE = 639,
    SKIP = 640,
    SMALLINT = 641,
    SNAPSHOT = 642,
    SOME = 643,
    SQL_P = 644,
    STABLE = 645,
    STANDALONE_P = 646,
    START = 647,
    STATEMENT = 648,
    STATISTICS = 649,
    STDIN = 650,
    STDOUT = 651,
    STORAGE = 652,
    STORED = 653,
    STRICT_P = 654,
    STRIP_P = 655,
    SUBSCRIPTION = 656,
    SUBSTRING = 657,
    SUPPORT = 658,
    SYMMETRIC = 659,
    SYSID = 660,
    SYSTEM_P = 661,
    TABLE = 662,
    TABLES = 663,
    TABLESAMPLE = 664,
    TABLESPACE = 665,
    TEMP = 666,
    TEMPLATE = 667,
    TEMPORARY = 668,
    TEXT_P = 669,
    THEN = 670,
    TIES = 671,
    TIME = 672,
    TIMESTAMP = 673,
    TO = 674,
    TRAILING = 675,
    TRANSACTION = 676,
    TRANSFORM = 677,
    TREAT = 678,
    TRIGGER = 679,
    TRIM = 680,
    TRUE_P = 681,
    TRUNCATE = 682,
    TRUSTED = 683,
    TYPE_P = 684,
    TYPES_P = 685,
    UESCAPE = 686,
    UNBOUNDED = 687,
    UNCOMMITTED = 688,
    UNENCRYPTED = 689,
    UNION = 690,
    UNIQUE = 691,
    UNKNOWN = 692,
    UNLISTEN = 693,
    UNLOGGED = 694,
    UNTIL = 695,
    UPDATE = 696,
    USER = 697,
    USING = 698,
    VACUUM = 699,
    VALID = 700,
    VALIDATE = 701,
    VALIDATOR = 702,
    VALUE_P = 703,
    VALUES = 704,
    VARCHAR = 705,
    VARIADIC = 706,
    VARYING = 707,
    VERBOSE = 708,
    VERSION_P = 709,
    VIEW = 710,
    VIEWS = 711,
    VOLATILE = 712,
    WHEN = 713,
    WHERE = 714,
    WHITESPACE_P = 715,
    WINDOW = 716,
    WITH = 717,
    WITHIN = 718,
    WITHOUT = 719,
    WORK = 720,
    WRAPPER = 721,
    WRITE = 722,
    XML_P = 723,
    XMLATTRIBUTES = 724,
    XMLCONCAT = 725,
    XMLELEMENT = 726,
    XMLEXISTS = 727,
    XMLFOREST = 728,
    XMLNAMESPACES = 729,
    XMLPARSE = 730,
    XMLPI = 731,
    XMLROOT = 732,
    XMLSERIALIZE = 733,
    XMLTABLE = 734,
    YEAR_P = 735,
    YES_P = 736,
    ZONE = 737,
    NOT_LA = 738,
    NULLS_LA = 739,
    WITH_LA = 740,
    MODE_TYPE_NAME = 741,
    MODE_PLPGSQL_EXPR = 742,
    MODE_PLPGSQL_ASSIGN1 = 743,
    MODE_PLPGSQL_ASSIGN2 = 744,
    MODE_PLPGSQL_ASSIGN3 = 745,
    UMINUS = 746
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 247 "gram.y" /* yacc.c:1909  */

	core_YYSTYPE core_yystype;
	/* these fields must match core_YYSTYPE: */
	int			ival;
	char	   *str;
	const char *keyword;

	char		chr;
	bool		boolean;
	JoinType	jtype;
	DropBehavior dbehavior;
	OnCommitAction oncommit;
	List	   *list;
	Node	   *node;
	ObjectType	objtype;
	TypeName   *typnam;
	FunctionParameter *fun_param;
	FunctionParameterMode fun_param_mode;
	ObjectWithArgs *objwithargs;
	DefElem	   *defelt;
	SortBy	   *sortby;
	WindowDef  *windef;
	JoinExpr   *jexpr;
	IndexElem  *ielem;
	StatsElem  *selem;
	Alias	   *alias;
	RangeVar   *range;
	IntoClause *into;
	WithClause *with;
	InferClause	*infer;
	OnConflictClause *onconflict;
	A_Indices  *aind;
	ResTarget  *target;
	struct PrivTarget *privtarget;
	AccessPriv *accesspriv;
	struct ImportQual *importqual;
	InsertStmt *istmt;
	VariableSetStmt *vsetstmt;
	PartitionElem *partelem;
	PartitionSpec *partspec;
	PartitionBoundSpec *partboundspec;
	RoleSpec   *rolespec;
	PublicationObjSpec *publicationobjectspec;
	struct SelectLimit *selectlimit;
	SetQuantifier setquantifier;
	struct GroupClause *groupclause;
	MergeWhenClause *mergewhen;
	struct KeyActions *keyactions;
	struct KeyAction *keyaction;

#line 597 "gram.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif

/* Location type.  */
#if ! defined YYLTYPE && ! defined YYLTYPE_IS_DECLARED
typedef struct YYLTYPE YYLTYPE;
struct YYLTYPE
{
  int first_line;
  int first_column;
  int last_line;
  int last_column;
};
# define YYLTYPE_IS_DECLARED 1
# define YYLTYPE_IS_TRIVIAL 1
#endif



int base_yyparse (core_yyscan_t yyscanner);

#endif /* !YY_BASE_YY_GRAM_H_INCLUDED  */

/*
 * The YY_EXTRA data that a flex scanner allows us to pass around.  Private
 * state needed for raw parsing/lexing goes here.
 */
typedef struct base_yy_extra_type
{
	/*
	 * Fields used by the core scanner.
	 */
	core_yy_extra_type core_yy_extra;

	/*
	 * State variables for base_yylex().
	 */
	bool		have_lookahead; /* is lookahead info valid? */
	int			lookahead_token;	/* one-token lookahead */
	core_YYSTYPE lookahead_yylval;	/* yylval for lookahead token */
	YYLTYPE		lookahead_yylloc;	/* yylloc for lookahead token */
	char	   *lookahead_end;	/* end of current token */
	char		lookahead_hold_char;	/* to be put back at *lookahead_end */

	/*
	 * State variables that belong to the grammar.
	 */
	List	   *parsetree;		/* final parse result is delivered here */
} base_yy_extra_type;

/*
 * In principle we should use yyget_extra() to fetch the yyextra field
 * from a yyscanner struct.  However, flex always puts that field first,
 * and this is sufficiently performance-critical to make it seem worth
 * cheating a bit to use an inline macro.
 */
#define pg_yyget_extra(yyscanner) (*((base_yy_extra_type **) (yyscanner)))


/* from parser.c */
extern int	base_yylex(YYSTYPE *lvalp, YYLTYPE *llocp,
					   core_yyscan_t yyscanner);

/* from gram.y */
extern void parser_init(base_yy_extra_type *yyext);
extern int	base_yyparse(core_yyscan_t yyscanner);

#endif							/* GRAMPARSE_H */

typedef struct base_yy_extra_type pgtsql_base_yy_extra_type;

#undef pg_yyget_extra
#define pg_yyget_extra(yyscanner) (*((base_yy_extra_type **) (yyscanner)))

/* from parser.c */
extern int	pgtsql_base_yylex(YYSTYPE *lvalp, YYLTYPE * llocp,
							  core_yyscan_t yyscanner);

/* from pgtsql_gram.y */
extern void pgtsql_parser_init(pgtsql_base_yy_extra_type *yyext);
extern int	pgtsql_base_yyparse(core_yyscan_t yyscanner);
extern int	pgtsql_base_yydebug;

#endif							/* PGTSQL_GRAMPARSE_H */
