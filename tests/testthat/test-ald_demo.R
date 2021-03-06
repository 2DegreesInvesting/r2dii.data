test_that("hasn't changed", {
  on_windows <- identical(.Platform$OS.type, "windows")
  skip_if(on_windows)

  r_version <- paste0(
    R.version$major,
    ".",
    R.version$minor
  )
  r_version > "3.6.0"
  # ald_demo is now generated using random sampling.
  # random sampling seems to have changed in R after version 3.6.0
  # see ?RNGkind
  skip_if(r_version < "3.6.0")

  expect_snapshot_value(ceiling_dbl(ald_demo), style = "json2")
})

test_that("ald_demo has column `company_id`", {
  expect_true(hasName(ald_demo, "company_id"))
})

test_that("ald_demo$company_id is of type character, as promised", {
  expect_type(ald_demo$company_id, "character")
})

test_that("ald_demo$company_id is unique to `name_company` and `sector`", {
  out <- ald_demo[c("company_id", "name_company", "sector")]
  out <- unique(out)
  out <- out$company_id[duplicated(out$company_id)]

  expect_length(out, 0L)
})
