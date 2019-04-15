#' Drop HDF groups, datasets, and attributes
#'
#' Generic helper for dropping HDF objects.
#'
#' @param what The type of object to drop.
#' @param path The target location of the object.
#'
#' @keywords internal
drop = function(what = c("FILE", "GROUP", "DATASET", "ATTRIBUTE"),
	path) {
	script = sprintf('DROP %s "%s"', what, path)
	res = execute_with_memory(script, stop.on.error = FALSE)
	if (!is.null(res)) {
		error.type = get_key(res, hql_error_types(), TRUE)
		if (error.type != "HDFQL_ERROR_NOT_FOUND") {
			stop(HDFql$constants$hdfql_error_get_message())
		}
	}
	invisible(NULL)
}

#' @describeIn drop Drop HDF dataset.
#'
#' @param dataset The dataset to drop.
#' @inheritParams drop
#'
#' @keywords internal
drop_dataset = function(dataset) {
	drop("DATASET", dataset)
}

#' @describeIn drop Drop HDF dataset.
#'
#' @param group The group to drop.
#' @inheritParams drop
#'
#' @keywords internal
drop_group = function(group) {
	drop("GROUP", group)
}

#' @describeIn drop Drop HDF attribute.
#'
#' @param attribute The attribute to drop.
#' @inheritParams drop
#'
#' @keywords internal
drop_attribute = function(attribute) {
	drop("ATTRIBUTE", attribute)
}
