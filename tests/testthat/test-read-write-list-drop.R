testfile = tempfile(fileext = ".h5")
hql_create_file(testfile)

test.boolean = sample(c(TRUE, FALSE), 20, replace = TRUE)
test.boolean.path = "dataset0"

test.numeric = matrix(rnorm(100), nrow = 20)
test.numeric.path = "group1/dataset1"
test.numeric.att = "normal"
test.numeric.att.path = "group1/dataset1/dist"

test.character = month.name
test.character.path = "group1/group1.1/dataset2"
test.character.att = list(
  "abbreviation" = month.abb,
  "number" = array(1:12)
)

test.integer = array(rpois(100, 3), dim = c(5, 5, 4))
test.integer.path = "group1/group1.1/dataset3"
attr(test.integer, "zmeans") = as.array(apply(test.integer, 1:2, mean))


test_that("writing works", {
  hql_use_file(testfile)

  expect_null(hql_write_dataset(as.integer(test.boolean), test.boolean.path))

  expect_null(hql_write_dataset(test.numeric, test.numeric.path))
  expect_null(hql_write_attribute(test.numeric.att, test.numeric.att.path))

  expect_null(hql_write_dataset(test.character, test.character.path))
  expect_null(hql_write_all_attributes(test.character.att, test.character.path))

  expect_null(hql_write_dataset(test.integer, test.integer.path))

  hql_close_file(testfile)
})

test_that("listing datasets works", {
  hql_use_file(testfile)

  expect_identical(hql_list_datasets(""), test.boolean.path)
  expect_identical(hql_list_datasets("", recursive = TRUE),
    c(test.boolean.path, test.numeric.path,
      test.character.path, test.integer.path))

  expect_identical(hql_list_datasets(dirname(test.numeric.path), recursive = FALSE),
    test.numeric.path)

  expect_identical(hql_list_datasets(dirname(test.character.path), recursive = FALSE),
    c(test.character.path, test.integer.path))

  expect_identical(hql_list_groups("", recursive = TRUE),
    dirname(c(test.numeric.path, test.character.path)))

  expect_identical(hql_list_groups(dirname(test.numeric.path), recursive = FALSE),
    dirname(test.character.path))

  expect_identical(hql_list_attributes(test.character.path),
    names(test.character.att))

  hql_close_file(testfile)
})


test_that("reading datasets works", {
  hql_use_file(testfile)

  expect_equal(as.logical(hql_read_dataset(test.boolean.path)), test.boolean)

  expect_equivalent(hql_read_dataset(test.numeric.path, include.attributes = FALSE),
    test.numeric)
  expect_identical(hql_read_attribute(test.numeric.att.path), test.numeric.att)

  expect_equivalent(trimws(hql_read_dataset(test.character.path)), test.character)

  expect_equivalent(hql_read_all_attributes(test.character.path), test.character.att)

  expect_equivalent(hql_read_dataset(test.integer.path, include.attributes = TRUE),
    test.integer)

  hql_close_file(testfile)
})


test_that("dropping datasets works", {
  hql_use_file(testfile)

  expect_null(hql_drop_dataset(test.boolean.att.path))
  expect_null(hql_drop_attribute(test.numeric.att.path))

  expect_null(hql_drop_dataset(test.numeric.att.path)))

  expect_null(hql_drop_all_attributes(test.character.path))

  expect_error(hql_drop_group(dirname(test.numeric.path), FALSE))
  expect_null(hql_drop_group(dirname(test.numeric.path), TRUE))

  hql_close_file(testfile)
})

unlink(testfile)
