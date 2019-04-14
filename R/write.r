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

#' @describeIn hql_write Write a compound dataset to an HDF file.
#' @export
hql_write_compound_dataset = function(x, file, path) {
	stop_not_loaded()
	stop("not implemented")
}

#' Set Data
#'
#' Set data in HDF file.
#'
#' @inheritParams get_data
#'
#' @keywords internal
set_data = function(x, path, otype, transpose = TRUE,
	parallel = FALSE) {
	if (missing(otype))
		otype = gsub("^HDFQL_", "", get_object_type(path))
	dtype = get_data_type(path)
	rtype = typeof(x)
	if (get_key(dtype, hql_Rtypes()) != rtype) {
		stop('Input data is type "', rtype,
			'" but target location is type "',
			gsub("^HDFQL_", "", dtype), '"')
	}
	if (rtype == "character") {
		return(set_char_data(x, path, otype, parallel))
	}
	if (parallel) {
		pre = "PARALLEL"
	} else {
		pre = ""
	}
	script = sprintf('INSERT INTO %s %s "%s" VALUES', pre, otype, path)
	if (transpose) {
		execute_with_memory(script, aperm(x), "FROM")
	} else {
		execute_with_memory(script, x, "FROM")
	}
}



set_char_data = function(x, path, otype, parallel = FALSE) {
	if (parallel) {
		pre = "PARALLEL"
	} else {
		pre = ""
	}
	max.string.size = max(nchar(x))
	x = format(x, with = max.string.size)
	xint = apply(sapply(x, charToRaw, USE.NAMES = FALSE),
	  c(1, 2), as.integer)
	script = sprintf('INSERT INTO %s %s "%s" VALUES', pre, otype, path)
	execute_with_memory(script, xint, "FROM")
}
