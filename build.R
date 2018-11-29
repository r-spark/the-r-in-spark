source("r/ascii.R")

if (!dir.exists("ascii")) dir.create("ascii")
if (!dir.exists("mds")) dir.create("mds")

chapters <- list(
  "intro",
  "starting",
  "appendix"
)
chapters_pattern <- paste(chapters, collapse = "|")

references <- list(
  "Worlds Store Capacity" = "storage-capacity",
  "Daily downloads of CRAN packages" = "cran-downloads",
  "Google trends for mainframes, cloud computing and kubernetes" = "cluster-trends"
)

for (chapter_file in dir(pattern = paste0(chapters_pattern, ".Rmd"))) {
  chapter_name <- tools::file_path_sans_ext(basename(chapter_file))

  knitr::knit(chapter_file, file.path("mds", paste(chapter_name, "md", sep = ".")))
  rmarkdown::pandoc_convert(
    input = normalizePath(paste0("mds/", chapter_name, ".md")),
    to = "asciidoc",
    output = file.path("../ascii", paste0(chapter_name, ".asciidoc"))
  )
}

ascii_add_references(
  normalizePath(dir("ascii", full.names = T, pattern = chapters_pattern)),
  references
)

ascii_files <- normalizePath(dir("ascii", chapters_pattern, full.names = T))
image_files <- normalizePath(dir("images", chapters_pattern, full.names = T))

file.copy(from = ascii_files, "../learning-apache-spark-with-r/", overwrite = T)
file.copy(from = image_files, "../learning-apache-spark-with-r/images/", overwrite = T)
