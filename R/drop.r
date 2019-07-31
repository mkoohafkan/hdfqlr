#' Drop HDF groups, datasets, and attributes
#'
#' Drop a datset, attribute, or group from an HDF file.
#'
#' @examples
#' if(hql_is_loaded()){
#'   tf = tempfile(fileext = ".h5")
#'   hql_create_file(tf)
#'
#'   hql_use_file(tf)
#'   x = rnorm(10)
#'   attr(x, "myattribute") = "some information"
#'   hql_write_dataset(x, tf, "mygroup/mydataset")
#'
#'   hql_drop_attribute(tf, "mygroup/mydataset/myattribute")
#'   hql_drop_dataset(tf, "mygroup/mydataset")
#'   hql_drop_group(tf, "mygroup")
#'   
#'   hql_close_file(tf)
#' }
#'
#' @name hql_drop
NULL

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
      stop(hql$wrapper$hdfql_error_get_message())
    }
  }
  invisible(NULL)
}

#' @describeIn drop Drop HDF dataset.
#'
#' @param dataset The dataset to drop.
#'
#' @export
hql_drop_dataset = function(dataset) {
  stop_not_loaded()
  drop("DATASET", dataset)
}

#' @describeIn drop Drop HDF group.
#'
#' @param group The group to drop.
#' @inheritParams hql_drop_dataset
#' @param recursive If `TRUE`, drop all child groups and datasets.
#'
#' @export
hql_drop_group = function(group, recursive = FALSE) {
  stop_not_loaded()
  if (!recursive) {
    sub.groups = list("GROUP", group)
    sub.datasets = list("DATASET", group)
    if (length(c(sub.groups, sub.datasets)) > 0L) {
      stop(group, 'contains groups or datasets but ',
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
hql_drop_attribute = function(attribute) {
  stop_not_loaded()
  drop("ATTRIBUTE", attribute)
}


#' @describeIn drop Drop all attributes from an HDF dataset or group.
#'
#' @param path The HDF dataset or group.
#' @inheritParams hql_drop_dataset
#'
#' @export
hql_drop_all_attributes = function(path) {
  stop_not_loaded()
  attr.names = hql_list_attributes(path)
  for (n in attr.names) {
    drop("ATTRIBUTE", file.path(path, n))
  }
}
