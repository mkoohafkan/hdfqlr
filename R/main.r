read_dataset = function(file, path, attributes = FALSE) {
  use_file(file)
  on.exit(close_file(file))
  otype = hdfql.keywords[[(get_type(path))]]
  res = get_data(path, otype)
  if (attributes) {

  }
  res
}

read_attributes = function() {

}