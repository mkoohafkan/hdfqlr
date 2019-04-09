hdfql_dll_path = NULL

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

#' Check HDFql DLLs are loaded
#'
#' @keywords internal
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
load_hdfql = function(path) {
  if (!check_hdfql_connection()) {
    dllpath = file.path(path, paste0(hdfql_dll_path(),
      .Platform$dynlib.ext))
  }
  dllpath = normalizePath(dllpath, mustWork = TRUE)

  lapply(dllpath, dyn.load)
  hdfql_path <<- dllpath

  hdfql_initialize_status = eval(parse(
    text = '.Call("_hdfql_initialize")'),
    envir = .GlobalEnv)
  if (!is.null(hdfql_initialize_status)) {
    stop(hdfql_initialize_status)
  }
}

#' @rdname load_hdfql
#' @export
unload_hdfql = function() {
  if (check_hdfql_connection()) {
    lapply(hdfql_path, dyn.unload)
  }
  if (check_hdfql_connection()) {
    stop("HDFql DLLs could not be unloaded.")
  }
  invisible(NULL)
}

