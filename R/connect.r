#' HDFql Library Paths
#'
#' Environment containing information related to the 
#' HDFql library on the user's system.
#'
#' @keywords internal
hql.paths = new.env()

#' HDFql Wrapper Constants and Functions
#'
#' Access the constants and functions provided by the 
#' HDFql wrapper. The wrapper contents are stored in an
#' environment when the HDFql library is loaded and used 
#' internally by hdfqlr to perform operations. 
#'
#' @details This environment is exported so that users
#'   can directly use the HDFql wrapper functions. 
#'   The intended method of use is to [attach()] the environment
#'   to the search path. For more information on what is provided
#'   by the wrapper, consult the 
#' [HDFql reference manual](https://www.hdfql.com/#documentation).
#'
#' @examples
#'\dontrun{
#'   attach(hql$wrapper)
#' }
#'
#' @export
hql = new.env()


#' HDFql Default Path 
#'
#' Retrieve the HDFql installation directory from existing options.
#' This function is used to automatically connect to HDFql without
#' needing to specify the installation path.
#'
#' @param startup If `TRUE`, indicates the paths are being 
#'   detected as part of package startup.
#'
#' @details The function first looks for the R option `hdfqlr.dir`, 
#'  and second looks for the environment variable `HDFQL_DIR`.
#'
#' @keywords internal
path_from_options = function(startup = FALSE) {
  path = NULL
  if (startup) {
    msgfun = packageStartupMessage
  } else {
    msgfun = message
  }
  if (!is.null(options()[["hdfqlr.dir"]]) && nzchar(options()[["hdfqlr.dir"]])) {
    path = options("hdfqlr.dir")[[1]]
    msgfun('Using existing HDFql directory ',
      'from option "hdfqlr.dir".')
  } else if (nzchar(Sys.getenv("HDFQL_DIR"))) {
    path = Sys.getenv("HDFQL_DIR")
    msgfun("Using existing HDFql directory from ",
      '"HDFQL_DIR" environment variable.')
  } 
  if (is.null(path)) {
    FALSE
  } else {
    assign("install", path, envir = hql.paths)
    TRUE
  }
}

#' HDFql Paths
#'
#' Set the partial paths to the HDFql library and wrapper.
#'
#' @keywords internal
set_paths = function() {
  hdfql_operating_system = Sys.info()["sysname"]
  if (hdfql_operating_system == "Windows") {
    lib.names = c(
      "lib/HDFql_dll.dll",
      "wrapper/R/HDFqlR.dll"
    )
    hdfql_shared_library = "HDFqlR"
  } else if (hdfql_operating_system == "Linux") {
    lib.names = c(
      "lib/libHDFql.so",
      "wrapper/R/libHDFqlR.so"
    )
    hdfql_shared_library = "libHDFqlR"
  } else { # macOS
    lib.names = c(
      "lib/libHDFql.dylib",
      "wrapper/R/libHDFqlR.dylib"
    )
    hdfql_shared_library = "libHDFqlR.dylib"
  }
  assign("dll", lib.names, envir = hql.paths)
  assign("sharedlib", hdfql_shared_library, envir = hql.paths)
	assign("wrapper", "wrapper/R/HDFql.R", envir = hql.paths)
	invisible(NULL)
}

#' HDFql Library Status
#'
#' Check if the HDFql library loaded.
#'
#' @return Logical `TRUE` if DLLs are found, `FALSE` otherwise.
#'
#' @export
hql_is_loaded = function() {
  if (all(gsub("(.*?)\\..*$", "\\1", basename(hql.paths$dll)) %in% names(getLoadedDLLs()))) {
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
stop_not_loaded = function() {
  if (!hql_is_loaded())
    stop("HDFql is not loaded.")
  invisible(NULL)
}

#' Load HDFql DLLs
#'
#' Load the HDFql library.
#'
#' @param path The path to the HDFql installation. 
#' 
#' @importFrom utils packageName tail
#' @importFrom methods setRefClass cacheMetaData new
#' @export
hql_load = function(path) {
  if (hql_is_loaded()) {
    return(invisible(NULL))
  }
  if (!missing(path)) {
    assign("install", path, envir = hql.paths)
  } else {
    if (is.null(hql.paths$install)) {
      if (!path_from_options()) {
        stop('Argument "path" not specified.', call. = FALSE)
      }
    }
  }
  # get paths to DLLs and wrapper
  dllpath = normalizePath(file.path(hql.paths$install,
    hql.paths$dll), mustWork = TRUE)
#  message("Connecting to:\n  ", paste(dllpath, collapse = "\n  "))
#  message("  Shared library name: ", hql.paths$sharedlib)
  wrapperpath = normalizePath(file.path(hql.paths$install,
    hql.paths$wrapper), mustWork = TRUE)
  # prepare wrapper code
  wrapper.file = tempfile(fileext = ".r")
  wrapper.lines = readLines(wrapperpath)
  wrapper.lines = gsub("setRefClass", "methods::setRefClass",
    wrapper.lines)
  wrapper.lines = gsub("cacheMetaData", "methods::cacheMetaData",
    wrapper.lines)
  writeLines(wrapper.lines[-grep("dyn.load", wrapper.lines)], wrapper.file)
  # load DLLs
  for (dll in dllpath) {
    dyn.load(dll, local = FALSE, now = TRUE)
    if (!dll %in% sapply(getLoadedDLLs(), function(x) normalizePath(x[["path"]], mustWork = FALSE))) {
      stop("Error loading HDFql shared library object ", dll)
    } 
  }
  # load wrapper
  wrapper = new.env(parent = globalenv())
#  assign("hdfql_shared_library", hql.paths$sharedlib, envir = wrapper)
  tryCatch(
    sys.source(wrapper.file, envir = wrapper, toplevel.env = packageName()),
#    eval(parse(wrapper.file), envir = wrapper),
    error = function(e) {
      stop("Failed to execute HDFql R wrapper.\n Additional Information:\n",
       paste(e), call. = FALSE)
    }
  )
  assign("wrapper", wrapper, envir = hql)
  invisible(NULL)
}


#' @describeIn hql_load Unload HDFql Library.
#'
#' @export
hql_unload = function() {
	if (hql_is_loaded()) {
		dllpath = normalizePath(file.path(hql.paths$install,
			hql.paths$dll), mustWork = TRUE)
    for (dll in dllpath) {
      dyn.unload(dll)
      if (dll %in% sapply(getLoadedDLLs(), function(x) normalizePath(x[["path"]], mustWork = FALSE))) {
        stop("Error unloading HDFql shared library object ", dll)
      }
    }
		rm(list = "wrapper", envir = hql)
	}
  invisible(NULL)
}
