testfile = tempfile(fileext = ".h5")

test_that("file creation works", {
  check_hdfql()
  hql_create_file(testfile)
  expect_true(file.exists(testfile))
})

test_that("file use works", {
  check_hdfql()
  expect_true(hql_use_file(testfile))
})

test_that("group creation works", {
  check_hdfql()
  group1 = "group1"
  group2 = "group2/group2.1"
  hql_create_group(group1)
  hql_create_group(group2)
  expect_null(hql_flush())
  expect_identical(hql_list_groups("group2"), group2)
  expect_identical(hql_list_groups(recursive = TRUE), c(group1, dirname(group2), group2))
  })

test_that("file close works", {
  check_hdfql()
  expect_true(hql_close_file(testfile))
})

unlink(testfile)
