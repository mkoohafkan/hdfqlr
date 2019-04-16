#' List HDF Groups, Datasets or Attributes
#'
#' List groups, datasets or attribute in an HDF file.
#'
#' @name hql_list
NULL

#' List HDF Objects
#'
#' @keywords internal
list = function(what = c("GROUP", "DATASET", "ATTRIBUTE"), path) {
	if (missing(path)) {
		path = ""
	}
	script = sprintf('SHOW %s "%s/"', what, path)
	get_cursor_values(script)
}

#' Recursively Walk Group Structure
#' 
#' Recursively walk through HDF groups.
#'
#' @keywords internal
recurse_groups = function(path) {
	groups = list("GROUP", path)
	names(groups) = groups
	if (length(groups) > 0L) {
		lapply(file.path(path, groups), recurse_groups)
	}
	else {
		path
	}
}

#' @rdname recurse_groups
#'
#' @keywords internal
rev_recurse_groups = function(file, path) {
	base.group = dirname(path)
	if (grepl("^\\.*/*$", base.group)) {
		path
	} else {
		c(rev_recurse_groups(base.group), path)
	}
}


#' @describeIn hql_list List groups.
#'
#' @param file The HDF5 file path.
#' @param path The location of the dataset, attribute, or group 
#'   within the HDF5 file.
#' @param recursive Recursively list child groups or datasets.
#' @return A vector of paths.
#'
#' @export
hql_list_groups = function(file, path, recursive = FALSE) {
	use_file(file)
	on.exit(close_file(file))
	if (!recursive) {
		list("GROUP", path)
	} else {
		groups = unlist(recurse_groups(path))
		base.groups = unlist(lapply(groups, rev_recurse_groups))
		sort(unique(base.groups, groups))
	}
}


#' @describeIn hql_list List datasets.
#'
#' @inheritParams hql_list_groups
#'
#' @export
hql_list_datasets = function(file, path, recursive = TRUE) {
	use_file(file)
	on.exit(close_file(file))
	if (!recursive) {
		list("DATASET", path)
	} else {
		groups = list_groups(path, TRUE)
		unlist(lapply(groups, function(x)
			file.path(x, list(x, what = "DATASET"))))
		}
}

#' @describeIn hql_list List Attributes
#'
#' @inheritParams hql_list_groups
#'
#' @export
hql_list_attributes = function(file, path) {
	use_file(file)
	on.exit(close_file(file))
	list("ATTRIBUTE", path)
}
