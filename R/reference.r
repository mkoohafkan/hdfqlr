hdfql.otypes = c(
  HDFQL_DIRECTORY = 1,
  HDFQL_FILE = 2,
  HDFQL_GROUP = 4,
  HDFQL_DATASET = 8,
  HDFQL_ATTRIBUTE = 16,
  HDFQL_SOFT_LINK = 32,
  HDFQL_HARD_LINK = 64,
  HDFQL_EXTERNAL_LINK = 128
)

hdfql.dtypes = c(
  HDFQL_TINYINT = 1L,
  HDFQL_UNSIGNED_TINYINT = 2L,
  HDFQL_SMALLINT = 4L,
  HDFQL_UNSIGNED_SMALLINT = 8L,
  HDFQL_INT = 16L,
  HDFQL_UNSIGNED_INT = 32L,
  HDFQL_BIGINT = 64L,
  HDFQL_UNSIGNED_BIGINT = 128L,
  HDFQL_FLOAT = 256L,
  HDFQL_DOUBLE = 512L,
  HDFQL_CHAR = 1024L,
  HDFQL_VARTINYINT = 2048L,
  HDFQL_UNSIGNED_VARTINYINT = 4096L,
  HDFQL_VARSMALLINT = 8192L,
  HDFQL_UNSIGNED_VARSMALLINT = 16384L,
  HDFQL_VARINT = 32768L,
  HDFQL_UNSIGNED_VARINT = 65536L,
  HDFQL_VARBIGINT = 131072L,
  HDFQL_UNSIGNED_VARBIGINT = 262144L,
  HDFQL_VARFLOAT = 524288L,
  HDFQL_VARDOUBLE = 1048576L,
  HDFQL_VARCHAR = 2097152L,
  HDFQL_OPAQUE = 4194304L,
  HDFQL_BITFIELD = 8388608L,
  HDFQL_ENUMERATION = 16777216L,
  HDFQL_COMPOUND = 33554432L
)

hdfql.keywords = list(
  "HDFQL_ATTRIBUTE" = "ATTRIBUTE",
  "HDFQL_GROUP" = "GROUP",
  "HDFQL_DATASET" = "DATASET"
)

hdfql.charsets = list(
  "HDFQL_ASCII" = 1L,
  "HDFQL_UTF8" = 2L
)

hdfql.Rtypes = c(
  HDFQL_TINYINT =  "integer",
  HDFQL_UNSIGNED_TINYINT = "integer",
  HDFQL_SMALLINT = "integer",
  HDFQL_UNSIGNED_SMALLINT = "integer",
  HDFQL_INT = "integer",
  HDFQL_UNSIGNED_INT = "integer",
  HDFQL_BIGINT = NA,
  HDFQL_UNSIGNED_BIGINT = NA,
  HDFQL_FLOAT = "numeric",
  HDFQL_DOUBLE = "numeric",
  HDFQL_CHAR = "character",
  HDFQL_VARTINYINT = "integer",
  HDFQL_UNSIGNED_VARTINYINT = "integer",
  HDFQL_VARSMALLINT = "integer",
  HDFQL_UNSIGNED_VARSMALLINT = "integer",
  HDFQL_VARINT = "integer",
  HDFQL_UNSIGNED_VARINT = "integer",
  HDFQL_VARBIGINT = NULL,
  HDFQL_UNSIGNED_VARBIGINT = NULL,
  HDFQL_VARFLOAT = "numeric",
  HDFQL_VARDOUBLE = "numeric",
  HDFQL_VARCHAR = "character",
  HDFQL_OPAQUE = NULL,
  HDFQL_BITFIELD = NULL,
  HDFQL_ENUMERATION = NULL,
  HDFQL_COMPOUND = NULL
)



#hdfql.cursorget = c(
  #HDFQL_TINYINT = hdfql_cursor_get_tinyint,
  #HDFQL_UNSIGNED_TINYINT = hdfql_cursor_get_unsigned_tinyint,
  #HDFQL_SMALLINT = hdfql_cursor_get_smallint,
  #HDFQL_UNSIGNED_SMALLINT = hdfql_cursor_get_unsigned_smallint,
  #HDFQL_INT = hdfql_cursor_get_int,
  #HDFQL_UNSIGNED_INT = hdfql_cursor_get_unsigned_int,
  #HDFQL_BIGINT = hdfql_cursor_get_bigint,
  #HDFQL_UNSIGNED_BIGINT = hdfql_cursor_get_unsigned_bigint,
  #HDFQL_FLOAT = hdfql_cursor_get_float,
  #HDFQL_DOUBLE = hdfql_cursor_get_double,
  #HDFQL_CHAR = hdfql_cursor_get_char
#)

#hdfql.subcursorget = c(
  #HDFQL_TINYINT = hdfql_subcursor_get_tinyint,
  #HDFQL_UNSIGNED_TINYINT = hdfql_subcursor_get_unsigned_tinyint,
  #HDFQL_SMALLINT = hdfql_subcursor_get_smallint,
  #HDFQL_UNSIGNED_SMALLINT = hdfql_subcursor_get_unsigned_smallint,
  #HDFQL_INT = hdfql_subcursor_get_int,
  #HDFQL_UNSIGNED_INT = hdfql_subcursor_get_unsigned_int,
  #HDFQL_BIGINT = hdfql_subcursor_get_bigint,
  #HDFQL_UNSIGNED_BIGINT = hdfql_subcursor_get_unsigned_bigint,
  #HDFQL_FLOAT = hdfql_subcursor_get_float,
  #HDFQL_DOUBLE = hdfql_subcursor_get_double,
  #HDFQL_CHAR = hdfql_subcursor_get_char
#)



