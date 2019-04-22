#' Get List Keys or Values
#'
#' Get the value of a list key, or the key of a list value.
#'
#' @param x A key or value.
#' @param l A named list.
#' @param invert If `TRUE`, return the key associated with 
#'  the given value.
#' @return A key or value.
#'
#' @importFrom utils stack
#' @keywords internal
get_key = function(x, l, invert = FALSE) {
	if (!invert) {
		if (x %in% names(l)) {
			l[[x]]
		} else {
		  NULL
		}
	}
	else {
		d = stack(l)
		if (x %in% d$values) {
			as.character(d[d$values == x, "ind"])
		} else {
			NULL
		}
	}
}

#' Format Sequence For HDFql
#'
#' Format an integer sequence for selection with HDFql.
#'
#' @param s An integer sequence.
#' @return A vector of character representations of the integer sequence.
#'
#' @keywords internal
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
