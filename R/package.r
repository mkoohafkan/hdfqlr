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
  library.dynam("HDFqlR", pkgname, libname)
	
	#===========================================================
	# INITIALIZE HDFQL R WRAPPER SHARED LIBRARY
	#===========================================================
	hdfql_initialize_status = .Call("_hdfql_initialize")
	if (!is.null(hdfql_initialize_status)) {
		stop(hdfql_initialize_status)
	}
}


.onUnload <- function (libpath) {
	library.dynam.unload("HDFqlR", libpath)
}

