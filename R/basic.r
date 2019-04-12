#' HDFql Operation
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
  if (HDFql.constants$hdfql_execute(script) < 0L)
    stop(HDFql.constants$hdfql_error_get_message())
  variable
}


#' HDFql Cursor Operation
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


get_type = function(path) {
  script = sprintf('SHOW TYPE "%s"', path)
  out = get_value(script, integer(1))
  get_key(out, hdfql_otypes(), TRUE)
}

get_dimension = function(path, otype) {
  if(missing(otype))
    otype = get_key(get_type(path), hdfql_keywords(), FALSE)
  if (otype == "HDFQL_ATTRIBUTE")
    otype = ""
  script = sprintf('SHOW %s DIMENSION "%s"', otype, path)
  out = get_value(script, integer(32))
  out[out > 0L]
}

get_datatype = function(path, otype) {
  if(missing(otype))
    otype = get_key(get_type(path), hdfql_keywords(), FALSE)
  script = sprintf('SHOW %s DATA TYPE "%s"', otype, path)
  out = get_value(script, integer(1))  
  get_key(out, hdfql_dtypes(), TRUE)
}


get_charset = function(path, otype) {
  if(missing(otype))
    otype = get_key(get_type(path), hdfql_keywords(), FALSE)
  script = sprintf('SHOW %s CHARSET "%s"', otype, path)
  out = get_value(script, integer(1))
  if (HDFql.constants$hdfql_execute(script) < 0L)
    stop(HDFql.constants$hdfql_error_get_message())
  get_key(out, hdfql_charsets(), TRUE)
}

get_size = function(path, otype) {
  if(missing(otype))
    otype = get_key(get_type(path), hdfql_keywords(), FALSE)
  script = sprintf('SHOW %s SIZE "%s"', otype, path)
  out = get_value(script, integer(1))
  out
}


dtype_to_rtype = function(dtype) {
  rtype = get_key(dtype, hdfql_Rtypes(), FALSE)
  if (rtype == "integer64") {
    if (!requireNamespace("bit64")) {
      stop("Support for ", dtype, 'requires package "bit64"')
    }
  }
  rtype
}

rtype_to_dtype = function(rtype, as.int = TRUE) {
## not 1:1

#  dtype = names(hdfql.Rtypes)[which(hdfql.Rtypes == rtype)]
#
 # if (as.int)
  #  hdfql.vartypes[rtype]
}


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

int_to_char = function(x) {
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
  trimws(y, "both")
}

use_file = function(path) {
  script = sprintf('USE FILE "%s"', path)
  get_value(script)
  invisible(TRUE)
}

close_file = function(path) {
  script = sprintf('CLOSE FILE "%s"', path)
  get_value(script)
  invisible(TRUE)
}

get_attr_names = function(path) {
  if (missing(path))
    path = ""
  script = sprintf('SHOW ATTRIBUTE "%s/"', path)
  get_cursor_values(script)

#  get_value(script)
#  num.attr = HDFql.constants$hdfql_cursor_get_count()
#  attr.names = vector("character", num.attr)
#  for (i in seq_along(attr.names)) {
#    HDFql.constants$hdfql_cursor_next()
#    attr.names[i] = HDFql.constants$hdfql_cursor_get_char()
#  }
#  attr.names
}

