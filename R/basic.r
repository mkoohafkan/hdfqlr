get_error = function() {
  out = character(1)
  if (hdfql_variable_register(out) < 0L)
    stop("error registering variable")
  on.exit(hdfql_variable_unregister(out))
}

get_dimension = function(path, otype) {
  if(missing(otype))
    otype = hdfql.keywords[[(get_type(path))]]
  if (otype == "HDFQL_ATTRIBUTE")
    otype = ""
  out = integer(32) 
  if (hdfql_variable_register(out) < 0L)
    stop("error registering variable")
  on.exit(hdfql_variable_unregister(out))
  script = sprintf('SHOW %s DIMENSION "%s" INTO MEMORY %d',
    otype, path, hdfql_variable_get_number(out))
  if(hdfql_execute(script) < 0L)
    stop(hdfql_error_get_message())
    out[out > 0L]
}

get_datatype = function(path, otype) {
  if(missing(otype))
    otype = hdfql.keywords[[get_type(path)]]
 # if (otype == "HDFQL_ATTRIBUTE")
 #   otype = ""
  out = integer(1)
  if (hdfql_variable_register(out) < 0L)
    stop("error registering variable")
  on.exit(hdfql_variable_unregister(out))
  script = sprintf('SHOW %s DATATYPE "%s" INTO MEMORY %d',
    otype, path, hdfql_variable_get_number(out))
  if (hdfql_execute(script) < 0L)
    stop(hdfql_error_get_message())
  names(hdfql.dtypes)[which(hdfql.dtypes == out)]
}


get_charset = function(path, otype) {
  if(missing(otype))
    otype = hdfql.keywords[[(get_type(path))]]
  out = integer(1)
  if (hdfql_variable_register(out) < 0L)
    stop("error registering variable")
  on.exit(hdfql_variable_unregister(out))
  script = sprintf('SHOW %s CHARSET "%s" INTO MEMORY %d',
    otype, path, hdfql_variable_get_number(out))
  if (hdfql_execute(script) < 0L)
    stop(hdfql_error_get_message())
  names(hdfql.charsets)[which(hdfql.charsets == out)]
}


get_type = function(path) {
  out = integer(1)
  if (hdfql_variable_register(out) < 0L)
    stop("error registering variable")
  on.exit(hdfql_variable_unregister(out))
  script = sprintf('SHOW TYPE "%s" INTO MEMORY %d',
    path, hdfql_variable_get_number(out))
  if (hdfql_execute(script) < 0L)
    stop(hdfql_error_get_message())
  names(hdfql.otypes)[which(hdfql.otypes == out)]
}

get_size = function(path, otype) {
  if(missing(otype))
    otype = hdfql.keywords[[(get_type(path))]]
  out = integer(1)
  if (hdfql_variable_register(out) < 0L)
    stop("error registering variable")
  on.exit(hdfql_variable_unregister(out))
  script = sprintf('SHOW %s SIZE "%s" INTO MEMORY %d',
    otype, path, hdfql_variable_get_number(out))
  if (hdfql_execute(script) < 0L)
    stop(hdfql_error_get_message())
  out
}


htype_to_rtype = function(htype) {
  hdfql.Rtypes[[htype]]
}

rtype_to_htype = function(rtype, as.int = TRUE) {
## not 1:1
#  htype = names(hdfql.Rtypes)[which(hdfql.Rtypes == rtype)]
#
 # if (as.int)
  #  hdfql.vartypes[rtype]
}


get_data = function(path, otype, transpose = TRUE) {
  if(missing(otype))
    otype = hdfql.keywords[[(get_type(path))]]
  hdtype = get_datatype(path, otype)
  if (hdtype == "HDFQL_CHAR")
    return(get_char_data(path, otype))
  dtype = htype_to_rtype(hdtype)
  dims = get_dimension(path, otype)
  out = array(vector(dtype, prod(dims)), dim = rev(dims))
  if (hdfql_variable_register(out) < 0L)
    stop("error registering variable")
  on.exit(hdfql_variable_unregister(out))
  script = sprintf('SELECT FROM %s "%s" INTO MEMORY %d',
    otype, path, hdfql_variable_get_number(out))
  if (hdfql_execute(script) < 0L)
    stop(hdfql_error_get_message())
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
  out = array(vector(dtype, prod(dims)), dim = rev(dims))
  if (hdfql_variable_register(out) < 0L)
    stop("error registering variable")
  on.exit(hdfql_variable_unregister(out))
  script = sprintf('SELECT FROM %s "%s" INTO MEMORY %d',
    otype, path, hdfql_variable_get_number(out))
  if (hdfql_execute(script) < 0L)
    stop(hdfql_error_get_message())
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
  if (hdfql_execute(script) < 0L)
    stop(hdfql_error_get_message())
  invisible(TRUE)
}

close_file = function(path) {
  script = sprintf('CLOSE FILE "%s"', path)
  if (hdfql_execute(script) < 0L)
    stop(hdfql_error_get_message())
  invisible(TRUE)
}

get_attr_names = function(path) {
  if (missing(path))
    path = ""
  script = sprintf('SHOW ATTRIBUTE "%s/"', path)
  if (hdfql_execute(script) < 0L)
    stop(hdfql_error_get_message())
  num.attr = hdfql_cursor_get_count()
  attr.names = vector("character", num.attr)
  for (i in seq_along(attr.names)) {
    hdfql_cursor_next()
    attr.names[i] = hdfql_cursor_get_char()
  }
  attr.names
}

