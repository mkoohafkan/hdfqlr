#' Read Dataset
#'
#' Read a dataset from an HDF5 file.
#'
#' @param file The HDF5 file path.
#' @param path The dataset location within the HDF5 file.
#' @param attributes If `TRUE`, include the dataset attributes.
#' @return A matrix.
#'
#' @export
read_dataset = function(file, path, attributes = FALSE) {
  hdfql_stop_not_loaded()
  use_file(file)
  on.exit(close_file(file))
  otype = get_key(get_type(path), hdfql_keywords(), FALSE)
  res = get_data(path, otype)
  if (attributes) {
    attr.names = get_attr_names(path)
    for (n in attr.names)
      attr(res, n) = get_data(file.path(path, n),
        "ATTRIBUTE")
  }
  res
}

#' Read Attributes
#'
#' Read attributes of a dataset within an HDF5 file.
#'
#' @inheritParams read_dataset
#' @return A named list of attributes.
#'
#' @export
read_attributes = function(file, path) {
  hdfql_stop_not_loaded()
  use_file(file)
  on.exit(close_file(file))
  if (missing(path))
    path = ""
  attr.names = get_attr_names(path)
  res = vector("list", length(attr.names))
  names(res) = attr.names
  for (n in attr.names)
    res[[n]] = get_data(file.path(path, n),
      "ATTRIBUTE")
  res  
}
