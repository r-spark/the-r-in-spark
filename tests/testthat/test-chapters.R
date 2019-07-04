context("chapters")

test_that("can knit intro", {
  rmarkdown::render("sources/intro.Rmd", output_dir = "output")
  expect_true(file.exists("output/intro.html"))
})

test_that("can knit starting", {
  rmarkdown::render("sources/starting.Rmd", output_dir = "output")
  expect_true(file.exists("output/starting.Rmd"))
})

test_that("can knit extensions", {
  rmarkdown::render("sources/extensions.Rmd", output_dir = "output")
  expect_true(file.exists("output/extensions.Rmd"))
})
