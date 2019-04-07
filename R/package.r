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
	hdfql_operating_system = switch(Sys.info()[["sysname"]],
		"Linux" = "Linux",
		"Windows" = "Windows",
		"OSX"
	)
	hdfql_machine = ifelse(grepl("64", Sys.info()[["machine"]]),
		"x64", "i386")
	dllpath <<- system.file(paste0("libs/", hdfql_machine),
		package = pkgname)
	dllname <<- switch(hdfql_operating_system,
		"Windows" = "HDFqlR.dll",
		"Linux" = "libHDFqlR.so",
		"OSX" = "libHDFqlR"
	)
	oldwd = getwd()
	setwd(dllpath)
	on.exit(setwd(oldwd))
	dyn.load(dllname)
	
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
	setwd(dllpath)
	on.exit(setwd(oldwd))
	dyn.unload(dllname)
}

