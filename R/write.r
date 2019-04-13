#' Write HDF Dataset or Attribute
#'
#' Read a dataset or attribute to an HDF file.
#'
#' @name hql_write
NULL


#' @describeIn hql_write Write a dataset to an HDF file.
#'
#' @param x The dataset or attribute to write.
#' @param file The HDF file to write to.
#' @param path The location within the HDF5 file to write the dataset or attribute(s).
#'
#' @export
hql_write_dataset = function(x, file, path) {
  stop_not_loaded()
  stop("not implemented")
}

#' @describeIn hql_write Write attributes to an HDF file.
#' @export
hql_write_attribute = function(x, file, path) {
	stop_not_loaded()
	stop("not implemented")
}

hql_write_all_attributes = function(x, file, path) {
	stop_not_loaded()
	stop("not implemented")
}
