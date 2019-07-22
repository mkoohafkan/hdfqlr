.onLoad = function(libname, pkgname) {
  set_paths()
}

.onAttach = function(libname, pkgname) {
  if (path_from_options(TRUE)) {
		tryCatch(hql_load(hql.paths$install),
			error = function(e)
			  warning('Could not automatically connect to HDFql library:\n  ',
        paste(file.path(hql.paths$install, hql.paths$dll), collapse = "\n  "),
        "\n", e, call. = FALSE))
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
