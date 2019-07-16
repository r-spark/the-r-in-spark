context("chapters")

test_that("can knit intro", {
  rmarkdown::render("sources/intro.Rmd", output_dir = "output")
  expect_true(file.exists("output/intro.html"))
})

test_that("can knit starting", {
  rmarkdown::render("sources/starting.Rmd", output_dir = "output")
  expect_true(file.exists("output/starting.html"))
})

test_that("can knit analysis", {
  skip("troubleshoot streaming")
  rmarkdown::render("sources/analysis.Rmd", output_dir = "output")
  expect_true(file.exists("output/analysis.html"))
})

test_that("can knit modeling", {
  skip("troubleshoot streaming")
  rmarkdown::render("sources/modeling.Rmd", output_dir = "output")
  expect_true(file.exists("output/modeling.html"))
})

test_that("can knit pipelines", {
  skip("troubleshoot streaming")
  rmarkdown::render("sources/pipelines.Rmd", output_dir = "output")
  expect_true(file.exists("output/pipelines.html"))
})

test_that("can knit data", {
  skip("troubleshoot streaming")
  rmarkdown::render("sources/data.Rmd", output_dir = "output")
  expect_true(file.exists("output/data.html"))
})

test_that("can knit extensions", {
  skip("troubleshoot streaming")
  rmarkdown::render("sources/extensions.Rmd", output_dir = "output")
  expect_true(file.exists("output/extensions.html"))
})

test_that("can knit distributed", {
  skip("troubleshoot streaming")
  rmarkdown::render("sources/distributed-r.Rmd", output_dir = "output")
  expect_true(file.exists("output/distributed-r.html"))
})

test_that("can knit streaming", {
  rmarkdown::render("sources/streaming.Rmd", output_dir = "output")
  expect_true(file.exists("output/streaming.html"))
})
