#' Read HDF Dataset or Attribute
#'
#' Read a dataset or attribute from an HDF file.
#'
#'
#' @examples
#' if(hql_is_loaded()){
#'   tf = tempfile(fileext = ".h5")
#'   x = matrix(rnorm(100), nrow = 20)
#'   hql_write_dataset(x, tf, "dataset0")
#'   hql_write_attribute("normal", tf, "dataset0/dist")
#'  y = month.name
#'  attr(y, "abbreviation") = month.abb
#'  attr(y, "number") = 1:12
#'  hql_write_dataset(y, tf, "group1/dataset1")
#'
#' hql_read_dataset(tf, "dataset0")
#' hql_read_dataset(tf, "group1/dataset1")
#' hql_read_attribute(tf, "group1/dataset1/abbreviation")
#' hql_read_all_attributes(tf, "group1/dataset1")
#' }
#'
#' @name hql_read
NULL

#' @describeIn hql_read Read a dataset from an HDF file.
#'
#' @param file The HDF file to read from.
#' @param path The location of the dataset, attribute, or group within the HDF file.
#' @param include.attributes If `TRUE`, include the dataset attributes.
#' @inheritParams get_data
#' @return A matrix.
#'
#' @export
hql_read_dataset = function(file, path, include.attributes = TRUE,
  parallel = FALSE) {
  stop_not_loaded()
  use_file(file)
  on.exit(close_file(file))
  res = get_data(path, "DATASET", parallel = parallel)
  if (include.attributes) {
    attr.names = get_attr_names(path)
    for (n in attr.names)
      attr(res, n) = get_data(file.path(path, n),
				"ATTRIBUTE", parallel = parallel)
  }
  res
}

#' @describeIn hql_read Read a single attribute from an HDF file.
#'
#' @inheritParams hql_read_dataset
#' @return The attribute value.
#'
#' @export
hql_read_attribute = function(file, path, parallel = FALSE) {
	stop_not_loaded()
	use_file(file)
	on.exit(close_file(file))
	get_data(path, "ATTRIBUTE", parallel = FALSE)
}


#' @describeIn hql_read Read attributes from an HDF file.
#'
#' @inheritParams hql_read_dataset
#' @return A named list of attributes.
#'
#' @export
hql_read_all_attributes = function(file, path, parallel = FALSE) {
  stop_not_loaded()
  use_file(file)
  on.exit(close_file(file))
  if (missing(path))
    path = ""
  attr.names = get_attr_names(path)
  res = vector("list", length(attr.names))
  names(res) = attr.names
  for (n in attr.names)
		res[[n]] = get_data(file.path(path, n), "ATTRIBUTE",
		  parallel = parallel)
  res  
}

#' @describeIn hql_read Read compound dataset from an HDF file.
#'
#' @inheritParams hql_read_dataset
#' @return A data frame.
#'
#' @export
hql_read_compound_dataset = function(file, path, parallel = FALSE) {
	stop_not_loaded()
  stop("not implemented")
}
