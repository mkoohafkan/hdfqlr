.onLoad = function(libname, pkgname) {
  if (!is.null(options("hdfqlr.hdfqldir"))) {
    packageStartupMessage('Using existing HDFql directory ',
      'from option "hdfqlr.dir".')
    hdfql_load(options("hdfqlr.dir"))
  } else if (nchar(Sys.getenv("HDFQL_DIR")) > 0L) {
    set_key(Sys.getenv("HDFQLR_DIR"))
    packageStartupMessage("Using existing HDFql directory from ",
      '"HDFQL_DIR" environment variable.')
  }  else {
    packageStartupMessage('Connect to HDFql R drivers by calling ',
      "\n\n\t", 'hdfql_load("path/to/HDFql-x.x.x")',
      "\n\n",
      "To download HDFql, visit http://www.hdfql.com"
    )
  }
}


.onUnload <- function(libpath) {
  hdfql_unload()
}

