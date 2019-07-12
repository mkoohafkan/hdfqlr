hql_object_types = function() {
  c(
    HDFQL_DIRECTORY = hql$wrapper$HDFQL_DIRECTORY,
    HDFQL_FILE = hql$wrapper$HDFQL_FILE,
    HDFQL_GROUP = hql$wrapper$HDFQL_GROUP,
    HDFQL_DATASET = hql$wrapper$HDFQL_DATASET,
    HDFQL_ATTRIBUTE = hql$wrapper$HDFQL_ATTRIBUTE,
    HDFQL_SOFT_LINK = hql$wrapper$HDFQL_SOFT_LINK,
    HDFQL_HARD_LINK = hql$wrapper$HDFQL_HARD_LINK,
    HDFQL_EXTERNAL_LINK = hql$wrapper$HDFQL_EXTERNAL_LINK
  )
}

hql_data_types = function() {
  c(
  HDFQL_TINYINT = hql$wrapper$HDFQL_TINYINT,
  HDFQL_UNSIGNED_TINYINT = hql$wrapper$HDFQL_UNSIGNED_TINYINT,
  HDFQL_SMALLINT = hql$wrapper$HDFQL_SMALLINT,
  HDFQL_UNSIGNED_SMALLINT = hql$wrapper$HDFQL_UNSIGNED_SMALLINT,
  HDFQL_INT = hql$wrapper$HDFQL_INT,
  HDFQL_UNSIGNED_INT = hql$wrapper$HDFQL_UNSIGNED_INT,
  HDFQL_BIGINT = hql$wrapper$HDFQL_BIGINT,
  HDFQL_UNSIGNED_BIGINT = hql$wrapper$HDFQL_UNSIGNED_BIGINT,
  HDFQL_FLOAT = hql$wrapper$HDFQL_FLOAT,
  HDFQL_DOUBLE = hql$wrapper$HDFQL_DOUBLE,
  HDFQL_CHAR = hql$wrapper$HDFQL_CHAR,
  HDFQL_VARTINYINT = hql$wrapper$HDFQL_VARTINYINT,
  HDFQL_UNSIGNED_VARTINYINT = hql$wrapper$HDFQL_UNSIGNED_VARTINYINT,
  HDFQL_VARSMALLINT = hql$wrapper$HDFQL_VARSMALLINT,
  HDFQL_UNSIGNED_VARSMALLINT = hql$wrapper$HDFQL_UNSIGNED_VARSMALLINT,
  HDFQL_VARINT = hql$wrapper$HDFQL_VARINT,
  HDFQL_UNSIGNED_VARINT = hql$wrapper$HDFQL_UNSIGNED_VARINT,
  HDFQL_VARBIGINT = hql$wrapper$HDFQL_VARBIGINT,
  HDFQL_UNSIGNED_VARBIGINT = hql$wrapper$HDFQL_UNSIGNED_VARBIGINT,
  HDFQL_VARFLOAT = hql$wrapper$HDFQL_VARFLOAT,
  HDFQL_VARDOUBLE = hql$wrapper$HDFQL_VARDOUBLE,
  HDFQL_VARCHAR = hql$wrapper$HDFQL_VARCHAR,
  HDFQL_OPAQUE = hql$wrapper$HDFQL_OPAQUE,
  HDFQL_BITFIELD = hql$wrapper$HDFQL_BITFIELD,
  HDFQL_ENUMERATION = hql$wrapper$HDFQL_ENUMERATION,
  HDFQL_COMPOUND = hql$wrapper$HDFQL_COMPOUND
  )
 }

hql_charsets = function() {
  c(
    HDFQL_ASCII = hql$wrapper$HDFQL_ASCII,
    HDFQL_UTF8 = hql$wrapper$HDFQL_UTF8
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
    HDFQL_TINYINT = hql$wrapper$hdfql_cursor_get_tinyint,
    HDFQL_VARTINYINT = hql$wrapper$hdfql_cursor_get_tinyint,
    HDFQL_UNSIGNED_TINYINT = hql$wrapper$hdfql_cursor_get_unsigned_tinyint,
    HDFQL_UNSIGNED_VARTINYINT = hql$wrapper$hdfql_cursor_get_unsigned_tinyint,
    HDFQL_SMALLINT = hql$wrapper$hdfql_cursor_get_smallint,
    HDFQL_VARSMALLINT = hql$wrapper$hdfql_cursor_get_smallint,
    HDFQL_UNSIGNED_SMALLINT = hql$wrapper$hdfql_cursor_get_unsigned_smallint,
    HDFQL_UNSIGNED_VARSMALLINT = hql$wrapper$hdfql_cursor_get_unsigned_smallint,
    HDFQL_INT = hql$wrapper$hdfql_cursor_get_int,
    HDFQL_VARINT = hql$wrapper$hdfql_cursor_get_int,
    HDFQL_UNSIGNED_INT = hql$wrapper$hdfql_cursor_get_unsigned_int,
    HDFQL_UNSIGNED_VARINT = hql$wrapper$hdfql_cursor_get_unsigned_int,
    HDFQL_BIGINT = hql$wrapper$hdfql_cursor_get_bigint,
    HDFQL_VARBIGINT = hql$wrapper$hdfql_cursor_get_bigint,
    HDFQL_UNSIGNED_BIGINT = hql$wrapper$hdfql_cursor_get_unsigned_bigint,
    HDFQL_UNSIGNED_VARBIGINT = hql$wrapper$hdfql_cursor_get_unsigned_bigint,
    HDFQL_FLOAT = hql$wrapper$hdfql_cursor_get_float,
    HDFQL_VARFLOAT = hql$wrapper$hdfql_cursor_get_float,
    HDFQL_DOUBLE = hql$wrapper$hdfql_cursor_get_double,
    HDFQL_VARDOUBLE = hql$wrapper$hdfql_cursor_get_double,
    HDFQL_CHAR = hql$wrapper$hdfql_cursor_get_char,
    HDFQL_VARCHAR = hql$wrapper$hdfql_cursor_get_char
  )
}

hql_data_subcursors = function() {
  c(
    HDFQL_TINYINT = hql$wrapper$hdfql_subcursor_get_tinyint,
    HDFQL_UNSIGNED_TINYINT = hql$wrapper$hdfql_subcursor_get_unsigned_tinyint,
    HDFQL_SMALLINT = hql$wrapper$hdfql_subcursor_get_smallint,
    HDFQL_UNSIGNED_SMALLINT = hql$wrapper$hdfql_subcursor_get_unsigned_smallint,
    HDFQL_INT = hql$wrapper$hdfql_subcursor_get_int,
    HDFQL_UNSIGNED_INT = hql$wrapper$hdfql_subcursor_get_unsigned_int,
    HDFQL_BIGINT = hql$wrapper$hdfql_subcursor_get_bigint,
    HDFQL_UNSIGNED_BIGINT = hql$wrapper$hdfql_subcursor_get_unsigned_bigint,
    HDFQL_FLOAT = hql$wrapper$hdfql_subcursor_get_float,
    HDFQL_DOUBLE = hql$wrapper$hdfql_subcursor_get_double,
    HDFQL_CHAR = hql$wrapper$hdfql_subcursor_get_char
  )
}

hql_error_types = function() {
  c(
		HDFQL_ERROR_PARSE = hql$wrapper$HDFQL_ERROR_PARSE,
		HDFQL_ERROR_NOT_FOUND = hql$wrapper$HDFQL_ERROR_NOT_FOUND,
		HDFQL_ERROR_NO_ACCESS = hql$wrapper$HDFQL_ERROR_NO_ACCESS,
		HDFQL_ERROR_NOT_OPEN = hql$wrapper$HDFQL_ERROR_NOT_OPEN,
		HDFQL_ERROR_INVALID_FILE = hql$wrapper$HDFQL_ERROR_INVALID_FILE,
		HDFQL_ERROR_NOT_SUPPORTED = hql$wrapper$HDFQL_ERROR_NOT_SUPPORTED,
		HDFQL_ERROR_NOT_ENOUGH_SPACE = hql$wrapper$HDFQL_ERROR_NOT_ENOUGH_SPACE,
		HDFQL_ERROR_NOT_ENOUGH_MEMORY = hql$wrapper$HDFQL_ERROR_NOT_ENOUGH_MEMORY,
		HDFQL_ERROR_ALREADY_EXISTS = hql$wrapper$HDFQL_ERROR_ALREADY_EXISTS,
		HDFQL_ERROR_EMPTY = hql$wrapper$HDFQL_ERROR_EMPTY,
		HDFQL_ERROR_FULL = hql$wrapper$HDFQL_ERROR_FULL,
		HDFQL_ERROR_BEFORE_FIRST = hql$wrapper$HDFQL_ERROR_BEFORE_FIRST,
		HDFQL_ERROR_AFTER_LAST = hql$wrapper$HDFQL_ERROR_AFTER_LAST,
		HDFQL_ERROR_OUTSIDE_LIMIT = hql$wrapper$HDFQL_ERROR_OUTSIDE_LIMIT,
		HDFQL_ERROR_NO_ADDRESS = hql$wrapper$HDFQL_ERROR_NO_ADDRESS,
		HDFQL_ERROR_UNEXPECTED_TYPE = hql$wrapper$HDFQL_ERROR_UNEXPECTED_TYPE,
		HDFQL_ERROR_UNEXPECTED_DATA_TYPE = hql$wrapper$HDFQL_ERROR_UNEXPECTED_DATA_TYPE,
		HDFQL_ERROR_NOT_REGISTERED = hql$wrapper$HDFQL_ERROR_NOT_REGISTERED,
		HDFQL_ERROR_INVALID_REGULAR_EXPRESSION = hql$wrapper$HDFQL_ERROR_INVALID_REGULAR_EXPRESSION,
		HDFQL_ERROR_UNKNOWN = hql$wrapper$HDFQL_ERROR_UNKNOWN
	)
}
