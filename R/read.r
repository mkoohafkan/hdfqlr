#' Read HDF Dataset or Attribute
#'
#' Read a dataset or attribute from an HDF file.
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
