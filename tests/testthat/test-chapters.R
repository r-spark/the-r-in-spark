context("chapters")

chapters <- Sys.getenv("BOOK_CHAPTERS", "intro,starting,analysis,modeling,pipelines,data,extensions,distributed-r,streaming")

for (chapter in strsplit(chapters, ",")[[1]]) {
  test_that(paste("can knit", chapter), {
    rmarkdown::render(paste0("sources/", chapter, ".Rmd"), output_dir = "output")
    expect_true(file.exists(paste0("output/", chapter, ".html")))
  })
}
