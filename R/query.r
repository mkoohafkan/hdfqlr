#' HDFql Operation
#'
#' Generic helper for executing HDFql operations.
#'
#' @param script The HDFQL operation to execute. 
#'   Do not include `INTO` statements.
#' @param retrieve If `TRUE`, read the operation output
#'   into R.
#' @export
hdfql_operation = function(script, retrieve = FALSE) {
  hdfql_stop_not_connected()
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
#' @inheritParams hdfql_operation
#' @return An empty R object of the correct size and type.
#'
#' @keywords internal
construct_output = function(script) {
  hdfql_stop_not_connected()
  if (hdfql_execute(script) < 0L)
    stop(hdfql_error_get_message())
  dtype = get_key(hdfql_cursor_get_datatype(), hdfql_dtypes, TRUE)
  dcount = hdfql_cursor_get_count()
  rtype = htype_to_rtype(dtype)
  vector(rtype, dcount)
}


#script = 'CREATE DATASET "base/foo" AS DOUBLE (3,2)'
#script = 'INSERT INTO "base/foo" VALUES (1,2,3,4,5,6)'
#script = 'SELECT FROM "base/foo"'
#script = 'SHOW USE FILE'

