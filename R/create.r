#' Create HDF files, groups, datasets, and attributes
#'
#' @name hql_create
NULL

#' @describeIn hql_create Create HDF file.
#'
#' @param file The target file location.
#' @param truncate If `TRUE`, overwrite existing file.
#' @param parallel If `TRUE`, use parallel capabilities.
#' @param from, to Library bounds.
#'
#' @export
hql_create_file = function(file, truncate = FALSE, parallel = FALSE,
	from = NULL, to = NULL) {
	pre = ""
	if (truncate) {
		pre = paste(pre, "TRUNCATE")
	}
	if (parallel) {
		pre = paste(pre, "PARALLEL")
	}
	if (!is.null(from) && !is.null(to)) {
		post = "LIBRARY BOUNDS"
		if (!is.null(from)) {
			post = sprintf("%s FROM %s", post, from)
		}
		if (!is.null(to)) {
			post = sprintf("%s TO %s", post, to)
		}
	} else {
		post = ""
	}
	script = sprintf('CREATE %s FILE "%s" %s', pre, file, post)
	if (!dir.exists(dirname(file))) {
		dir.create(dirname(file), recursive = TRUE)
	}
	get_value(script)
}

#' @describeIn hql_create Create HDF group.
#'
#' @param file The file to create the group in.
#' @param group The group to create.
#' @param truncate If `TRUE`, overwrite existing groups.
#' @param parallel If `TRUE`, use parallel capabilities.
#' @param from, to Library bounds.
#'
#' @export
hql_create_group = function(file, group, truncate = FALSE,
	object.params = list(), attribute.params = list()) {
	if (truncate) {
		pre = "TRUNCATE"
	} else {
		pre = ""
	}
	object.post = ""
	if (!is.null(object.params$order)) {
		post = sprintf("%s ORDER %s", post, object.params$order)
	}
	if (!is.null(object.params$max.compact) || !is.null(object.params$min.dense)) {
		post = sprintf("%s STORAGE", post)
	}
	if (!is.null(object.params$max.compact)) {
		post = sprintf("%s COMPACT %s", post, object.params$order)
	}
	if (!is.null(object.params$min.dense)) {
		post = sprintf("%s DENSE %s", post, object.params$order)
	}
	if (any(sapply(attribute.params, is.null))) {
	  attr.post = "ATTRIBUTE"
		if (!is.null(attribute.params$order)) {
			attr.post = sprintf("%s ORDER %s", attr.post, attribute.params$order)
		}
		if (!is.null(attribute.params$max.compact) || !is.null(attribute.params$min.dense)) {
			attr.post = sprintf("%s STORAGE", attr.post)
		}
		if (!is.null(attribute.params$max.compact)) {
			attr.post = sprintf("%s COMPACT %s", attr.post, attribute.params$order)
		}
		if (!is.null(attribute.params$min.dense)) {
			attr.post = sprintf("%s DENSE %s", attr.post, attribute.params$order)
		}
	} else {
		attr.post = ""
	}
	script = sprintf('CREATE %s GROUP "%s" %s %s', pre, group, post, attr.post)
  get_value(script)
}

