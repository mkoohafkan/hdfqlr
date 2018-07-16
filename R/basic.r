get_error = function() {
  out = character(1)
  if (hdfql_variable_register(out) < 0L)
    stop("error registering variable")
  on.exit(hdfql_variable_unregister(out))
}

get_dimension = function(path, otype) {
  if(missing(otype))
    otype = hdfql.keywords[[(get_type(path))]]
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
    otype = hdfql.keywords[[(get_type(path))]]
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

get_string = function(path, otype) {
  if(missing(otype))
    otype = hdfql.keywords[[(get_type(path))]]


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


get_data = function(path, otype) {
  if(missing(otype))
    otype = hdfql.keywords[[(get_type(path))]]
  dims = get_dimension(path, otype)
  dtype = htype_to_rtype(get_datatype(path))
  out = array(vector(dtype, prod(dims)), dim = rev(dims))
  if (hdfql_variable_register(out) < 0L)
    stop("error registering variable")
  on.exit(hdfql_variable_unregister(out))
  script = sprintf('SELECT FROM %s "%s" INTO MEMORY %d',
    otype, path, hdfql_variable_get_number(out))
  if (hdfql_execute(script) < 0L)
    stop(hdfql_error_get_message())
  if (identical(dims, 1L))
    out
  else
    aperm(out)
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


