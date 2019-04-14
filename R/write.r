#' Write HDF Dataset or Attribute
#'
#' Read a dataset or attribute to an HDF file.
#'
#' @param x The dataset or attribute to write.
#' @param file The HDF file to write to.
#' @param path The location within the HDF5 file to write the dataset or attribute(s).
#'
#' @name hql_write
NULL

#' Write HDF Object
#'
#' @keywords internal
write = function(what, x, path, overwrite = FALSE, parallel = FALSE) {
	# input checking
	rtype = typeof(x)
	dtype = gsub("^HDFQL_", "", rtype_to_dtype(rtype))
	if (dtype == "CHAR") {
		dataset.dim = c(dim(x), max(nchar(x)))
	} else {
		dataset.dim = dim(x)
	}
	# drop existing object if required
	if (overwrite) {
		drop_dataset(path)
	}
	# create object
	create(what, path, dtype, dataset.dim, parallel = parallel)
	# write object
	set_data(x, path, what, parallel = parallel)
}

#' @describeIn hql_write Write a dataset to an HDF file.
#' @export
hql_write_dataset = function(x, file, path, attributes = TRUE,
  overwrite = FALSE, parallel = FALSE) {
  stop_not_loaded()
	# create file if it does not exist
	if (!file.exists(file)) {
		create_file(file, parallel = parallel)
	}
	use_file(file)
	on.exit(close_file(file))
	# write dataset
	write("DATASET", x, path, overwrite, parallel)
	# write attributes
	if (attributes) {
		attr.names = setdiff(names(attributes(x)), "dim")
		for (n in attr.names) {
			write("ATTRIBUTE", attr(x, n), file.path(path, n),
			  parallel = parallel)
		}
	} else {
		invisible(NULL)
	}
}

#' @describeIn hql_write Write an attribute to an HDF file.
#' @export
hql_write_attribute = function(x, file, path) {
	stop_not_loaded()
	# create file if it does not exist
	if (!file.exists) {
		create_file(file, parallel = parallel)
	}
	use_file(file)
	on.exit(close_file(file))
	write("ATTRIBUTE", x, path, overwrite, parallel)
}

#' @describeIn hql_write Write multiple attributes to an HDF file.
#' @export
hql_write_all_attributes = function(attributes, file, overwrite = FALSE,
  parallel = FALSE) {
	stop_not_loaded()
	# create file if it does not exist
	if (!file.exists) {
		create_file(file, parallel = parallel)
	}
	use_file(file)
	on.exit(close_file(file))
	for (i in seq_along(attributes)) {
		write("ATTRIBUTE", x[[i]], names(x)[i], overwrite, parallel)
	}
}

#' @describeIn hql_write Write a compound dataset to an HDF file.
#' @export
hql_write_compound_dataset = function(x, file, path) {
	stop_not_loaded()
	# create file if it does not exist
	if (!file.exists) {
		create_file(file, parallel = parallel)
	}
	use_file(file)
	on.exit(close_file(file))
}
