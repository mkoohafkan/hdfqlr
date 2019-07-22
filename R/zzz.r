.onLoad = function(libname, pkgname) {
  set_paths()
}

.onAttach = function(libname, pkgname) {
  if (path_from_options(TRUE)) {
		hql_load(hql.paths$install)
  } else {
    packageStartupMessage('Connect to HDFql R drivers by calling ',
      "\n\n\t", 'hql_load("path/to/HDFql-x.x.x")',
      "\n\n",
      "To download HDFql, visit http://www.hdfql.com"
    )
  }
}

.onUnload = function(libpath) {
  hql_unload()
}

.onDetach = function(libpath) {
  hql_unload()
}
