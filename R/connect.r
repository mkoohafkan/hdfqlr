# Environments containing information related to the 
# HDFql library on the user's system.
HDFql.constants = new.env()
HDFql.paths = new.env()

#' @keywords internal
path_from_options = function(startup = FALSE) {
  path = NULL
  if (startup) {
    msgfun = packageStartupMessage
  } else {
    msgfun = message
  }
  if (!is.null(options("hdfqlr.dir")) && nzchar(options("hdfqlr.dir"))) {
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
    assign("install", path, envir = HDFql.paths)
    TRUE
  }
}

#' HDFql Paths
#'
#' Set the partial paths to the HDFql library and wrapper.
#'
#' @keywords internal
set_paths = function() {
  if (Sys.info()[["sysname"]] == "Windows") {
    path = c("lib/HDFql_dll", "wrapper/R/HDFqlR")
  } else { 
    path = "wrapper/R/libHDFqlR"
  }
  assign("dll", path, envir = HDFql.paths)
	assign("wrapper", "wrapper/R/HDFql.R", envir = HDFql.paths)
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
  if (all(basename(HDFql.paths$dll) %in% names(getLoadedDLLs()))) {
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
#' @export
hql_load = function(path) {
  if (hql_is_loaded()) {
    return(invisible(NULL))
  }
  if (missing(path)) {
    if (!path_from_options())
      stop('Argument "path" not specified', call. = FALSE)
  }
  # get paths to DLLs and wrapper
  dllpath = normalizePath(file.path(HDFql.paths$install,
    paste0(HDFql.paths$dll, .Platform$dynlib.ext)), mustWork = TRUE)
  wrapperpath = normalizePath(file.path(HDFql.paths$install,
    HDFql.paths$wrapper), mustWork = TRUE)
  # prepare wrapper code
  constants = tempfile(fileext = ".r")
  initialize = tempfile(fileext = ".r")
  writeLines(tail(readLines(wrapperpath), -38L), constants)
  writeLines(readLines(wrapperpath)[27L:38L], initialize)
  # load DLLs
  lapply(dllpath, dyn.load)
  source(initialize, local = getNamespace(packageName()))
  source(constants, local = HDFql.constants)
  invisible(NULL)
}


#' Unload HDFql Library
#'
#' Unload the HDFql library.
#'
#' @export
hql_unload = function() {
  if (hql_is_loaded()) {
    dllpath = normalizePath(file.path(HDFql.paths$install,
      paste0(HDFql.paths$dll, .Platform$dynlib.ext)), mustWork = TRUE)
    lapply(dllpath, dyn.unload)
    rm(list = ls(envir = HDFql.constants), envir = HDFql.constants)
#    detach("HDFql.constants")
    assign("install", NULL, envir = HDFql.paths)
    if (hql_is_loaded()) {
      stop("HDFql DLLs could not be unloaded.")
    }
  }
  invisible(NULL)
}

#' Attach HDFql Wrapper
#'
#' Attach the constants and functions provided by the 
#' HDFql wrapper to the search path.
#'
#' @details For more information, consult the HDFql reference 
#'   manual ([http://www.hdfql.com/#documentation](http://www.hdfql.com/#documentation)).
#'
#' @export
hql_attach = function() {
  stop_not_loaded()
	if (!("HDFql.constants" %in% search())) {
		attach(HDFql.constants, pos = 2L)
	}
	invisible(NULL)
}

#' @rdname hql_attach
#' @export
hql_detach = function() {
	if ("HDFql.constants" %in% search()) {
		detach(HDFql.constants)
	}
	invisible(NULL)
}
