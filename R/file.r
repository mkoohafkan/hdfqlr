#' Access HDF Files
#'
#' Open (use) and close HDF files.
#'
#' @examples
#' if(hql_is_loaded()){
#'   tf = tempfile(fileext = ".h5")
#'   hql_create_file(tf)
#'   hql_use_file(tf)
#'   carsfile = tempfile(fileext = ".csv")
#'   write.table(mtcars, file = carsfile, 
#'     row.names = FALSE, col.names = FALSE)
#'   hql_write_dataset(sapply(mtcars, identity), "mtcars", FALSE) 
#'   carsfile2 = tempfile(fileext = ".csv")
#'   file.create(carsfile2)
#'   hql_export_dataset("mtcars", carsfile2)
#'   identical(read.csv(carsfile), read.csv(carsfile2))
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
#' @inheritParams hql_use_file
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