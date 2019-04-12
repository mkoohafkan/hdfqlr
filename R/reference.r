#' @importFrom utils stack
get_key = function(x, l, invert = FALSE) {
  if (!invert) {
    l[[x]]
  }
  else {
    d = stack(l)
    as.character(d[d$values == x, "ind"])
  }
}



hdfql_keywords = function() {
  c(
    HDFQL_ATTRIBUTE = "ATTRIBUTE",
    HDFQL_GROUP = "GROUP",
    HDFQL_DATASET = "DATASET"
  )
}

hdfql_otypes = function() {
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

hdfql_dtypes = function() {
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

hdfql_charsets = function() {
  c(
    HDFQL_ASCII = HDFql.constants$HDFQL_ASCII,
    HDFQL_UTF8 = HDFql.constants$HDFQL_UTF8
  )
}

hdfql_Rtypes = function() {
  c(
    HDFQL_TINYINT =  "integer",
    HDFQL_UNSIGNED_TINYINT = "integer",
    HDFQL_SMALLINT = "integer",
    HDFQL_UNSIGNED_SMALLINT = "integer",
    HDFQL_INT = "integer",
    HDFQL_UNSIGNED_INT = "integer",
    HDFQL_BIGINT = "integer64",
    HDFQL_UNSIGNED_BIGINT = "integer64",
    HDFQL_FLOAT = "numeric",
    HDFQL_DOUBLE = "numeric",
    HDFQL_CHAR = "character",
    HDFQL_VARTINYINT = "integer",
    HDFQL_UNSIGNED_VARTINYINT = "integer",
    HDFQL_VARSMALLINT = "integer",
    HDFQL_UNSIGNED_VARSMALLINT = "integer",
    HDFQL_VARINT = "integer",
    HDFQL_UNSIGNED_VARINT = "integer",
    HDFQL_VARBIGINT = "integer64",
    HDFQL_UNSIGNED_VARBIGINT = "integer64",
    HDFQL_VARFLOAT = "numeric",
    HDFQL_VARDOUBLE = "numeric",
    HDFQL_VARCHAR = "character",
    HDFQL_OPAQUE = NULL,
    HDFQL_BITFIELD = NULL,
    HDFQL_ENUMERATION = NULL,
    HDFQL_COMPOUND = NULL
  )
}


hdfql_data_cursors = function() {
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

hdfql_data_subcursors = function() {
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




