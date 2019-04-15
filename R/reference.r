hql_object_types = function() {
  c(
    HDFQL_DIRECTORY = HDFql.constants$HDFQL_DIRECTORY,
    HDFQL_FILE = HDFql.constants$HDFQL_FILE,
    HDFQL_GROUP = HDFql.constants$HDFQL_GROUP,
    HDFQL_DATASET = HDFql.constants$HDFQL_DATASET,
    HDFQL_ATTRIBUTE = HDFql.constants$HDFQL_ATTRIBUTE,
    HDFQL_SOFT_LINK = HDFql.constants$HDFQL_SOFT_LINK,
    HDFQL_HARD_LINK = HDFql.constants$HDFQL_HARD_LINK,
    HDFQL_EXTERNAL_LINK = HDFql.constants$HDFQL_EXTERNAL_LINK
  )
}

hql_data_types = function() {
  c(
  HDFQL_TINYINT = HDFql.constants$HDFQL_TINYINT,
  HDFQL_UNSIGNED_TINYINT = HDFql.constants$HDFQL_UNSIGNED_TINYINT,
  HDFQL_SMALLINT = HDFql.constants$HDFQL_SMALLINT,
  HDFQL_UNSIGNED_SMALLINT = HDFql.constants$HDFQL_UNSIGNED_SMALLINT,
  HDFQL_INT = HDFql.constants$HDFQL_INT,
  HDFQL_UNSIGNED_INT = HDFql.constants$HDFQL_UNSIGNED_INT,
  HDFQL_BIGINT = HDFql.constants$HDFQL_BIGINT,
  HDFQL_UNSIGNED_BIGINT = HDFql.constants$HDFQL_UNSIGNED_BIGINT,
  HDFQL_FLOAT = HDFql.constants$HDFQL_FLOAT,
  HDFQL_DOUBLE = HDFql.constants$HDFQL_DOUBLE,
  HDFQL_CHAR = HDFql.constants$HDFQL_CHAR,
  HDFQL_VARTINYINT = HDFql.constants$HDFQL_VARTINYINT,
  HDFQL_UNSIGNED_VARTINYINT = HDFql.constants$HDFQL_UNSIGNED_VARTINYINT,
  HDFQL_VARSMALLINT = HDFql.constants$HDFQL_VARSMALLINT,
  HDFQL_UNSIGNED_VARSMALLINT = HDFql.constants$HDFQL_UNSIGNED_VARSMALLINT,
  HDFQL_VARINT = HDFql.constants$HDFQL_VARINT,
  HDFQL_UNSIGNED_VARINT = HDFql.constants$HDFQL_UNSIGNED_VARINT,
  HDFQL_VARBIGINT = HDFql.constants$HDFQL_VARBIGINT,
  HDFQL_UNSIGNED_VARBIGINT = HDFql.constants$HDFQL_UNSIGNED_VARBIGINT,
  HDFQL_VARFLOAT = HDFql.constants$HDFQL_VARFLOAT,
  HDFQL_VARDOUBLE = HDFql.constants$HDFQL_VARDOUBLE,
  HDFQL_VARCHAR = HDFql.constants$HDFQL_VARCHAR,
  HDFQL_OPAQUE = HDFql.constants$HDFQL_OPAQUE,
  HDFQL_BITFIELD = HDFql.constants$HDFQL_BITFIELD,
  HDFQL_ENUMERATION = HDFql.constants$HDFQL_ENUMERATION,
  HDFQL_COMPOUND = HDFql.constants$HDFQL_COMPOUND
  )
 }

hql_charsets = function() {
  c(
    HDFQL_ASCII = HDFql.constants$HDFQL_ASCII,
    HDFQL_UTF8 = HDFql.constants$HDFQL_UTF8
  )
}

hql_Rtypes = function() {
  c(
    HDFQL_TINYINT =  "integer",
    HDFQL_UNSIGNED_TINYINT = "integer",
    HDFQL_SMALLINT = "integer",
    HDFQL_UNSIGNED_SMALLINT = "integer",
    HDFQL_INT = "integer",
    HDFQL_UNSIGNED_INT = "integer",
    HDFQL_BIGINT = "integer64",
    HDFQL_UNSIGNED_BIGINT = "integer64",
    HDFQL_FLOAT = "double",
    HDFQL_DOUBLE = "double",
    HDFQL_CHAR = "character",
    HDFQL_VARTINYINT = "integer",
    HDFQL_UNSIGNED_VARTINYINT = "integer",
    HDFQL_VARSMALLINT = "integer",
    HDFQL_UNSIGNED_VARSMALLINT = "integer",
    HDFQL_VARINT = "integer",
    HDFQL_UNSIGNED_VARINT = "integer",
    HDFQL_VARBIGINT = "integer64",
    HDFQL_UNSIGNED_VARBIGINT = "integer64",
    HDFQL_VARFLOAT = "double",
    HDFQL_VARDOUBLE = "double",
    HDFQL_VARCHAR = "character",
    HDFQL_OPAQUE = NULL,
    HDFQL_BITFIELD = NULL,
    HDFQL_ENUMERATION = NULL,
    HDFQL_COMPOUND = "data.frame"
  )
}

hql_data_cursors = function() {
  c(
    HDFQL_TINYINT = HDFql.constants$hdfql_cursor_get_tinyint,
    HDFQL_VARTINYINT = HDFql.constants$hdfql_cursor_get_tinyint,
    HDFQL_UNSIGNED_TINYINT = HDFql.constants$hdfql_cursor_get_unsigned_tinyint,
    HDFQL_UNSIGNED_VARTINYINT = HDFql.constants$hdfql_cursor_get_unsigned_tinyint,
    HDFQL_SMALLINT = HDFql.constants$hdfql_cursor_get_smallint,
    HDFQL_VARSMALLINT = HDFql.constants$hdfql_cursor_get_smallint,
    HDFQL_UNSIGNED_SMALLINT = HDFql.constants$hdfql_cursor_get_unsigned_smallint,
    HDFQL_UNSIGNED_VARSMALLINT = HDFql.constants$hdfql_cursor_get_unsigned_smallint,
    HDFQL_INT = HDFql.constants$hdfql_cursor_get_int,
    HDFQL_VARINT = HDFql.constants$hdfql_cursor_get_int,
    HDFQL_UNSIGNED_INT = HDFql.constants$hdfql_cursor_get_unsigned_int,
    HDFQL_UNSIGNED_VARINT = HDFql.constants$hdfql_cursor_get_unsigned_int,
    HDFQL_BIGINT = HDFql.constants$hdfql_cursor_get_bigint,
    HDFQL_VARBIGINT = HDFql.constants$hdfql_cursor_get_bigint,
    HDFQL_UNSIGNED_BIGINT = HDFql.constants$hdfql_cursor_get_unsigned_bigint,
    HDFQL_UNSIGNED_VARBIGINT = HDFql.constants$hdfql_cursor_get_unsigned_bigint,
    HDFQL_FLOAT = HDFql.constants$hdfql_cursor_get_float,
    HDFQL_VARFLOAT = HDFql.constants$hdfql_cursor_get_float,
    HDFQL_DOUBLE = HDFql.constants$hdfql_cursor_get_double,
    HDFQL_VARDOUBLE = HDFql.constants$hdfql_cursor_get_double,
    HDFQL_CHAR = HDFql.constants$hdfql_cursor_get_char,
    HDFQL_VARCHAR = HDFql.constants$hdfql_cursor_get_char
  )
}

hql_data_subcursors = function() {
  c(
    HDFQL_TINYINT = HDFql.constants$hdfql_subcursor_get_tinyint,
    HDFQL_UNSIGNED_TINYINT = HDFql.constants$hdfql_subcursor_get_unsigned_tinyint,
    HDFQL_SMALLINT = HDFql.constants$hdfql_subcursor_get_smallint,
    HDFQL_UNSIGNED_SMALLINT = HDFql.constants$hdfql_subcursor_get_unsigned_smallint,
    HDFQL_INT = HDFql.constants$hdfql_subcursor_get_int,
    HDFQL_UNSIGNED_INT = HDFql.constants$hdfql_subcursor_get_unsigned_int,
    HDFQL_BIGINT = HDFql.constants$hdfql_subcursor_get_bigint,
    HDFQL_UNSIGNED_BIGINT = HDFql.constants$hdfql_subcursor_get_unsigned_bigint,
    HDFQL_FLOAT = HDFql.constants$hdfql_subcursor_get_float,
    HDFQL_DOUBLE = HDFql.constants$hdfql_subcursor_get_double,
    HDFQL_CHAR = HDFql.constants$hdfql_subcursor_get_char
  )
}

hql_error_types = function() {
  c(
		HDFQL_ERROR_PARSE = HDFql.constants$HDFQL_ERROR_PARSE,
		HDFQL_ERROR_NOT_FOUND = HDFql.constants$HDFQL_ERROR_NOT_FOUND,
		HDFQL_ERROR_NO_ACCESS = HDFql.constants$HDFQL_ERROR_NO_ACCESS,
		HDFQL_ERROR_NOT_OPEN = HDFql.constants$HDFQL_ERROR_NOT_OPEN,
		HDFQL_ERROR_INVALID_FILE = HDFql.constants$HDFQL_ERROR_INVALID_FILE,
		HDFQL_ERROR_NOT_SUPPORTED = HDFql.constants$HDFQL_ERROR_NOT_SUPPORTED,
		HDFQL_ERROR_NOT_ENOUGH_SPACE = HDFql.constants$HDFQL_ERROR_NOT_ENOUGH_SPACE,
		HDFQL_ERROR_NOT_ENOUGH_MEMORY = HDFql.constants$HDFQL_ERROR_NOT_ENOUGH_MEMORY,
		HDFQL_ERROR_ALREADY_EXISTS = HDFql.constants$HDFQL_ERROR_ALREADY_EXISTS,
		HDFQL_ERROR_EMPTY = HDFql.constants$HDFQL_ERROR_EMPTY,
		HDFQL_ERROR_FULL = HDFql.constants$HDFQL_ERROR_FULL,
		HDFQL_ERROR_BEFORE_FIRST = HDFql.constants$HDFQL_ERROR_BEFORE_FIRST,
		HDFQL_ERROR_AFTER_LAST = HDFql.constants$HDFQL_ERROR_AFTER_LAST,
		HDFQL_ERROR_OUTSIDE_LIMIT = HDFql.constants$HDFQL_ERROR_OUTSIDE_LIMIT,
		HDFQL_ERROR_NO_ADDRESS = HDFql.constants$HDFQL_ERROR_NO_ADDRESS,
		HDFQL_ERROR_UNEXPECTED_TYPE = HDFql.constants$HDFQL_ERROR_UNEXPECTED_TYPE,
		HDFQL_ERROR_UNEXPECTED_DATA_TYPE = HDFql.constants$HDFQL_ERROR_UNEXPECTED_DATA_TYPE,
		HDFQL_ERROR_NOT_REGISTERED = HDFql.constants$HDFQL_ERROR_NOT_REGISTERED,
		HDFQL_ERROR_INVALID_REGULAR_EXPRESSION = HDFql.constants$HDFQL_ERROR_INVALID_REGULAR_EXPRESSION,
		HDFQL_ERROR_UNKNOWN = HDFql.constants$HDFQL_ERROR_UNKNOWN
	)
}
