#' Write HDF Dataset or Attribute
#'
#' Write a dataset or attribute to an HDF file.
#'
#' @examples
#' if(hql_is_loaded()){
#'   tf = tempfile(fileext = ".h5")
#'   hql_create_file(tf)
#'
#'   x = matrix(rnorm(100), nrow = 20)
#'   hql_write_dataset(x, "dataset0")
#'   hql_write_attribute("normal", "dataset0/dist")
#'
#'   y = month.name
#'   attr(y, "abbreviation") = month.abb
#'   hql_write_dataset(y, "group1/dataset1")
#'
#'   hql_close_file(tf)
#' }
#'
#' @name hql_write
NULL

#' Write HDF Object
#'
#' @keywords internal
write = function(what, x, path, overwrite = FALSE, parallel = FALSE) {
	# input checking
  x = as.array(x)
	rtype = typeof(x)
	dtype = gsub("^HDFQL_", "", rtype_to_dtype(rtype))
	if (dtype == "CHAR") {
		dataset.dim = c(dim(x), max(nchar(x)))
	} else {
		dataset.dim = dim(x)
	}
	# drop existing object if required
	if (overwrite) {
		drop(what, path)
	}
	# create object
	create(what, path, dtype, dataset.dim, parallel = parallel)
	# write object
	set_data(x, path, what, parallel = parallel)
}

#' @describeIn hql_write Write a dataset to an HDF file.
#'
#' @param dataset The dataset to write. The object must be coercible 
#'  to an array.
#' @param path The location within the HDF file to write the dataset or attribute(s).
#' @param include.attributes If `TRUE`, write the dataset attributes. 
#' @param overwrite If `TRUE`, overwrite existing dataset or attribute.
#' @inheritParams hql_read
#'
#' @export
hql_write_dataset = function(dataset, path,
  include.attributes = TRUE, overwrite = FALSE, parallel = FALSE) {
  stop_not_loaded()
	# write dataset
	write("DATASET", dataset, path, overwrite, parallel)
	# write attributes
  if (include.attributes) {
    hql_write_all_attributes(attributes(dataset), path,
      parallel = parallel)
	} else {
		invisible(NULL)
	}
}

#' @describeIn hql_write Write an attribute to an HDF file.
#'
#' @param attribute The attribute to write.
#' @inheritParams hql_write_dataset
#'
#' @export
hql_write_attribute = function(attribute, path,
  overwrite = FALSE, parallel = FALSE) {
	stop_not_loaded()
	if (missing(path)) {
		path = ""
	}
	write("ATTRIBUTE", attribute, path, overwrite, parallel)
}

#' @describeIn hql_write Write multiple attributes to an HDF file.
#'
#' @param attributes A list of attributes to write.
#' @inheritParams hql_write_dataset
#'
#' @export
hql_write_all_attributes = function(attributes,
  path, overwrite = FALSE, parallel = FALSE) {
  stop_not_loaded()
	if (missing(path)) {
		path = ""
  }
  attr.classes = lapply(attributes, typeof)
  attr.dtypes = lapply(attr.classes, rtype_to_dtype,
    stop.on.error = FALSE)
  attr.unwriteable = unlist(lapply(attr.dtypes, is.null),
    use.names = FALSE)
  if (any(attr.unwriteable)) {
    warning('The following attributes could not be written: ',
      paste(sprintf('"%s"', names(attributes)[attr.unwriteable]),
        collapse = ", "))
    attributes = attributes[!attr.unwriteable]
  }
	for (i in seq_along(attributes)) {
		write("ATTRIBUTE", attributes[[i]],
		  file.path(path, names(attributes)[i]),
		  overwrite, parallel)
	}
}

# @describeIn hql_write Write a compound dataset to an HDF file.
# @param compound.dataset The compound dataset to write. The 
#   The object must be coercible to a data.frame, and each column
#   of the dataframe must be coercible to an array.
# @inheritParams hql_write_dataset
# @keywords internal
hql_write_compound_dataset = function(compound.dataset, path,
	overwrite = FALSE, parallel = FALSE) {
	stop_not_loaded()
}
