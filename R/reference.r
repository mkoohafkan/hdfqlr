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
    HDFQL_DIRECTORY = HDFQL_DIRECTORY,
    HDFQL_FILE = HDFQL_FILE,
    HDFQL_GROUP = HDFQL_GROUP,
    HDFQL_DATASET = HDFQL_DATASET,
    HDFQL_ATTRIBUTE = HDFQL_ATTRIBUTE,
    HDFQL_SOFT_LINK = HDFQL_SOFT_LINK,
    HDFQL_HARD_LINK = HDFQL_HARD_LINK,
    HDFQL_EXTERNAL_LINK = HDFQL_EXTERNAL_LINK
  )
}

hdfql_dtypes = function() {
  c(
  HDFQL_TINYINT = HDFQL_TINYINT,
  HDFQL_UNSIGNED_TINYINT = HDFQL_UNSIGNED_TINYINT,
  HDFQL_SMALLINT = HDFQL_SMALLINT,
  HDFQL_UNSIGNED_SMALLINT = HDFQL_UNSIGNED_SMALLINT,
  HDFQL_INT = HDFQL_INT,
  HDFQL_UNSIGNED_INT = HDFQL_UNSIGNED_INT,
  HDFQL_BIGINT = HDFQL_BIGINT,
  HDFQL_UNSIGNED_BIGINT = HDFQL_UNSIGNED_BIGINT,
  HDFQL_FLOAT = HDFQL_FLOAT,
  HDFQL_DOUBLE = HDFQL_DOUBLE,
  HDFQL_CHAR = HDFQL_CHAR,
  HDFQL_VARTINYINT = HDFQL_VARTINYINT,
  HDFQL_UNSIGNED_VARTINYINT = HDFQL_UNSIGNED_VARTINYINT,
  HDFQL_VARSMALLINT = HDFQL_VARSMALLINT,
  HDFQL_UNSIGNED_VARSMALLINT = HDFQL_UNSIGNED_VARSMALLINT,
  HDFQL_VARINT = HDFQL_VARINT,
  HDFQL_UNSIGNED_VARINT = HDFQL_UNSIGNED_VARINT,
  HDFQL_VARBIGINT = HDFQL_VARBIGINT,
  HDFQL_UNSIGNED_VARBIGINT = HDFQL_UNSIGNED_VARBIGINT,
  HDFQL_VARFLOAT = HDFQL_VARFLOAT,
  HDFQL_VARDOUBLE = HDFQL_VARDOUBLE,
  HDFQL_VARCHAR = HDFQL_VARCHAR,
  HDFQL_OPAQUE = HDFQL_OPAQUE,
  HDFQL_BITFIELD = HDFQL_BITFIELD,
  HDFQL_ENUMERATION = HDFQL_ENUMERATION,
  HDFQL_COMPOUND = HDFQL_COMPOUND
  )
 }

hdfql_charsets = function() {
  c(
    HDFQL_ASCII = HDFQL_ASCII,
    HDFQL_UTF8 = HDFQL_UTF8
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


hdfql_cursorget = function() {
  c(
    HDFQL_TINYINT = hdfql_cursor_get_tinyint,
    HDFQL_UNSIGNED_TINYINT = hdfql_cursor_get_unsigned_tinyint,
    HDFQL_SMALLINT = hdfql_cursor_get_smallint,
    HDFQL_UNSIGNED_SMALLINT = hdfql_cursor_get_unsigned_smallint,
    HDFQL_INT = hdfql_cursor_get_int,
    HDFQL_UNSIGNED_INT = hdfql_cursor_get_unsigned_int,
    HDFQL_BIGINT = hdfql_cursor_get_bigint,
    HDFQL_UNSIGNED_BIGINT = hdfql_cursor_get_unsigned_bigint,
    HDFQL_FLOAT = hdfql_cursor_get_float,
    HDFQL_DOUBLE = hdfql_cursor_get_double,
    HDFQL_CHAR = hdfql_cursor_get_char
  )
}

hdfql.subcursorget = function() {
  c(
    HDFQL_TINYINT = hdfql_subcursor_get_tinyint,
    HDFQL_UNSIGNED_TINYINT = hdfql_subcursor_get_unsigned_tinyint,
    HDFQL_SMALLINT = hdfql_subcursor_get_smallint,
    HDFQL_UNSIGNED_SMALLINT = hdfql_subcursor_get_unsigned_smallint,
    HDFQL_INT = hdfql_subcursor_get_int,
    HDFQL_UNSIGNED_INT = hdfql_subcursor_get_unsigned_int,
    HDFQL_BIGINT = hdfql_subcursor_get_bigint,
    HDFQL_UNSIGNED_BIGINT = hdfql_subcursor_get_unsigned_bigint,
    HDFQL_FLOAT = hdfql_subcursor_get_float,
    HDFQL_DOUBLE = hdfql_subcursor_get_double,
    HDFQL_CHAR = hdfql_subcursor_get_char
  )
}




