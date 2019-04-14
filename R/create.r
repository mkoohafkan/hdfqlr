#' Create HDF files, groups, datasets, and attributes
#'
#' @name hql_create
NULL

#' @describeIn hql_create Create HDF file.
#'
#' @param file The target file location.
#' @param overwrite If `TRUE`, overwrite existing file.
#' @param parallel If `TRUE`, use parallel capabilities.
#'
#' @export
hql_create_file = function(file, overwrite = FALSE, parallel = FALSE) {
	if (!dir.exists(dirname(file))) {
		dir.create(dirname(file), recursive = TRUE)
	}
	create("FILE", file, overwrite = overwrite, parallel = parallel)
}

#' @describeIn hql_create Create HDF group.
#'
#' @param file The file to create the group in.
#' @param group The group to create.
#' @param overwrite If `TRUE`, overwrite existing groups.
#' @inheritParams hql_create_file
#'
#' @export
hql_create_group = function(file, group, overwrite = FALSE) {
	create("GROUP", file, group, overwrite = overwrite,
	  parallel = parallel)  
}

#' @describeIn hql_create Create HDF dataset.
#'
#' @param file The file to create the dataset in.
#' @param dataset The dataset to create.
#' @param data.type The HDF data type of the dataset.
#' @param size The size (dimensions) of the dataset.
#' @inheritParams hql_create_file
#'
#' @export
hql_create_dataset = function(file, dataset, data.type, size = NULL,
	overwrite = FALSE, parallel = FALSE) {
	create("DATASET", file, dataset, data.type, size, overwrite, parallel)
}

#' @describeIn hql_create Create HDF attribute.
#'
#' @param file The file to create the attribute in.
#' @param attribute The attribute to create.
#' @param data.type The HDF data type of the attribute.
#' @param size The size (dimensions) of the attribute.
#' @inheritParams hql_create_file
#'
#' @export
hql_create_attribute = function(file, attribute, data.type, size = NULL,
	overwrite = FALSE, parallel = FALSE) {
	create("ATTRIBUTE", file, attribute, data.type, size, overwrite, parallel)
}

#' Create HDF Object
#'
#' Generic helper for creating HDF objects.
#'
#' @inheritParams hql_create_dataset
#'
#' @keywords internal
create = function(what = c("FILE", "GROUP", "DATASET", "ATTRIBUTE"),
	file, path, type, size, overwrite = FALSE, parallel = FALSE) {
	what = match.arg(toupper(what), c("FILE", "GROUP", "DATASET",
		"ATTRIBUTE"))
	pre = ""
	if (overwrite) {
		pre = paste(pre, "TRUNCATE")
	}
	if (parallel && what != "GROUP") {
		pre = paste(pre, "PARALLEL")
	}
	post = ""
	if (what %in% c("DATASET", "ATTRIBUTE")) {
		if (!is.null(size)) {
			dsize = sprintf("(%s)", paste(size, collapse = ", "))
		} else {
			dsize = ""
		}
		if (!(type %in% gsub("^HDFQL_", "", names(hql_data_types())))) {
			stop('Object type "', type, '" not recognized')
		}
		post = sprintf("AS %s %s", type, dsize)
	}
	script = sprintf('CREATE %s %s "%s" %s', pre, what, path, post)
	execute_with_memory(script)
}
