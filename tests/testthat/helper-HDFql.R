check_hdfql = function() {
  skip_on_cran()
  if (isTRUE(as.logical(Sys.getenv("CI", "false")))) {
    hql_load()
  } else if (hql_is_loaded()) {
    return(invisible(TRUE))
  }
  skip("HDFql not available")
}
