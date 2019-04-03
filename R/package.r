#' HDFql DLLs
#'
#' The HDFql DLLs are part of the Hierarchical Data Format query language (HDFql).
#'
#' @details Copyright (C) 2016-2017.
#' For more information about HDFql, please visit the website http://www.hdfql.com.
#'
#' @name HDFql
#' @useDynLib HDFqlR
NULL



.onLoad = function(libname, pkgname) {
  oldwd = getwd()
  setwd(system.file("src", package = packageName()))
  on.exit(setwd(oldwd))

  #===========================================================
  # LOAD HDFQL R WRAPPER SHARED LIBRARY
  #===========================================================
  hdfql_operating_system = Sys.info()[["sysname"]]
  if (hdfql_operating_system == "Windows") {
    dyn.load("HDFqlR.dll")
  } else if (hdfql_operating_system == "Linux") {
    dyn.load("libHDFqlR.so")
  } else # macOS
    {
    dyn.load("libHDFqlR.dylib")
  }
}

.onAttach = function(libname, pkgname) {
  #===========================================================
  # INITIALIZE HDFQL R WRAPPER SHARED LIBRARY
  #===========================================================
  hdfql_initialize_status = .Call("_hdfql_initialize")
  if (!is.null(hdfql_initialize_status)) {
    stop(hdfql_initialize_status)
  }


}
.onUnload <- function (libpath) {
  oldwd = getwd()
  setwd(system.file("src", package = packageName()))
  on.exit(setwd(oldwd))
  if (hdfql_operating_system == "Windows") {
    dyn.unload("HDFqlR.dll")
  } else if (hdfql_operating_system == "Linux") {
    dyn.unload("libHDFqlR.so")
  } else # macOS
    {
    dyn.unload("libHDFqlR.dylib")
  }
}

