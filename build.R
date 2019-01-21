source("r/ascii.R")

if (!dir.exists("ascii")) dir.create("ascii")
if (!dir.exists("mds")) dir.create("mds")

chapters <- list(
  "preface",
  "intro",
  "clusters",
  "connections",
  "tuning",
  "appendix"
)
chapters_pattern <- paste(chapters, collapse = "|")

for (chapter_file in dir(pattern = paste0(chapters_pattern, ".Rmd"))) {
  chapter_name <- tools::file_path_sans_ext(basename(chapter_file))

  withr::with_envvar(
    list(ASCIITEXT_RENDERING = TRUE), {
      knitr::knit(chapter_file, file.path("mds", paste(chapter_name, "md", sep = ".")))
    }
  )

  rmarkdown::pandoc_convert(
    input = normalizePath(paste0("mds/", chapter_name, ".md")),
    to = "asciidoc",
    options = c("--columns=120"),
    output = file.path("../ascii", paste0(chapter_name, ".asciidoc"))
  )

  if (identical(chapter_name, "preface")) {
    preface_own <- readLines("ascii/preface.asciidoc")
    preface_publisher <- readLines("../learning-apache-spark-with-r/preface_publisher.asciidoc")
    preface_joined <- c("[preface]", "== Preface", preface_own[-c(1,2)], "", preface_publisher)
    writeLines(preface_joined, "ascii/preface.asciidoc")
  }
}

files <- normalizePath(dir("ascii", full.names = T, pattern = chapters_pattern))
books_bib <- bibtex::read.bib("book.bib")

for (file in files) {
  lines <- readLines(file)

  fixed <- c()
  for (line in lines) {
    line <- ascii_add_footnotes(line, books_bib)
    line <- ascii_add_image_captions(line)
    fixed <- c(fixed, line)
  }

  fixed <- ascii_add_notes(fixed)

  writeLines(fixed, file)
}

ascii_files <- normalizePath(dir("ascii", chapters_pattern, full.names = T))
image_files <- normalizePath(dir("images", chapters_pattern, full.names = T))

file.copy(from = ascii_files, "../learning-apache-spark-with-r/", overwrite = T)
file.copy(from = image_files, "../learning-apache-spark-with-r/images/", overwrite = T)

