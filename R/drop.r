#' Drop HDF groups, datasets, and attributes
#'
#' Drop a datset, attribute, or group from 

#' Drop HDF objects.
#'
#' @keywords internal
drop = function(what = c("FILE", "GROUP", "DATASET", "ATTRIBUTE"),
	path) {
	script = sprintf('DROP %s "%s"', what, path)
	res = execute_with_memory(script, stop.on.error = FALSE)
	if (!is.null(res)) {
		error.type = get_key(res, hql_error_types(), TRUE)
		if (error.type != "HDFQL_ERROR_NOT_FOUND") {
			stop(hql$constants$hdfql_error_get_message())
		}
	}
	invisible(NULL)
}

#' @describeIn drop Drop HDF dataset.
#'
#' @param file The HDF file to search.
#' @param dataset The dataset to drop.
#' @export
hql_drop_dataset = function(file, dataset) {
  stop_not_loaded()
  use_file(file)
  on.exit(close_file(file))
	drop("DATASET", dataset)
}

#' @describeIn drop Drop HDF group.
#'
#' @param group The group to drop.
#' @inheritParams hql_drop_dataset
#' @param recursive If `TRUE`, drop all child groups and datasets.
#'
#' @export
hql_drop_group = function(file, group) {
  stop_not_loaded()
  use_file(file)
  on.exit(close_file(file))
  if (!recursive) {
    sub.groups = list("GROUP", path)
    sub.datasets = list("DATASET", path)
    if (length(c(sub.groups, sub.datasets)) > 0L) {
      stop(path, 'contains groups or datasets but ',
      'argument "recursive" is FALSE.')
    }
  }
	drop("GROUP", group)
}

#' @describeIn drop Drop HDF attribute.
#'
#' @param attribute The attribute to drop.
#' @inheritParams hql_drop_dataset
#'
#' @export
hql_drop_attribute = function(file, attribute) {
  stop_not_loaded()
  use_file(file)
  on.exit(close_file(file))
	drop("ATTRIBUTE", attribute)
}
