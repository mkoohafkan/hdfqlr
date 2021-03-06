#' List HDF Groups, Datasets or Attributes
#'
#' List groups, datasets or attribute in an HDF file.
#'
#' @name hql_list
NULL

#' List HDF Objects
#'
#' @keywords internal
list_hdf = function(what = c("GROUP", "DATASET", "ATTRIBUTE"), path) {
	script = sprintf('SHOW %s "%s/"', what, path)
	get_cursor_values(script)
}

#' Recursively Walk Group Structure
#' 
#' Recursively walk through HDF groups.
#'
#' @keywords internal
recurse_groups = function(path) {
	groups = list_hdf("GROUP", path)
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
rev_recurse_groups = function(path) {
	base.group = dirname(path)
	if (grepl("^\\.*/*$", base.group)) {
		path
	} else {
		c(rev_recurse_groups(base.group), path)
	}
}


#' @describeIn hql_list List groups.
#'
#' @param path The location of the dataset, attribute, or group 
#'   within the HDF file.
#' @param recursive Recursively list child groups or datasets.
#' @return A vector of paths.
#'
#' @export
hql_list_groups = function(path, recursive = FALSE) {
	if (missing(path)) {
		path = ""
	}
	if (path == "") {
		otype = "GROUP"
	} else {
		otype = gsub("^HDFQL_", "", get_object_type(path))
	}
	if (otype != "GROUP") {
		stop(path, " is a ", otype, ', not a GROUP')
	}
	if (!recursive) {
		out = gsub("^/", "", gsub("//", "/", file.path(path, list_hdf("GROUP", path))))
	} else {
		groups = gsub(paste0("^", path), "", unlist(recurse_groups(path)))
		base.groups = unlist(lapply(groups, rev_recurse_groups))
	  all.groups = sort(unique(base.groups, groups))
		out = gsub("//", "/", file.path(path, all.groups))
  }
  gsub("^/", "", out)
}


#' @describeIn hql_list List datasets.
#'
#' @export
hql_list_datasets = function(path, recursive = FALSE) {
	if (missing(path)) {
		path = ""
	}
	if (!recursive) {
		if (path == "") {
			otype = "GROUP"
		} else {
			otype = gsub("^HDFQL_", "", get_object_type(path))
		}
		if (otype != "GROUP") {
			stop(path, " is a ", otype, ', not a GROUP')
		}
		out = gsub("//", "/", file.path(path, list_hdf("DATASET", path)))
	} else {
		groups = c("", hql_list_groups(path, TRUE))
		out = gsub("//", "/", unlist(lapply(groups, function(x)
			file.path(x, list_hdf(x, what = "DATASET")))))
    }
    gsub("^/", "", out)
}

#' @describeIn hql_list List Attributes
#'
#' @export
hql_list_attributes = function(path) {
	if (missing(path)) {
    path = ""
  } 
  if (path == "") {
    otype = "GROUP"
  } else {
    otype = gsub("^HDFQL_", "", get_object_type(path))
  }
  if (!(otype %in% c("GROUP", "DATASET"))) {
		stop(path, " is a ", otype, ', not a GROUP or DATASET')
	}
	list_hdf("ATTRIBUTE", path)
}
