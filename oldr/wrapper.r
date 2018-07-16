read_table = function(path) {
  # load file 
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

