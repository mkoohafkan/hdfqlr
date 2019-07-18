library(testthat)
library(hdfqlr)


if (hql_is_loaded()) {
  test_check("hdfqlr")
}
