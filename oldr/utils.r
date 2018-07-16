# choose function for cursor read
cursor_getfun = function(cursor) {
  # identify type
  varnum = hdfql_cursor_get_datatype(cursor)
  varname = names(hdfql.vartypes)[which(hdfql.vartypes == varnum)]
  hdfql.cursorget[[varname]]
}


# choose R variable type for cursor read
cursor_gettype = function(cursor) {
  varnum = hdfql_cursor_get_datatype(cursor)
  varname = names(hdfql.vartypes)[which(hdfql.vartypes == varnum)]
  hdfql.Rtypes[[varname]]
}


# get object dimensions
getdim = function(path, cursor = NULL) {
  if (is.null(cursor)) {
    cursor = hdfql_cursor()
    on.exit(hdfql_cursor_clear(cursor))
    hdfql_cursor_initialize(cursor)
  }
  hdfql_cursor_use(cursor)
  hdfql_execute(sprintf('SHOW DIMENSION "%s"', path))
  cursor_read(cursor)
}


# read cursor contents
cursor_read = function(cursor) {
  getfun = cursor_getfun(cursor)
  gettype = cursor_gettype(cursor)
  cursor.size = hdfql_cursor_get_count(cursor)
  res = vector(gettype, cursor.size)
  i = 0
  while (hdfql_cursor_next() >= 0L) {
    i = i + 1
    res[i] = getfun(cursor)
  }
  if (length(res) != cursor.size)
    stop("length error")
  res
}


# read a standard table
standard_read = function(path) {
  # get table dimensions
  path.dim = getdim(path)
  # initialize cursor
  cursor = hdfql_cursor()
  on.exit(hdfql_cursor_clear(cursor))
  hdfql_cursor_initialize(cursor)
  hdfql_cursor_use(cursor)
  # pull data
  hdfql_execute(sprintf('SELECT FROM "%s"', path))
  res = cursor_read(cursor)
  # reshape data
  matrix(res, nrow = path.dim[1], ncol = path.dim[2], byrow = TRUE)
}


# read a compound table
compound_read = function(path) {


}
