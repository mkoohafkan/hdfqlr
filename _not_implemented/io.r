#' Execute With File
#'
#' Generic helper for executing HDFql operations using files.
#'
#' @param script The HDFQL operation to execute. 
#'   Do not include `FROM` or `INTO` statements.
#' @param file The binary or text file to use.
#' @param direction Either `"FROM"` or `"INTO"`. 
#' @param binary if `TRUE`, assume the specified file is a binary file.
#'   Otherwise, assume the specified file is a text file.
#' @param separator The separator to use when working with text files.
#'   The HDFql default separator is `","`.
#' @param terminator The terminator to use when working with text files, 
#'   i.e. `"DOS"` or `"UNIX"`.
#' @param stop.on.error If `TRUE`, return an error message if script
#'   fails. If `FALSE`, return the HDFql error value.
#' @return The HDFql error value, or `NULL`.
#' 
#' @keywords internal
execute_with_file = function(script, file,
  direction = c("INTO", "FROM"), binary = FALSE, separator = NULL,
  terminator = NULL, stop.on.error = TRUE) {
  direction = match.arg(toupper(direction), c("INTO", "FROM"))
  if (direction == "FROM") {
    file = normalizePath(file, winslash = "/", mustWork = TRUE)
  } else {
    file = normalizePath(file, winslash = "/", mustWork = FALSE)
    file.create(file)
  }
  if (binary) {
    ftype = "BINARY"
    sep = ""
    terminator = ""
    separator = ""
  } else {
    ftype = "TEXT"
    sep = "SEPARATOR"
    if (is.null(separator)) {
      separator = ","
    }
    if (is.null(terminator)) {
      terminator = ""
    } else {
      terminator = match.arg(terminator, c("DOS", "UNIX"))
    }
    script = paste(script, sprintf("%s %s %s FILE %s %s %s",
      direction, terminator, ftype, file, sep, separator))
  }
  hdfql.result = hql$constants$hdfql_execute(script)
  if (hdfql.result != hql$constants$HDFQL_SUCCESS) {
    if (stop.on.error) {
      stop(hql$constants$hdfql_error_get_message())
    } else {
      return(hdfql.result)
    }
  }
  invisible(NULL)
}


#' Import and Export HDF Datasets and Attributes
#'
#' Transfer data between HDF and text or binary files.
#' 
#' @name hql_io
NULL

#' Export HDF Object to File
#'
#' Generic helper to export an HDF object to a text or binary file.
#'
#' @keywords internal
hql_export = function(what = c("DATASET", "ATTRIBUTE"), path, file,
  binary = FALSE, separator = NULL, terminator = NULL,
  parallel = FALSE) {
  what = match.arg(toupper(what), c("DATASET", "ATTRIBUTE"))
  if (parallel) {
    pre = "PARALLEL"
  } else {
    pre = ""
  }
  script = sprintf('SELECT FROM %s %s "%s"', pre, what, path)
  execute_with_file(script, "INTO", binary = binary,
    separator = separator, terminator = terminator,
    stop.on.error = TRUE)
}

#' Import File to HDF
#'
#' Generic helper to import text or binary file contents into an HDF object.
#'
#' @keywords internal
hql_import = function(what = c("DATASET", "ATTRIBUTE"), path, file,
  binary = FALSE, separator = NULL, terminator = NULL,
  parallel = FALSE) {
  what = match.arg(toupper(what), c("DATASET", "ATTRIBUTE"))
  if (parallel) {
    pre = "PARALLEL"
  } else {
    pre = ""
  }
  script = sprintf('INSERT INTO %s %s "%s"', pre, what, path)
  execute_with_file(script, "FROM", binary = binary,
    separator = separator, terminator = terminator,
    stop.on.error = TRUE)
}


#' @describeIn hql_io Export HDF dataset to a file.
#'
#' @param dataset The HDF dataset to export.
#' @param file The file to export the HDF dataset to.
#' @param binary If `TRUE`, export to a binary file. Otherwise,
#'   export to a text file.
#' @param separator The separator to use when writing values to
#'   a text file.
#' @param terminator The line terminator to use when writing to a
#'   a text file, i.e. `"DOS"` or `"UNIX"`.
#' @inheritParams hql_read_dataset
#'
#' @export
hql_export_dataset = function(dataset, file, binary = FALSE,
  separator = NULL, terminator = NULL, parallel = FALSE) {
  stop_not_loaded()
  hql_export("DATASET", dataset, file, binary, separator, terminator,
    parallel)
}

#' @describeIn hql_io Export HDF attribute to a file.
#'
#' @param attribute The HDF attribute to export.
#'
#' @export
hql_export_attribute = function(path, file, binary = FALSE,
  separator = NULL, terminator = NULL, parallel = FALSE) {
  stop_not_loaded()
  hql_export("ATTRIBUTE", path, file, binary, separator, terminator,
    parallel)
}

#' @describeIn hql_io Import file contents to an HDF dataset.
#'
#' @inheritParams hql_export_dataset
#'
#' @export
hql_import_dataset = function(dataset, file, binary = FALSE,
  separator = NULL, terminator = NULL, parallel = FALSE) {
  stop("not implemented")
  stop_not_loaded()
  hql_import("DATASET", dataset, file, binary, separator, terminator,
    parallel)
}

#' @describeIn hql_io Import file contents to an HDF attribute.
#'
#' @inheritParams hql_export_attribute
#'
#' @export
hql_import_attribute = function(path, file, binary = FALSE,
  separator = NULL, terminator = NULL, parallel = FALSE) {
  stop("not implemented")
  stop_not_loaded()
  hql_import("ATTRIBUTE", path, file, binary, separator, terminator,
    parallel)
}
