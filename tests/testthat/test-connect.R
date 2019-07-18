test_that("connection works", {
  expect_true(hql_is_loaded())
  expect_null(hql_unload())
  expect_false(hql_is_loaded())
  expect_null(hql_load())
})
