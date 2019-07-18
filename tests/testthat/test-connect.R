check_hdfql <- function() {
  if (!hql_is_loaded()) {
    skip("HDFql not available")
  }
}

test_that("connection works", {
  check_hdfql()
  expect_true(hql_is_loaded())
  expect_null(hql_unload())
  expect_false(hql_is_loaded())
  expect_null(hql_load())
})
