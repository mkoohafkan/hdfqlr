#' Create HDF Object
#'
#' Generic helper for creating HDF objects.
#'
#' @param what The type of object to create.
#' @param path The target location of the object.
#' @param data.type The HDF data type of the dataset or attribute.
#' @param size The size (dimensions) of the dataset or attribute. 
#'   For `CHAR` datasets or attributes, the last element of `size` 
#'   is the string length.
#' @param overwrite If `TRUE`, overwrite existing file, group, 
#'   attribute, or dataset.
#' @param parallel If `TRUE`, use parallel capabilities.
#'
#' @keywords internal
create = function(what = c("FILE", "GROUP", "DATASET", "ATTRIBUTE"),
	path, data.type, size, overwrite = FALSE, parallel = FALSE) {
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
		if (!(data.type %in% gsub("^HDFQL_", "", names(hql_data_types())))) {
			stop('Object data type "', data.type, '" not recognized')
		}
		post = sprintf("AS %s %s", data.type, dsize)
	}
	script = sprintf('CREATE %s %s "%s" %s', pre, what, path, post)
	execute_with_memory(script)
}

#' @describeIn create Create HDF file.
#'
#' @param file The HDF file to create.
#' @inheritParams create
#'
#' @keywords internal
create_file = function(file, overwrite = FALSE, parallel = FALSE) {
	if (!dir.exists(dirname(file))) {
		dir.create(dirname(file), recursive = TRUE)
	}
	create("FILE", file, overwrite = overwrite, parallel = parallel)
}

#' @describeIn create Create HDF group.
#'
#' @param group The group to create.
#' @inheritParams create
#'
#' @keywords internal
create_group = function(group, overwrite = FALSE) {
	create("GROUP", group, overwrite = overwrite)  
}

#' @describeIn create Create HDF dataset.
#'
#' @param dataset The dataset to create.
#' @inheritParams create
#'
#' @keywords internal
create_dataset = function(dataset, data.type, size = NULL,
	overwrite = FALSE, parallel = FALSE) {
	create("DATASET", dataset, data.type, size, overwrite, parallel)
}

#' @describeIn create Create HDF attribute.
#'
#' @param attribute The attribute to create.
#' @inheritParams create
#'
#' @keywords internal
create_attribute = function(attribute, data.type, size = NULL,
	overwrite = FALSE, parallel = FALSE) {
	create("ATTRIBUTE", attribute, data.type, size, overwrite, parallel)
}
