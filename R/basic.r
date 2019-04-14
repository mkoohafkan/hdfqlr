#' Value From Memory
#'
#' Generic helper for executing HDFql operations.
#'
#' @param script The HDFQL operation to execute. 
#'   Do not include `INTO` statements.
#' @param variable if not `NULL`, read the output into this variable.
#' @param suffix Additional script specifications.
#' @return The script output, or `NULL`.
#'
#' @keywords internal
get_value = function(script, variable = NULL, suffix = NULL) {
  if (!is.null(variable)) {
    if (HDFql.constants$hdfql_variable_register(variable) < 0L)
      stop("error registering variable")
    on.exit(HDFql.constants$hdfql_variable_unregister(variable))
    script = paste(script, sprintf("INTO MEMORY %d", variable))
  }
  if (!is.null(suffix)) {
    script = paste(script, suffix)
  }
	if (HDFql.constants$hdfql_execute(script) != HDFql.constants$HDFQL_SUCCESS)
    stop(HDFql.constants$hdfql_error_get_message())
  variable
}


#' Value From Cursor
#'
#' Generic helper for executing HDFql cursor operations.
#'
#' @inheritParams get_value
#' @return The script output, or `NULL`.
#'
#' @keywords internal
get_cursor_values = function(script) {
  container = get_container(script)
  dtype = get_key(HDFql.constants$hdfql_cursor_get_data_type(),
    hdfql_dtypes(), TRUE)
  cursor = get_key(dtype, hdfql_data_cursors())
  for (i in seq_along(container)) {
    HDFql.constants$hdfql_cursor_next()
    container[i] = cursor()
  }
  container
}

#' HDFql memory constructor
#'
#' Construct an R object for reading HDFql query result into memory.
#'
#' @inheritParams get_value
#' @return An empty R object of the correct size and type.
#'
#' @keywords internal
get_container = function(script) {
  get_value(script)
  n = HDFql.constants$hdfql_cursor_get_count()
  dtype = get_key(HDFql.constants$hdfql_cursor_get_data_type(),
    hdfql_dtypes(), TRUE)
  rtype = dtype_to_rtype(dtype)
  vector(rtype, n)
}

#' Get HDF Object Type
#'
#' @param path The location of the object within the HDF file.
#' @return The HDF object type.
#'
#' @keywords internal
get_type = function(path) {
  script = sprintf('SHOW TYPE "%s"', path)
  out = get_value(script, integer(1))
  get_key(out, hdfql_otypes(), TRUE)
}

#' Get HDF Object Data Type
#'
#' @inheritParams get_type
#' @param otype The HDF object type.
#' @return The HDF object data type.
#'
#' @keywords internal
get_datatype = function(path, otype) {
  if(missing(otype))
    otype = get_key(get_type(path), hdfql_keywords(), FALSE)
  script = sprintf('SHOW %s DATA TYPE "%s"', otype, path)
  out = get_value(script, integer(1))  
  get_key(out, hdfql_dtypes(), TRUE)
}

#' Get HDF Object Dimension
#'
#' @inheritParams get_datatype
#' @return The HDF object dimensions.
#'
#' @keywords internal
get_dimension = function(path, otype) {
	if (missing(otype))
		otype = get_key(get_type(path), hdfql_keywords(), FALSE)
	if (otype == "HDFQL_ATTRIBUTE")
		otype = ""
	script = sprintf('SHOW %s DIMENSION "%s"', otype, path)
	out = get_value(script, integer(32))
	out[out > 0L]
}

#' Get HDF Object Charset
#'
#' @inheritParams get_datatype
#' @return The HDF object charset.
#'
#' @keywords internal
get_charset = function(path, otype) {
  if(missing(otype))
    otype = get_key(get_type(path), hdfql_keywords(), FALSE)
  script = sprintf('SHOW %s CHARSET "%s"', otype, path)
  out = get_value(script, integer(1))
  if (HDFql.constants$hdfql_execute(script) < 0L)
    stop(HDFql.constants$hdfql_error_get_message())
  get_key(out, hdfql_charsets(), TRUE)
}

#' Get HDF Object Size
#'
#' @inheritParams get_datatype
#' @return The HDF object size.
#'
#' @keywords internal
get_size = function(path, otype) {
  if(missing(otype))
    otype = get_key(get_type(path), hdfql_keywords(), FALSE)
  script = sprintf('SHOW %s SIZE "%s"', otype, path)
  out = get_value(script, integer(1))
  out
}

#' HDF Data Type to R Type
#'
#' @param dtype The HDF data type.
#' @return The equivalent R class, or `NULL` if not found.
#'
#' @keywords internal
dtype_to_rtype = function(dtype) {
	rtype = get_key(dtype, hdfql_Rtypes(), FALSE)
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
	dtype = get_key(rtype, hdfql_Rtypes(), TRUE)
	# drop "var" types
	dtype = dtype[!grepl("VAR.+$", dtype)]
	if (is.null(dtype) || length(dtype) == 0L) {
		stop("No corresponding HDF data type for R class ", rtype)
	}
  dtype
}

#' Get Data
#'
#' Get data from HDF file.
#'
#' @inheritParams get_datatype
#' @param transpose If `TRUE`, transpose the data.
#' @return An R array.
#'
#' @keywords internal
get_data = function(path, otype, transpose = TRUE) {
  if(missing(otype))
    otype = get_key(get_type(path), hdfql_keywords(), FALSE)
  dtype = get_datatype(path, otype)
  if (dtype == "HDFQL_CHAR")
    return(get_char_data(path, otype))
  dtype = dtype_to_rtype(dtype)
  dims = get_dimension(path, otype)
  script = sprintf('SELECT FROM %s "%s"', otype, path)
  out = get_value(script, array(vector(dtype, prod(dims)),
    dim = rev(dims)))
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
#' @inheritParams get_datatype
#' @return An R array.
#'
#' @keywords internal
get_char_data = function(path, otype) {
  total.size = get_size(path)
  column.length = get_dimension(path)
  if (identical(column.length, integer(0)))
    column.length = 1
  string.size = total.size %/% column.length
  dims = c(column.length, string.size)
  dtype = "integer"
  script = sprintf('SELECT FROM %s "%s"', otype, path)
  out = get_value(script, array(vector(dtype, prod(dims)),
    dim = rev(dims)))
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
  get_value(script)
  invisible(TRUE)
}

#' @rdname use_file
#' @keywords internal
close_file = function(file) {
  script = sprintf('CLOSE FILE "%s"', file)
  get_value(script)
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
