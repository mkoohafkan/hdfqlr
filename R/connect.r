#' HDFql DLL Paths
#'
#' @keywords internal
hdfql_dll_path = function() {
  if (Sys.info()[["sysname"]] == "Windows") {
    c("lib/HDFql_dll", "wrapper/R/HDFqlR")
  } else { 
    "wrapper/R/libHDFqlR"
  }
}

hdfql_wrapper_path = function() {
  "wrapper/R/HDFql.R"
}

#' Check HDFql DLLs are loaded
#'
#' @export
check_hdfql_connection = function() {
  if (all(basename(hdfql_dll_path()) %in% names(getLoadedDLLs()))) {
    TRUE
  } else {
    FALSE
  }
}


#' Load HDFql DLLs
#'
#' Load the HDFql object.
#'
#' @param path The path to the HDFql installation. 
#' @export
hdfql_load = function(path) {
  if (!check_hdfql_connection()) {
    dllpath = file.path(path, paste0(hdfql_dll_path(),
      .Platform$dynlib.ext))
  }
  # get paths to DLLs and wrapper
  dllpath = normalizePath(dllpath, mustWork = TRUE)
  wrapperpath = normalizePath(file.path(path, hdfql_wrapper_path()),
    mustWork = TRUE)
  # load DLLs
  lapply(dllpath, dyn.load)
  hdfql_path <<- dllpath
  # source wrapper code
#  source(textConnection(tail(readLines(wrapperpath), -26)),
#    local = getNamespace(packageName()))

  hdfql_initialize_status = .Call("_hdfql_initialize",
    PACKAGE = "HDFqlR")
  if (!is.null(hdfql_initialize_status)) {
    stop(hdfql_initialize_status)
  }


}

#' @rdname hdfql_load
#' @export
hdfql_unload = function() {
  if (check_hdfql_connection()) {
    lapply(hdfql_path, dyn.unload)
  }
  if (check_hdfql_connection()) {
    stop("HDFql DLLs could not be unloaded.")
  }
  invisible(NULL)
}

