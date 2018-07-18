read_dataset = function(file, path, attributes = FALSE) {
  use_file(file)
  on.exit(close_file(file))
  otype = hdfql.keywords[[get_type(path)]]
  res = get_data(path, otype)
  if (attributes) {
    attr.names = get_attr_names(path)
    for (n in attr.names)
      attr(res, n) = get_data(file.path(path, n),
        "ATTRIBUTE")
  }
  res
}

read_attributes = function(file, path) {
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
