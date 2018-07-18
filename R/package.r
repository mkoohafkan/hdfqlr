#' HDFql DLLs
#'
#' The HDFql DLLs are part of the Hierarchical Data Format query language (HDFql).
#'
#' @details Copyright (C) 2016-2017.
#' For more information about HDFql, please visit the website http://www.hdfql.com.
#'
#' @name HDFql 
#' @useDynLib HDFql
NULL

.onLoad = function(libname, pkgname){
  # LOAD HDFQL SHARED LIBRARY
  old.wd = getwd()
  setwd(system.file("src", package = pkgname, lib.loc = libname))
  on.exit(setwd(old.wd))
  dyn.load(paste0("HDFql", .Platform$dynlib.ext))
  # INITIALIZE HDFQL SHARED LIBRARY
  if (.Call("_hdfql_initialize") != 0)
  {
    if (.Platform$OS.type == "windows")
    {
      stop("Could not find/load HDFql shared library 'HDFql_dll.dll' or map one of its functions properly!")
    }
    else if (.Platform$OS.type == "unix")
    {
      stop("Could not find/load HDFql shared library 'libHDFql.so' or map one of its functions properly!")
    }
    else
    {
      stop("Could not find/load HDFql shared library 'libHDFql.dylib' or map one of its functions properly!")
    }
  }
}

.onUnload <- function (libpath) {
#  old.wd = getwd()
#  setwd(system.file("src", package = pkgname, lib.loc = libname))
#  on.exit(setwd(old.wd))
  dyn.unload(file.path(libpath, "src", paste0("HDFql", .Platform$dynlib.ext)))
}

