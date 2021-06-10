#' Access HDF Files
#'
#' Open (use) and close HDF files.
#'
#' @examples
#' if(hql_is_loaded()){
#'   tf = tempfile(fileext = ".h5")
#'   hql_create_file(tf)
#'
#'   hql_use_file(tf)
#'   hql_flush()
#'
#'   hql_close_file(tf)
#' }
#'
#' @name hql_file
NULL

#' @describeIn hql_file Open (use) an HDF file.
#'
#' @param file The HDF file path.
#'
#' @export
hql_use_file = function(file) {
  script = sprintf('USE FILE "%s"', file)
  execute_with_memory(script)
  invisible(TRUE)
}

#' @describeIn hql_file Close an HDF file.
#' 
#' @param all If `TRUE`, close all open HDF files.
#'
#' @export
hql_close_file = function(file, all = FALSE) {
  if (all) {
    script = 'CLOSE ALL FILE'
    file = ""
  } else {
    if (missing(file)) {
      stop("No HDF file specified.")
    }
    script = sprintf('CLOSE FILE "%s"', file)
  }
  execute_with_memory(script)
  invisible(TRUE)
}

#' Flush HDF Files
#'
#' Flush HDF file(s) to write buffered data to the disk.
#'
#' @param global If `TRUE`, a global flush is performed and
#'   and all open HDF files are flushed. If `FALSE`, a local
#'   flush is performed and only the HDF file currently in use
#'   is flushed.
#'
#' @export
hql_flush = function(global = TRUE) {
  if (global) {
    script = "FLUSH GLOBAL"
  }
  else {
    script = "FLUSH LOCAL"
  }
  execute_with_memory(script)
}
