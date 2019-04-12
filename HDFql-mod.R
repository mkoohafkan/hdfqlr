# Copyright (C) 2016-2019
# This file is part of the Hierarchical Data Format query language (HDFql)
# For more information about HDFql, please visit the website http://www.hdfql.com

# $Rev: 198 $



#===========================================================
# LOAD HDFQL R WRAPPER SHARED LIBRARY
#===========================================================
hdfql_operating_system = Sys.info()["sysname"]
if (hdfql_operating_system == "Windows")
{
	dyn.load("HDFqlR.dll")
} else if (hdfql_operating_system == "Linux")
{
	dyn.load("libHDFqlR.so")
} else # macOS
{
	dyn.load("libHDFqlR.dylib")
}
rm(hdfql_operating_system)



#===========================================================
# INITIALIZE HDFQL R WRAPPER SHARED LIBRARY
#===========================================================
hdfql_initialize_status = .Call("_hdfql_initialize", PACKAGE = "HDFqlR")
if (is.null(hdfql_initialize_status) == FALSE)
{
	stop(hdfql_initialize_status)
}
rm(hdfql_initialize_status)



#===========================================================
# CONSTANTS
#===========================================================
HDFQL_VERSION <- "2.0.1"

HDFQL_YES <- 0

HDFQL_NO <- -1

HDFQL_ENABLED <- 0

HDFQL_DISABLED <- -1

HDFQL_UNLIMITED <- -1

HDFQL_UNDEFINED <- -1


HDFQL_GLOBAL <- 1

HDFQL_LOCAL <- 2


HDFQL_TRACKED <- 1

HDFQL_INDEXED <- 2


HDFQL_CONTIGUOUS <- 1

HDFQL_COMPACT <- 2

HDFQL_CHUNKED <- 4


HDFQL_EARLY <- 1

HDFQL_INCREMENTAL <- 2

HDFQL_LATE <- 4


HDFQL_DIRECTORY <- 1

HDFQL_FILE <- 2

HDFQL_GROUP <- 4

HDFQL_DATASET <- 8

HDFQL_ATTRIBUTE <- 16

HDFQL_SOFT_LINK <- 32

HDFQL_HARD_LINK <- 64

HDFQL_EXTERNAL_LINK <- 128


HDFQL_TINYINT <- 1

HDFQL_UNSIGNED_TINYINT <- 2

HDFQL_SMALLINT <- 4

HDFQL_UNSIGNED_SMALLINT <- 8

HDFQL_INT <- 16

HDFQL_UNSIGNED_INT <- 32

HDFQL_BIGINT <- 64

HDFQL_UNSIGNED_BIGINT <- 128

HDFQL_FLOAT <- 256

HDFQL_DOUBLE <- 512

HDFQL_CHAR <- 1024

HDFQL_VARTINYINT <- 2048

HDFQL_UNSIGNED_VARTINYINT <- 4096

HDFQL_VARSMALLINT <- 8192

HDFQL_UNSIGNED_VARSMALLINT <- 16384

HDFQL_VARINT <- 32768

HDFQL_UNSIGNED_VARINT <- 65536

HDFQL_VARBIGINT <- 131072

HDFQL_UNSIGNED_VARBIGINT <- 262144

HDFQL_VARFLOAT <- 524288

HDFQL_VARDOUBLE <- 1048576

HDFQL_VARCHAR <- 2097152

HDFQL_OPAQUE <- 4194304

HDFQL_BITFIELD <- 8388608

HDFQL_ENUMERATION <- 16777216

HDFQL_COMPOUND <- 33554432

HDFQL_ARRAY <- 67108864

HDFQL_REFERENCE <- 134217728


HDFQL_LITTLE_ENDIAN <- 1

HDFQL_BIG_ENDIAN <- 2


HDFQL_ASCII <- 1

HDFQL_UTF8 <- 2


HDFQL_FILL_DEFAULT <- 1

HDFQL_FILL_USER_DEFINED <- 2

HDFQL_FILL_UNDEFINED <- 4


HDFQL_EARLIEST <- 1

HDFQL_LATEST <- 2

HDFQL_VERSION_18 <- 4


HDFQL_SUCCESS <- 0

HDFQL_ERROR_PARSE <- -1

HDFQL_ERROR_NOT_FOUND <- -2

HDFQL_ERROR_NO_ACCESS <- -3

HDFQL_ERROR_NOT_OPEN <- -4

HDFQL_ERROR_INVALID_FILE <- -5

HDFQL_ERROR_NOT_SUPPORTED <- -6

HDFQL_ERROR_NOT_ENOUGH_SPACE <- -7

HDFQL_ERROR_NOT_ENOUGH_MEMORY <- -8

HDFQL_ERROR_ALREADY_EXISTS <- -9

HDFQL_ERROR_EMPTY <- -10

HDFQL_ERROR_FULL <- -11

HDFQL_ERROR_BEFORE_FIRST <- -12

HDFQL_ERROR_AFTER_LAST <- -13

HDFQL_ERROR_OUTSIDE_LIMIT <- -14

HDFQL_ERROR_NO_ADDRESS <- -15

HDFQL_ERROR_UNEXPECTED_TYPE <- -16

HDFQL_ERROR_UNEXPECTED_DATA_TYPE <- -17

HDFQL_ERROR_NOT_REGISTERED <- -18

HDFQL_ERROR_INVALID_REGULAR_EXPRESSION  <- -19

HDFQL_ERROR_UNKNOWN <- -99



#===========================================================
# CLASSES
#===========================================================
hdfql_cursor_ <- setRefClass("hdfql_cursor_", field = list(address = "numeric"), method = list(finalize = function(){.Call("_hdfql_cursor_destroy", .self$address, PACKAGE = "HDFqlR")}))



#===========================================================
# GENERAL FUNCTIONS
#===========================================================
hdfql_execute <- function(script)
{

	if (is.character(script) == FALSE)
	{
		return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
	}

	return (.Call("hdfql_execute", script, PACKAGE = "HDFqlR"))

}



hdfql_execute_get_status <- function()
{

	return (.Call("hdfql_execute_get_status", PACKAGE = "HDFqlR"))

}



hdfql_error_get_line <- function()
{

	return (.Call("hdfql_error_get_line", PACKAGE = "HDFqlR"))

}



hdfql_error_get_position <- function()
{

	return (.Call("hdfql_error_get_position", PACKAGE = "HDFqlR"))

}



hdfql_error_get_message <- function()
{

	return (.Call("hdfql_error_get_message", PACKAGE = "HDFqlR"))

}



hdfql_get_canonical_path <- function(object_name)
{

	if (is.character(object_name) == FALSE)
	{
		return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
	}

	return (.Call("hdfql_get_canonical_path", object_name, PACKAGE = "HDFqlR"))

}



#===========================================================
# CURSOR FUNCTIONS
#===========================================================
hdfql_cursor <- function()
{

	cursor <- hdfql_cursor_()

	cursor$address = .Call("_hdfql_cursor_create", PACKAGE = "HDFqlR")

	return (cursor)

}



hdfql_cursor_initialize <- function(cursor = NULL)
{

	if (is.null(cursor) == TRUE)
	{
		return (.Call("hdfql_cursor_initialize", NULL, PACKAGE = "HDFqlR"))
	}
	else
	{
		if (is(cursor, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_cursor_initialize", cursor$address, PACKAGE = "HDFqlR"))
	}

}



hdfql_cursor_use <- function(cursor = NULL)
{

	if (is.null(cursor) == TRUE)
	{
		return (.Call("hdfql_cursor_use", NULL, PACKAGE = "HDFqlR"))
	}
	else
	{
		if (is(cursor, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_cursor_use", cursor$address, PACKAGE = "HDFqlR"))
	}

}



hdfql_cursor_use_default <- function()
{

	return (.Call("hdfql_cursor_use_default", PACKAGE = "HDFqlR"))

}



hdfql_cursor_clear <- function(cursor = NULL)
{

	if (is.null(cursor) == TRUE)
	{
		return (.Call("hdfql_cursor_clear", NULL, PACKAGE = "HDFqlR"))
	}
	else
	{
		if (is(cursor, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_cursor_clear", cursor$address, PACKAGE = "HDFqlR"))
	}

}



hdfql_cursor_clone <- function(cursor_original = NULL, cursor_clone)
{

	if (is.null(cursor_original) == TRUE)
	{
		if (is(cursor_clone, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_cursor_clone", NULL, cursor_clone$address, PACKAGE = "HDFqlR"))
	}
	else
	{
		if (is(cursor_original, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		if (is(cursor_clone, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_cursor_clone", cursor_original$address, cursor_clone$address, PACKAGE = "HDFqlR"))
	}

}



hdfql_cursor_get_data_type <- function(cursor = NULL)
{

	if (is.null(cursor) == TRUE)
	{
		return (.Call("hdfql_cursor_get_data_type", NULL, PACKAGE = "HDFqlR"))
	}
	else
	{
		if (is(cursor, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_cursor_get_data_type", cursor$address, PACKAGE = "HDFqlR"))
	}

}



hdfql_cursor_get_count <- function(cursor = NULL)
{

	if (is.null(cursor) == TRUE)
	{
		return (.Call("hdfql_cursor_get_count", NULL, PACKAGE = "HDFqlR"))
	}
	else
	{
		if (is(cursor, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_cursor_get_count", cursor$address, PACKAGE = "HDFqlR"))
	}

}



hdfql_subcursor_get_count <- function(cursor = NULL)
{

	if (is.null(cursor) == TRUE)
	{
		return (.Call("hdfql_subcursor_get_count", NULL, PACKAGE = "HDFqlR"))
	}
	else
	{
		if (is(cursor, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_subcursor_get_count", cursor$address, PACKAGE = "HDFqlR"))
	}

}



hdfql_cursor_get_position <- function(cursor = NULL)
{

	if (is.null(cursor) == TRUE)
	{
		return (.Call("hdfql_cursor_get_position", NULL, PACKAGE = "HDFqlR"))
	}
	else
	{
		if (is(cursor, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_cursor_get_position", cursor$address, PACKAGE = "HDFqlR"))
	}

}



hdfql_subcursor_get_position <- function(cursor = NULL)
{

	if (is.null(cursor) == TRUE)
	{
		return (.Call("hdfql_subcursor_get_position", NULL, PACKAGE = "HDFqlR"))
	}
	else
	{
		if (is(cursor, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_subcursor_get_position", cursor$address, PACKAGE = "HDFqlR"))
	}

}



hdfql_cursor_first <- function(cursor = NULL)
{

	if (is.null(cursor) == TRUE)
	{
		return (.Call("hdfql_cursor_first", NULL, PACKAGE = "HDFqlR"))
	}
	else
	{
		if (is(cursor, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_cursor_first", cursor$address, PACKAGE = "HDFqlR"))
	}

}



hdfql_subcursor_first <- function(cursor = NULL)
{

	if (is.null(cursor) == TRUE)
	{
		return (.Call("hdfql_subcursor_first", NULL, PACKAGE = "HDFqlR"))
	}
	else
	{
		if (is(cursor, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_subcursor_first", cursor$address, PACKAGE = "HDFqlR"))
	}

}



hdfql_cursor_last <- function(cursor = NULL)
{

	if (is.null(cursor) == TRUE)
	{
		return (.Call("hdfql_cursor_last", NULL, PACKAGE = "HDFqlR"))
	}
	else
	{
		if (is(cursor, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_cursor_last", cursor$address, PACKAGE = "HDFqlR"))
	}

}



hdfql_subcursor_last <- function(cursor = NULL)
{

	if (is.null(cursor) == TRUE)
	{
		return (.Call("hdfql_subcursor_last", NULL, PACKAGE = "HDFqlR"))
	}
	else
	{
		if (is(cursor, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_subcursor_last", cursor$address, PACKAGE = "HDFqlR"))
	}

}



hdfql_cursor_next <- function(cursor = NULL)
{

	if (is.null(cursor) == TRUE)
	{
		return (.Call("hdfql_cursor_next", NULL, PACKAGE = "HDFqlR"))
	}
	else
	{
		if (is(cursor, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_cursor_next", cursor$address, PACKAGE = "HDFqlR"))
	}

}



hdfql_subcursor_next <- function(cursor = NULL)
{

	if (is.null(cursor) == TRUE)
	{
		return (.Call("hdfql_subcursor_next", NULL, PACKAGE = "HDFqlR"))
	}
	else
	{
		if (is(cursor, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_subcursor_next", cursor$address, PACKAGE = "HDFqlR"))
	}

}



hdfql_cursor_previous <- function(cursor = NULL)
{

	if (is.null(cursor) == TRUE)
	{
		return (.Call("hdfql_cursor_previous", NULL, PACKAGE = "HDFqlR"))
	}
	else
	{
		if (is(cursor, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_cursor_previous", cursor$address, PACKAGE = "HDFqlR"))
	}

}



hdfql_subcursor_previous <- function(cursor = NULL)
{

	if (is.null(cursor) == TRUE)
	{
		return (.Call("hdfql_subcursor_previous", NULL, PACKAGE = "HDFqlR"))
	}
	else
	{
		if (is(cursor, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_subcursor_previous", cursor$address, PACKAGE = "HDFqlR"))
	}

}



hdfql_cursor_absolute <- function(cursor = NULL, position)
{

	if (is.null(cursor) == TRUE)
	{
		if (is.integer(position) == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_cursor_absolute", NULL, position, PACKAGE = "HDFqlR"))
	}
	else
	{
		if (is(cursor, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		if (is.integer(position) == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_cursor_absolute", cursor$address, position, PACKAGE = "HDFqlR"))
	}

}



hdfql_subcursor_absolute <- function(cursor = NULL, position)
{

	if (is.null(cursor) == TRUE)
	{
		if (is.integer(position) == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_subcursor_absolute", NULL, position, PACKAGE = "HDFqlR"))
	}
	else
	{
		if (is(cursor, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		if (is.integer(position) == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_subcursor_absolute", cursor$address, position, PACKAGE = "HDFqlR"))
	}

}



hdfql_cursor_relative <- function(cursor = NULL, position)
{

	if (is.null(cursor) == TRUE)
	{
		if (is.integer(position) == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_cursor_relative", NULL, position, PACKAGE = "HDFqlR"))
	}
	else
	{
		if (is(cursor, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		if (is.integer(position) == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_cursor_relative", cursor$address, position, PACKAGE = "HDFqlR"))
	}

}



hdfql_subcursor_relative <- function(cursor = NULL, position)
{

	if (is.null(cursor) == TRUE)
	{
		if (is.integer(position) == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_subcursor_relative", NULL, position, PACKAGE = "HDFqlR"))
	}
	else
	{
		if (is(cursor, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		if (is.integer(position) == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_subcursor_relative", cursor$address, position, PACKAGE = "HDFqlR"))
	}

}



hdfql_cursor_get_size <- function(cursor = NULL)
{

	if (is.null(cursor) == TRUE)
	{
		return (.Call("hdfql_cursor_get_size", NULL, PACKAGE = "HDFqlR"))
	}
	else
	{
		if (is(cursor, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_cursor_get_size", cursor$address, PACKAGE = "HDFqlR"))
	}

}



hdfql_subcursor_get_size <- function(cursor = NULL)
{

	if (is.null(cursor) == TRUE)
	{
		return (.Call("hdfql_subcursor_get_size", NULL, PACKAGE = "HDFqlR"))
	}
	else
	{
		if (is(cursor, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_subcursor_get_size", cursor$address, PACKAGE = "HDFqlR"))
	}

}



hdfql_cursor_get_tinyint <- function(cursor = NULL)
{

	if (is.null(cursor) == TRUE)
	{
		return (.Call("hdfql_cursor_get_tinyint", NULL, PACKAGE = "HDFqlR"))
	}
	else
	{
		if (is(cursor, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_cursor_get_tinyint", cursor$address, PACKAGE = "HDFqlR"))
	}

}



hdfql_subcursor_get_tinyint <- function(cursor = NULL)
{

	if (is.null(cursor) == TRUE)
	{
		return (.Call("hdfql_subcursor_get_tinyint", NULL, PACKAGE = "HDFqlR"))
	}
	else
	{
		if (is(cursor, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_subcursor_get_tinyint", cursor$address, PACKAGE = "HDFqlR"))
	}

}



hdfql_cursor_get_unsigned_tinyint <- function(cursor = NULL)
{

	if (is.null(cursor) == TRUE)
	{
		return (.Call("hdfql_cursor_get_unsigned_tinyint", NULL, PACKAGE = "HDFqlR"))
	}
	else
	{
		if (is(cursor, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_cursor_get_unsigned_tinyint", cursor$address, PACKAGE = "HDFqlR"))
	}

}



hdfql_subcursor_get_unsigned_tinyint <- function(cursor = NULL)
{

	if (is.null(cursor) == TRUE)
	{
		return (.Call("hdfql_subcursor_get_unsigned_tinyint", NULL, PACKAGE = "HDFqlR"))
	}
	else
	{
		if (is(cursor, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_subcursor_get_unsigned_tinyint", cursor$address, PACKAGE = "HDFqlR"))
	}

}



hdfql_cursor_get_smallint <- function(cursor = NULL)
{

	if (is.null(cursor) == TRUE)
	{
		return (.Call("hdfql_cursor_get_smallint", NULL, PACKAGE = "HDFqlR"))
	}
	else
	{
		if (is(cursor, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_cursor_get_smallint", cursor$address, PACKAGE = "HDFqlR"))
	}

}



hdfql_subcursor_get_smallint <- function(cursor = NULL)
{

	if (is.null(cursor) == TRUE)
	{
		return (.Call("hdfql_subcursor_get_smallint", NULL, PACKAGE = "HDFqlR"))
	}
	else
	{
		if (is(cursor, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_subcursor_get_smallint", cursor$address, PACKAGE = "HDFqlR"))
	}

}



hdfql_cursor_get_unsigned_smallint <- function(cursor = NULL)
{

	if (is.null(cursor) == TRUE)
	{
		return (.Call("hdfql_cursor_get_unsigned_smallint", NULL, PACKAGE = "HDFqlR"))
	}
	else
	{
		if (is(cursor, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_cursor_get_unsigned_smallint", cursor$address, PACKAGE = "HDFqlR"))
	}

}



hdfql_subcursor_get_unsigned_smallint <- function(cursor = NULL)
{

	if (is.null(cursor) == TRUE)
	{
		return (.Call("hdfql_subcursor_get_unsigned_smallint", NULL, PACKAGE = "HDFqlR"))
	}
	else
	{
		if (is(cursor, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_subcursor_get_unsigned_smallint", cursor$address, PACKAGE = "HDFqlR"))
	}

}



hdfql_cursor_get_int <- function(cursor = NULL)
{

	if (is.null(cursor) == TRUE)
	{
		return (.Call("hdfql_cursor_get_int", NULL, PACKAGE = "HDFqlR"))
	}
	else
	{
		if (is(cursor, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_cursor_get_int", cursor$address, PACKAGE = "HDFqlR"))
	}

}



hdfql_subcursor_get_int <- function(cursor = NULL)
{

	if (is.null(cursor) == TRUE)
	{
		return (.Call("hdfql_subcursor_get_int", NULL, PACKAGE = "HDFqlR"))
	}
	else
	{
		if (is(cursor, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_subcursor_get_int", cursor$address, PACKAGE = "HDFqlR"))
	}

}



hdfql_cursor_get_unsigned_int <- function(cursor = NULL)
{

	if (is.null(cursor) == TRUE)
	{
		return (.Call("hdfql_cursor_get_unsigned_int", NULL, PACKAGE = "HDFqlR"))
	}
	else
	{
		if (is(cursor, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_cursor_get_unsigned_int", cursor$address, PACKAGE = "HDFqlR"))
	}

}



hdfql_subcursor_get_unsigned_int <- function(cursor = NULL)
{

	if (is.null(cursor) == TRUE)
	{
		return (.Call("hdfql_subcursor_get_unsigned_int", NULL, PACKAGE = "HDFqlR"))
	}
	else
	{
		if (is(cursor, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_subcursor_get_unsigned_int", cursor$address, PACKAGE = "HDFqlR"))
	}

}



hdfql_cursor_get_bigint <- function(cursor = NULL)
{

	if (is.null(cursor) == TRUE)
	{
		return (.Call("hdfql_cursor_get_bigint", NULL, PACKAGE = "HDFqlR"))
	}
	else
	{
		if (is(cursor, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_cursor_get_bigint", cursor$address, PACKAGE = "HDFqlR"))
	}

}



hdfql_subcursor_get_bigint <- function(cursor = NULL)
{

	if (is.null(cursor) == TRUE)
	{
		return (.Call("hdfql_subcursor_get_bigint", NULL, PACKAGE = "HDFqlR"))
	}
	else
	{
		if (is(cursor, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_subcursor_get_bigint", cursor$address, PACKAGE = "HDFqlR"))
	}

}



hdfql_cursor_get_unsigned_bigint <- function(cursor = NULL)
{

	if (is.null(cursor) == TRUE)
	{
		return (.Call("hdfql_cursor_get_unsigned_bigint", NULL, PACKAGE = "HDFqlR"))
	}
	else
	{
		if (is(cursor, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_cursor_get_unsigned_bigint", cursor$address, PACKAGE = "HDFqlR"))
	}

}



hdfql_subcursor_get_unsigned_bigint <- function(cursor = NULL)
{

	if (is.null(cursor) == TRUE)
	{
		return (.Call("hdfql_subcursor_get_unsigned_bigint", NULL, PACKAGE = "HDFqlR"))
	}
	else
	{
		if (is(cursor, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_subcursor_get_unsigned_bigint", cursor$address, PACKAGE = "HDFqlR"))
	}

}



hdfql_cursor_get_float <- function(cursor = NULL)
{

	if (is.null(cursor) == TRUE)
	{
		return (.Call("hdfql_cursor_get_float", NULL, PACKAGE = "HDFqlR"))
	}
	else
	{
		if (is(cursor, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_cursor_get_float", cursor$address, PACKAGE = "HDFqlR"))
	}

}



hdfql_subcursor_get_float <- function(cursor = NULL)
{

	if (is.null(cursor) == TRUE)
	{
		return (.Call("hdfql_subcursor_get_float", NULL, PACKAGE = "HDFqlR"))
	}
	else
	{
		if (is(cursor, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_subcursor_get_float", cursor$address, PACKAGE = "HDFqlR"))
	}

}



hdfql_cursor_get_double <- function(cursor = NULL)
{

	if (is.null(cursor) == TRUE)
	{
		return (.Call("hdfql_cursor_get_double", NULL, PACKAGE = "HDFqlR"))
	}
	else
	{
		if (is(cursor, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_cursor_get_double", cursor$address, PACKAGE = "HDFqlR"))
	}

}



hdfql_subcursor_get_double <- function(cursor = NULL)
{

	if (is.null(cursor) == TRUE)
	{
		return (.Call("hdfql_subcursor_get_double", NULL, PACKAGE = "HDFqlR"))
	}
	else
	{
		if (is(cursor, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_subcursor_get_double", cursor$address, PACKAGE = "HDFqlR"))
	}

}



hdfql_cursor_get_char <- function(cursor = NULL)
{

	if (is.null(cursor) == TRUE)
	{
		return (.Call("hdfql_cursor_get_char", NULL, PACKAGE = "HDFqlR"))
	}
	else
	{
		if (is(cursor, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_cursor_get_char", cursor$address, PACKAGE = "HDFqlR"))
	}

}



hdfql_subcursor_get_char <- function(cursor = NULL)
{

	if (is.null(cursor) == TRUE)
	{
		return (.Call("hdfql_subcursor_get_char", NULL, PACKAGE = "HDFqlR"))
	}
	else
	{
		if (is(cursor, "hdfql_cursor_") == FALSE)
		{
			return (HDFQL_ERROR_UNEXPECTED_DATA_TYPE)
		}
		return (.Call("hdfql_subcursor_get_char", cursor$address, PACKAGE = "HDFqlR"))
	}

}



#===========================================================
# VARIABLE FUNCTIONS
#===========================================================
hdfql_variable_register <- function(variable)
{

	return (.Call("hdfql_variable_register", variable, PACKAGE = "HDFqlR"))

}



hdfql_variable_unregister <- function(variable)
{

	return (.Call("hdfql_variable_unregister", variable, PACKAGE = "HDFqlR"))

}



hdfql_variable_get_number <- function(variable)
{

	return (.Call("hdfql_variable_get_number", variable, PACKAGE = "HDFqlR"))

}



hdfql_variable_get_data_type <- function(variable)
{

	return (.Call("hdfql_variable_get_data_type", variable, PACKAGE = "HDFqlR"))

}



hdfql_variable_get_count <- function(variable)
{

	return (.Call("hdfql_variable_get_count", variable, PACKAGE = "HDFqlR"))

}



hdfql_variable_get_size <- function(variable)
{

	return (.Call("hdfql_variable_get_size", variable, PACKAGE = "HDFqlR"))

}



hdfql_variable_get_dimension_count <- function(variable)
{

	return (.Call("hdfql_variable_get_dimension_count", variable, PACKAGE = "HDFqlR"))

}



hdfql_variable_get_dimension <- function(variable, index)
{

	return (.Call("hdfql_variable_get_dimension", variable, index, PACKAGE = "HDFqlR"))

}



#===========================================================
# MPI FUNCTIONS
#===========================================================
hdfql_mpi_get_size <- function()
{

	return (.Call("hdfql_mpi_get_size", PACKAGE = "HDFqlR"))

}



hdfql_mpi_get_rank <- function()
{

	return (.Call("hdfql_mpi_get_rank", PACKAGE = "HDFqlR"))

}



#===========================================================
# REFRESH R OBJECT TABLE
#===========================================================
cacheMetaData(1)

