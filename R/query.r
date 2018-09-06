#' HDFql query
#'
#' Generic helper for executing HDFql queries.
#'
#' @parameter script The HDFQL query to execute. Do not include `INTO` statements.
query = function(script, retrieve = FALSE) {
  if (!retrieve) {
    if (hdfql_execute(script) < 0L)
      stop(hdfql_error_get_message())
  return(invisible(NULL))
  } else {
    out = construct_output(script)
    if (hdfql_variable_register(out) < 0L)
      stop("error registering variable")
    on.exit(hdfql_variable_unregister(out))
    new.script = sprintf('%s INTO MEMORY %d', script,
      hdfql_variable_get_number(out))
    if (hdfql_execute(new.script) < 0L)
      stop(hdfql_error_get_message())
    return(out)
  }
}

#' HDFql memory constructor
#'
#' Construct an R object for reading HDFql query result into memory.
#'
#' @inheritParams query
#' @return An empty R object of the correct size and type.
construct_output = function(script) {
  if (hdfql_execute(script) < 0L)
    stop(hdfql_error_get_message())
    dtype = hdfql_cursor_get_datatype()
    dcount = hdfql_cursor_get_count()
    rtype = hdfql.Rtypes[[names(hdfql.dtypes)[which(hdfql.dtypes == dtype)]]]
    vector(rtype, dcount)
}


#script = 'CREATE DATASET "base/foo" AS DOUBLE (3,2)'
#script = 'INSERT INTO "base/foo" VALUES (1,2,3,4,5,6)'
#script = 'SELECT FROM "base/foo"'
#script = 'SHOW USE FILE'

