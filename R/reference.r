hql_object_types = function() {
  c(
    HDFQL_DIRECTORY = hql$constants$HDFQL_DIRECTORY,
    HDFQL_FILE = hql$constants$HDFQL_FILE,
    HDFQL_GROUP = hql$constants$HDFQL_GROUP,
    HDFQL_DATASET = hql$constants$HDFQL_DATASET,
    HDFQL_ATTRIBUTE = hql$constants$HDFQL_ATTRIBUTE,
    HDFQL_SOFT_LINK = hql$constants$HDFQL_SOFT_LINK,
    HDFQL_HARD_LINK = hql$constants$HDFQL_HARD_LINK,
    HDFQL_EXTERNAL_LINK = hql$constants$HDFQL_EXTERNAL_LINK
  )
}

hql_data_types = function() {
  c(
  HDFQL_TINYINT = hql$constants$HDFQL_TINYINT,
  HDFQL_UNSIGNED_TINYINT = hql$constants$HDFQL_UNSIGNED_TINYINT,
  HDFQL_SMALLINT = hql$constants$HDFQL_SMALLINT,
  HDFQL_UNSIGNED_SMALLINT = hql$constants$HDFQL_UNSIGNED_SMALLINT,
  HDFQL_INT = hql$constants$HDFQL_INT,
  HDFQL_UNSIGNED_INT = hql$constants$HDFQL_UNSIGNED_INT,
  HDFQL_BIGINT = hql$constants$HDFQL_BIGINT,
  HDFQL_UNSIGNED_BIGINT = hql$constants$HDFQL_UNSIGNED_BIGINT,
  HDFQL_FLOAT = hql$constants$HDFQL_FLOAT,
  HDFQL_DOUBLE = hql$constants$HDFQL_DOUBLE,
  HDFQL_CHAR = hql$constants$HDFQL_CHAR,
  HDFQL_VARTINYINT = hql$constants$HDFQL_VARTINYINT,
  HDFQL_UNSIGNED_VARTINYINT = hql$constants$HDFQL_UNSIGNED_VARTINYINT,
  HDFQL_VARSMALLINT = hql$constants$HDFQL_VARSMALLINT,
  HDFQL_UNSIGNED_VARSMALLINT = hql$constants$HDFQL_UNSIGNED_VARSMALLINT,
  HDFQL_VARINT = hql$constants$HDFQL_VARINT,
  HDFQL_UNSIGNED_VARINT = hql$constants$HDFQL_UNSIGNED_VARINT,
  HDFQL_VARBIGINT = hql$constants$HDFQL_VARBIGINT,
  HDFQL_UNSIGNED_VARBIGINT = hql$constants$HDFQL_UNSIGNED_VARBIGINT,
  HDFQL_VARFLOAT = hql$constants$HDFQL_VARFLOAT,
  HDFQL_VARDOUBLE = hql$constants$HDFQL_VARDOUBLE,
  HDFQL_VARCHAR = hql$constants$HDFQL_VARCHAR,
  HDFQL_OPAQUE = hql$constants$HDFQL_OPAQUE,
  HDFQL_BITFIELD = hql$constants$HDFQL_BITFIELD,
  HDFQL_ENUMERATION = hql$constants$HDFQL_ENUMERATION,
  HDFQL_COMPOUND = hql$constants$HDFQL_COMPOUND
  )
 }

hql_charsets = function() {
  c(
    HDFQL_ASCII = hql$constants$HDFQL_ASCII,
    HDFQL_UTF8 = hql$constants$HDFQL_UTF8
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
    HDFQL_TINYINT = hql$constants$hdfql_cursor_get_tinyint,
    HDFQL_VARTINYINT = hql$constants$hdfql_cursor_get_tinyint,
    HDFQL_UNSIGNED_TINYINT = hql$constants$hdfql_cursor_get_unsigned_tinyint,
    HDFQL_UNSIGNED_VARTINYINT = hql$constants$hdfql_cursor_get_unsigned_tinyint,
    HDFQL_SMALLINT = hql$constants$hdfql_cursor_get_smallint,
    HDFQL_VARSMALLINT = hql$constants$hdfql_cursor_get_smallint,
    HDFQL_UNSIGNED_SMALLINT = hql$constants$hdfql_cursor_get_unsigned_smallint,
    HDFQL_UNSIGNED_VARSMALLINT = hql$constants$hdfql_cursor_get_unsigned_smallint,
    HDFQL_INT = hql$constants$hdfql_cursor_get_int,
    HDFQL_VARINT = hql$constants$hdfql_cursor_get_int,
    HDFQL_UNSIGNED_INT = hql$constants$hdfql_cursor_get_unsigned_int,
    HDFQL_UNSIGNED_VARINT = hql$constants$hdfql_cursor_get_unsigned_int,
    HDFQL_BIGINT = hql$constants$hdfql_cursor_get_bigint,
    HDFQL_VARBIGINT = hql$constants$hdfql_cursor_get_bigint,
    HDFQL_UNSIGNED_BIGINT = hql$constants$hdfql_cursor_get_unsigned_bigint,
    HDFQL_UNSIGNED_VARBIGINT = hql$constants$hdfql_cursor_get_unsigned_bigint,
    HDFQL_FLOAT = hql$constants$hdfql_cursor_get_float,
    HDFQL_VARFLOAT = hql$constants$hdfql_cursor_get_float,
    HDFQL_DOUBLE = hql$constants$hdfql_cursor_get_double,
    HDFQL_VARDOUBLE = hql$constants$hdfql_cursor_get_double,
    HDFQL_CHAR = hql$constants$hdfql_cursor_get_char,
    HDFQL_VARCHAR = hql$constants$hdfql_cursor_get_char
  )
}

hql_data_subcursors = function() {
  c(
    HDFQL_TINYINT = hql$constants$hdfql_subcursor_get_tinyint,
    HDFQL_UNSIGNED_TINYINT = hql$constants$hdfql_subcursor_get_unsigned_tinyint,
    HDFQL_SMALLINT = hql$constants$hdfql_subcursor_get_smallint,
    HDFQL_UNSIGNED_SMALLINT = hql$constants$hdfql_subcursor_get_unsigned_smallint,
    HDFQL_INT = hql$constants$hdfql_subcursor_get_int,
    HDFQL_UNSIGNED_INT = hql$constants$hdfql_subcursor_get_unsigned_int,
    HDFQL_BIGINT = hql$constants$hdfql_subcursor_get_bigint,
    HDFQL_UNSIGNED_BIGINT = hql$constants$hdfql_subcursor_get_unsigned_bigint,
    HDFQL_FLOAT = hql$constants$hdfql_subcursor_get_float,
    HDFQL_DOUBLE = hql$constants$hdfql_subcursor_get_double,
    HDFQL_CHAR = hql$constants$hdfql_subcursor_get_char
  )
}

hql_error_types = function() {
  c(
		HDFQL_ERROR_PARSE = hql$constants$HDFQL_ERROR_PARSE,
		HDFQL_ERROR_NOT_FOUND = hql$constants$HDFQL_ERROR_NOT_FOUND,
		HDFQL_ERROR_NO_ACCESS = hql$constants$HDFQL_ERROR_NO_ACCESS,
		HDFQL_ERROR_NOT_OPEN = hql$constants$HDFQL_ERROR_NOT_OPEN,
		HDFQL_ERROR_INVALID_FILE = hql$constants$HDFQL_ERROR_INVALID_FILE,
		HDFQL_ERROR_NOT_SUPPORTED = hql$constants$HDFQL_ERROR_NOT_SUPPORTED,
		HDFQL_ERROR_NOT_ENOUGH_SPACE = hql$constants$HDFQL_ERROR_NOT_ENOUGH_SPACE,
		HDFQL_ERROR_NOT_ENOUGH_MEMORY = hql$constants$HDFQL_ERROR_NOT_ENOUGH_MEMORY,
		HDFQL_ERROR_ALREADY_EXISTS = hql$constants$HDFQL_ERROR_ALREADY_EXISTS,
		HDFQL_ERROR_EMPTY = hql$constants$HDFQL_ERROR_EMPTY,
		HDFQL_ERROR_FULL = hql$constants$HDFQL_ERROR_FULL,
		HDFQL_ERROR_BEFORE_FIRST = hql$constants$HDFQL_ERROR_BEFORE_FIRST,
		HDFQL_ERROR_AFTER_LAST = hql$constants$HDFQL_ERROR_AFTER_LAST,
		HDFQL_ERROR_OUTSIDE_LIMIT = hql$constants$HDFQL_ERROR_OUTSIDE_LIMIT,
		HDFQL_ERROR_NO_ADDRESS = hql$constants$HDFQL_ERROR_NO_ADDRESS,
		HDFQL_ERROR_UNEXPECTED_TYPE = hql$constants$HDFQL_ERROR_UNEXPECTED_TYPE,
		HDFQL_ERROR_UNEXPECTED_DATA_TYPE = hql$constants$HDFQL_ERROR_UNEXPECTED_DATA_TYPE,
		HDFQL_ERROR_NOT_REGISTERED = hql$constants$HDFQL_ERROR_NOT_REGISTERED,
		HDFQL_ERROR_INVALID_REGULAR_EXPRESSION = hql$constants$HDFQL_ERROR_INVALID_REGULAR_EXPRESSION,
		HDFQL_ERROR_UNKNOWN = hql$constants$HDFQL_ERROR_UNKNOWN
	)
}
