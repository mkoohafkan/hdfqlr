testfile = tempfile(fileext = ".h5")

test_that("wrapper works", {
  expect_type(attach(hql$wrapper), "environment")
  expect_equal(hdfql_execute(sprintf('CREATE FILE "%s"', testfile)), 0)
  expect_equal(hdfql_execute(sprintf('USE FILE "%s"', testfile)), 0)

  expect_equal(hdfql_execute('SHOW USE FILE '), 0)
  expect_equal(hdfql_cursor_first(), 0)
  expect_equal(hdfql_cursor_get_char(), testfile)

  expect_equal(hdfql_execute("CREATE ATTRIBUTE example_attribute AS FLOAT VALUES(12.4)"), 0)
  expect_equal(hdfql_execute("SELECT FROM example_attribute"), 0)
  expect_equal(hdfql_cursor_first(), 0)
  expect_equal(hdfql_cursor_get_float(), 12.4, tolerance = 1e-5)

  expect_equal(hdfql_execute("CREATE DATASET example_dataset AS INT(3, 2)"), 0)
  values <- array(dim = c(3, 2))
  for (x in 1:2) {
    for (y in 1:3) {
      values[y, x] <- as.integer(x * 3 + y - 3)
    }
  }
  expect_equal(hdfql_variable_register(values), 0)
  expect_equal(hdfql_execute(paste("INSERT INTO example_dataset VALUES FROM MEMORY", hdfql_variable_get_number(values))), 0)
  expect_equal(hdfql_variable_unregister(values), 0)
  new.values = values
  for (x in 1:2) {
    for (y in 1:3) {
      new.values[y, x] <- as.integer(0)
    }
  }
  expect_equal(hdfql_variable_register(new.values), 0)
  expect_equal(hdfql_execute(paste("SELECT FROM example_dataset INTO MEMORY", hdfql_variable_get_number(new.values))), 0)
  expect_equal(hdfql_variable_unregister(new.values), 0)
  expect_equal(new.values, values)

  expect_equal(hdfql_execute("SELECT FROM example_dataset"), 0)
  i = 0
  while (hdfql_cursor_next() == HDFQL_SUCCESS) {
    i = i + 1
    expect_equal(hdfql_cursor_get_int(), values[[i]])
  }

  expect_silent(my_cursor <- hdfql_cursor())
  expect_equal(hdfql_cursor_use(my_cursor), 0)
  expect_equal(hdfql_execute("SHOW SIZE example_dataset"), 0)
  expect_equal(hdfql_cursor_first(), 0)
  expect_type(hdfql_cursor_get_bigint(), "double")
  expect_equal(hdfql_execute(sprintf('CLOSE FILE "%s"', testfile)), 0)

  expect_null(rm(my_cursor))
  expect_silent(gc())
  expect_type(detach(hql$wrapper), "environment")
})

unlink(testfile)
