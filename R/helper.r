#' Format Sequence For HDFql
#'
#' Format an integer sequence for selection with HDFql.
#'
#' @param s An integer sequence.
#' @return A vector of character representations of the integer sequence.
#'
as_hdfql_sequence = function(s) {
  s = as.integer(s)
  m = c(0, diff(s))
  b = rle(m)
  b$values[b$lengths == 1L & b$values != 1] = 0
  l = cumsum(!inverse.rle(b))
  d = function(x) {
    paste0(formatC(range(x[, 1]), format = "d"),
      collapse = paste0(":", formatC(unique(x[-1,-1]), format = "d"),":"))
  }
  f = c(by(cbind(s, m), l, d))
  sub("::.*", "", sub(":1:", ":", f))

}   
