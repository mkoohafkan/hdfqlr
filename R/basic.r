#' Execute With Memory
#'
#' Generic helper for executing HDFql operations using memory.
#'
#' @param script The HDFQL operation to execute. 
#'   Do not include `FROM` or `INTO` statements.
#' @param variable if not `NULL`, read the output into this variable.
#' @param direction Either `"FROM"` or `"INTO"`. Ignored if variable
#'   is `NULL`.
#' @param suffix Additional script specifications. This can be used for
#'   post-processing (for SELECT operations) or for writing raw values
#'   (for INSERT operations).
#' @param stop.on.error If `TRUE`, return an error message if script
#'   fails. If `FALSE`, return the HDFql error value.
#' @return The script output, or `NULL`.
#' 
#' @keywords internal
execute_with_memory = function(script, variable = NULL,
	direction = c("INTO", "FROM"), suffix = NULL,
	stop.on.error = TRUE) {
	if (!is.null(variable)) {
		direction = match.arg(toupper(direction), c("INTO", "FROM"))
		if (HDFql.constants$hdfql_variable_register(variable) < 0L)
			stop("error registering variable")
		on.exit(HDFql.constants$hdfql_variable_unregister(variable))
		script = paste(script, sprintf("%s MEMORY %d", direction,
			HDFql.constants$hdfql_variable_get_number(variable)))
	}
	if (!is.null(suffix)) {
		script = paste(script, suffix)
	}
	hdfql.result = HDFql.constants$hdfql_execute(script)
	if (hdfql.result != HDFql.constants$HDFQL_SUCCESS) {
		if (stop.on.error) {
			stop(HDFql.constants$hdfql_error_get_message())
		} else {
			return(hdfql.result)
		}
	}
	if (!is.null(variable) && direction == "INTO") {
		variable
	} else {
		invisible(NULL)
	}
}

#' Value From Cursor
#'
#' Generic helper for executing HDFql cursor operations.
#'
#' @inheritParams execute_with_memory
#' @return The script output, or `NULL`.
#'
#' @keywords internal
get_cursor_values = function(script) {
	execute_with_memory(script)
	n = HDFql.constants$hdfql_cursor_get_count()
	dtype = get_key(HDFql.constants$hdfql_cursor_get_data_type(),
		hql_data_types(), TRUE)
	rtype = dtype_to_rtype(dtype)
	container = vector(rtype, n)
  cursor = get_key(dtype, hql_data_cursors())
  for (i in seq_along(container)) {
    HDFql.constants$hdfql_cursor_next()
    container[i] = cursor()
  }
  container
}

#' Get HDF Object Type
#'
#' @param path The location of the object within the HDF file.
#' @return The HDF object type.
#'
#' @keywords internal
get_object_type = function(path) {
  script = sprintf('SHOW TYPE "%s"', path)
  out = execute_with_memory(script, integer(1), "INTO")
  get_key(out, hql_object_types(), TRUE)
}

#' Get HDF Object Data Type
#'
#' @inheritParams get_object_type
#' @param otype The HDF object type.
#' @return The HDF object data type.
#'
#' @keywords internal
get_data_type = function(path, otype) {
  if(missing(otype))
		otype = gsub("^HDFQL_", "", get_object_type(path))
  script = sprintf('SHOW %s DATA TYPE "%s"', otype, path)
  out = execute_with_memory(script, integer(1), "INTO")  
  get_key(out, hql_data_types(), TRUE)
}

#' Get HDF Object Dimension
#'
#' @inheritParams get_data_type
#' @return The HDF object dimensions.
#'
#' @keywords internal
get_dimension = function(path, otype) {
	if (missing(otype))
		otype = gsub("^HDFQL_", "", get_object_type(path))
	if (otype == "HDFQL_ATTRIBUTE")
		otype = ""
	script = sprintf('SHOW %s DIMENSION "%s"', otype, path)
	out = execute_with_memory(script, integer(32), "INTO")
	out[out > 0L]
}

#' Get HDF Object Charset
#'
#' @inheritParams get_data_type
#' @return The HDF object charset.
#'
#' @keywords internal
get_charset = function(path, otype) {
  if(missing(otype))
		otype = gsub("^HDFQL_", "", get_object_type(path))
  script = sprintf('SHOW %s CHARSET "%s"', otype, path)
	out = execute_with_memory(script, integer(1), "INTO")
  if (HDFql.constants$hdfql_execute(script) < 0L)
    stop(HDFql.constants$hdfql_error_get_message())
  get_key(out, hql_charsets(), TRUE)
}

#' Get HDF Object Size
#'
#' @inheritParams get_data_type
#' @return The HDF object size.
#'
#' @keywords internal
get_size = function(path, otype) {
  if(missing(otype))
		otype = gsub("^HDFQL_", "", get_object_type(path))
  script = sprintf('SHOW %s SIZE "%s"', otype, path)
	out = execute_with_memory(script, integer(1), "INTO")
  out
}

#' HDF Data Type to R Type
#'
#' @param dtype The HDF data type.
#' @return The equivalent R class, or `NULL` if not found.
#'
#' @keywords internal
dtype_to_rtype = function(dtype) {
	rtype = get_key(dtype, hql_Rtypes(), FALSE)
	if (is.null(rtype) || length(rtype) == 0L) {
		stop("No corresponding R class for HDF data type ", dtype)
	}
  if (rtype == "integer64") {
    if (!requireNamespace("bit64")) {
      stop("Support for ", dtype, 'requires package "bit64"')
    }
  }
  rtype
}

#' R Type to HDF Data Type
#'
#' @param rtype The R class.
#' @return The equivalent HDF data type, or `NULL` if not found.
#'
#' @keywords internal
rtype_to_dtype = function(rtype) {
	dtype = get_key(rtype, hql_Rtypes(), TRUE)
	# drop "var" types
	dtype = dtype[!grepl("VAR.+$", dtype)]
	# drop "tiny", small, and unsigned
	dtype = dtype[!grepl("TINY|SMALL|UNSIGNED", dtype)]
	# drop float
	dtype = dtype[!grepl("FLOAT", dtype)]
	if (is.null(dtype) || length(dtype) == 0L) {
		stop("No corresponding HDF data type for R class ", rtype)
	}
  dtype
}

#' Get Data
#'
#' Get data from HDF file.
#'
#' @inheritParams get_data_type
#' @param transpose If `TRUE`, transpose the data.
#' @param parallel Use parallel processing functionality.
#' @return An R array.
#'
#' @keywords internal
get_data = function(path, otype, transpose = TRUE, parallel = FALSE) {
  if(missing(otype))
    otype = gsub("^HDFQL_", "", get_object_type(path))
  dtype = get_data_type(path, otype)
  if (dtype == "HDFQL_CHAR")
    return(get_char_data(path, otype, parallel))
	if (parallel) {
		pre = "PARALLEL"
	} else {
		pre = ""
	}
  rtype = dtype_to_rtype(dtype)
  dims = get_dimension(path, otype)
  script = sprintf('SELECT FROM %s %s "%s"', pre, otype, path)
  out = execute_with_memory(script, array(vector(rtype, prod(dims)),
		dim = rev(dims)), "INTO")
  if (identical(dims, 1L)) {
    out
  } else if (transpose) {
    aperm(out)
  } else {
    out
  }
}

#' Get Character Data
#'
#' Get character data from HDF file.
#'
#' @inheritParams get_data
#' @return An R array.
#'
#' @keywords internal
get_char_data = function(path, otype, parallel = FALSE) {
	if (parallel) {
		pre = "PARALLEL"
	} else {
		pre = ""
	}
	total.size = get_size(path)
  column.length = get_dimension(path)
  if (identical(column.length, integer(0)))
    column.length = 1
  string.size = total.size %/% column.length
  dims = c(column.length, string.size)
  rtype = "integer"
  script = sprintf('SELECT FROM %s %s "%s"', pre, otype, path)
  out = execute_with_memory(script, array(vector(rtype, prod(dims)),
		dim = rev(dims)), "INTO")
  apply(out, 2, function(x) int_to_char(x))
}

#' HDF Integer Output to Character
#'
#' Convert integer data from an HDF file to characters.
#'
#' @param x An integer array.
#' @param trim If `TRUE`, trim whitespace from the character data.
#' @return A character array.
#'
#' @keywords internal
int_to_char = function(x, trim = FALSE) {
  y = tryCatch(rawToChar(as.raw(x)),
    error = function(e) e)
  if ("error" %in% class(y)) {
    warning(y$message, call. = FALSE)
    # handle embedded nuls
    y = readBin(as.raw(x), "raw", length(x))
    y[y == as.raw(0)] = as.raw(0x20)
    y = rawToChar(y)
  }
	# remove whitespace
	if (trim) {
		trimws(y, "both")
	} else {
		y
	}
}

#' Use HDF File
#'
#' @param file The HDF file path.
#'
#' @keywords internal
use_file = function(file) {
  script = sprintf('USE FILE "%s"', file)
  execute_with_memory(script)
  invisible(TRUE)
}

#' @rdname use_file
#' @keywords internal
close_file = function(file) {
  script = sprintf('CLOSE FILE "%s"', file)
  execute_with_memory(script)
  invisible(TRUE)
}

#' Get HDF Attribute Names
#'
#' @param path The path of the dataset or group from which to 
#'  retrieve attribute names.
#' @return A vector of attribute names.
#'
#' @keywords internal
get_attr_names = function(path) {
  if (missing(path))
    path = ""
  script = sprintf('SHOW ATTRIBUTE "%s/"', path)
  get_cursor_values(script)
}

#' Set Data
#'
#' Set data in HDF file.
#'
#' @inheritParams get_data
#'
#' @keywords internal
set_data = function(x, path, otype, transpose = TRUE,
	parallel = FALSE) {
	if (missing(otype))
		otype = gsub("^HDFQL_", "", get_object_type(path))
	dtype = get_data_type(path)
	rtype = typeof(x)
	if (get_key(dtype, hql_Rtypes()) != rtype) {
		stop('Input data is type "', rtype,
			'" but target location is type "',
			gsub("^HDFQL_", "", dtype), '"')
	}
	if (rtype == "character") {
		return(set_char_data(x, path, otype, FALSE, parallel))
	}
	if (parallel) {
		pre = "PARALLEL"
	} else {
		pre = ""
	}
	script = sprintf('INSERT INTO %s %s "%s" VALUES', pre, otype, path)
	if (transpose) {
		execute_with_memory(script, aperm(x), "FROM")
	} else {
		execute_with_memory(script, x, "FROM")
	}
}

#' Set Character Data
#'
#' Set character data in HDF file.
#'
#' @inheritParams set_data
#'
#' @keywords internal
set_char_data = function(x, path, otype, transpose = FALSE,
  parallel = FALSE) {
	if (parallel) {
		pre = "PARALLEL"
	} else {
		pre = ""
	}
	max.string.size = max(nchar(x))
	x = format(x, with = max.string.size)
	xint = apply(sapply(x, charToRaw, USE.NAMES = FALSE),
		c(1, 2), as.integer)
	script = sprintf('INSERT INTO %s %s "%s" VALUES', pre, otype, path)
	if (transpose) {
		execute_with_memory(script, aperm(xint), "FROM")
	} else {
		execute_with_memory(script, xint, "FROM")
	}
}
