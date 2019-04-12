hdfql_path = NULL

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


#' HDFql Library Status
#'
#' Check if the HDFql library loaded.
#'
#' @return Logical `TRUE` if DLLs are found, `FALSE` otherwise.
#'
#' @export
hdfql_is_loaded = function() {
  if (all(basename(hdfql_dll_path()) %in% names(getLoadedDLLs()))) {
    TRUE
  } else {
    FALSE
  }
}

#' HDFql Load Requirement
#'
#' Return an error if the HDFql library is not loaded.
#'
#' @keywords internal
hdfql_stop_not_loaded = function() {
  if (!hdfql_is_loaded())
    stop("HDFql is not loaded.")
  invisible(NULL)
}

#' Load HDFql DLLs
#'
#' Load the HDFql library.
#'
#' @param path The path to the HDFql installation. 
#' 
#' @export
hdfql_load = function(path) {
  if (!hdfql_is_loaded()) {
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
  source(textConnection(tail(readLines(wrapperpath), -26)),
    local = getNamespace(packageName()))
  invisible(NULL)
}


#' Unload HDFql Library
#'
#' Unload the HDFql library.
#'
#' @export
hdfql_unload = function() {
  if (hdfql_is_loaded()) {
    lapply(hdfql_path, dyn.unload)
  }
  if (hdfql_is_loaded()) {
    stop("HDFql DLLs could not be unloaded.")
  }
  invisible(NULL)
}

