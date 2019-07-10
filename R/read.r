#' Read HDF Dataset or Attribute
#'
#' Read a dataset or attribute from an HDF file into memory.
#'
#' @examples
#' if(hql_is_loaded()){
#'   tf = tempfile(fileext = ".h5")
#'   hql_create_file(tf)
#'   hql_use_file(tf)
#'   x = matrix(rnorm(100), nrow = 20)
#'   hql_write_dataset(x, "dataset0")
#'   hql_write_attribute("normal", "dataset0/dist")
#'  y = month.name
#'  attr(y, "abbreviation") = month.abb
#'  attr(y, "number") = 1:12
#'  hql_write_dataset(y, "group1/dataset1")
#'
#' hql_read_dataset("dataset0")
#' hql_read_dataset("group1/dataset1")
#' hql_read_attribute("group1/dataset1/abbreviation")
#' hql_read_all_attributes("group1/dataset1")
#'
#' hql_close_file(tf)
#' }
#'
#' @name hql_read
NULL

#' Read HDF Object into Memory
#'
#' Generic helper for reading HDF objects into memory.
#'
#' @keywords internal
hql_read = function(what = c("DATASET", "ATTRIBUTE"), path,
  parallel = FALSE) {
  what = match.arg(toupper(what), c("DATASET", "ATTRIBUTE"))
  get_data(path, what, transpose = TRUE, parallel = parallel)
}

#' @describeIn hql_read Read a dataset from an HDF file.
#'
#' @param path The location of the dataset, attribute, or group within the HDF file.
#' @param include.attributes If `TRUE`, include the dataset attributes.
#' @inheritParams get_data
#' @return A matrix.
#'
#' @export
hql_read_dataset = function(path, include.attributes = TRUE,
  parallel = FALSE) {
  stop_not_loaded()
  res = hql_read("DATASET", path, parallel)
  if (include.attributes) {
    attr.names = get_attr_names(path)
    for (n in attr.names)
      attr(res, n) = hql_read("ATTRIBUTE", file.path(path, n),
				parallel)
  }
  res
}

#' @describeIn hql_read Read a single attribute from an HDF file.
#'
#' @inheritParams hql_read_dataset
#' @return The attribute value.
#'
#' @export
hql_read_attribute = function(path, parallel = FALSE) {
	stop_not_loaded()
	hql_read("ATTRIBUTE", path, parallel)
}


#' @describeIn hql_read Read attributes from an HDF file.
#'
#' @inheritParams hql_read_dataset
#' @return A named list of attributes.
#'
#' @export
hql_read_all_attributes = function(path, parallel = FALSE) {
  stop_not_loaded()
  if (missing(path))
    path = ""
  attr.names = get_attr_names(path)
  res = vector("list", length(attr.names))
  names(res) = attr.names
  for (n in attr.names)
    res[[n]] = hql_read("ATTRIBUTE", file.path(path, n),
      parallel = parallel)
  res  
}

#' @describeIn hql_read Read compound dataset from an HDF file.
#'
#' @inheritParams hql_read_dataset
#' @return A data frame.
#'
#' @export
hql_read_compound_dataset = function(path, parallel = FALSE) {
	stop("not implemented")
	stop_not_loaded()
}
