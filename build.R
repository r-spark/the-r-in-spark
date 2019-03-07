source("r/utils.R")
source("r/ascii.R")

if (!dir.exists("ascii")) dir.create("ascii")
if (!dir.exists("mds")) dir.create("mds")

chapters <- list(
  "preface",
  "intro",
  "starting",
  "analysis",
  "modeling",
  "clusters",
  "connections",
  "tuning",
  "distributed-r",
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
    options = c("--columns=180"),
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

transformations <- list(
  "\\[@([a-zA-Z0-9\\-]+)\\]" = ascii_add_footnotes,
  "\nimage:images([^\\[]+)\\[([^\\]]+)\\]" = ascii_add_image_captions,
  "\n\\*(Note|Tip|Warning):\\* " = ascii_add_notes,
  "Figure[ \n]+@ref\\(fig:([^\\)]+)\\)" = ascii_add_figure_references,
  "=== Later review" = ascii_remove_later
)

for (file in files) {
  lines <- readLines(file)
  all_lines <- paste(lines, collapse = "\n")

  for (regval in names(transformations)) {
    rem_lines <- all_lines
    fixed_lines <- c()

    while (grepl(regval, rem_lines, perl = TRUE)) {
      r <- regexec(regval, rem_lines, perl = TRUE)
      groups <- regmatches(rem_lines, r)[[1]]

      start_idx <- r[[1]][1]
      end_idx <- start_idx + nchar(groups[1])
      previous_str <- substr(rem_lines, 1, start_idx - 1)

      rem_lines <- substr(rem_lines, end_idx, nchar(rem_lines))
      result <- transformations[[regval]](groups[-1], books_bib, rem_lines)

      if (is.list(result)) {
        replacement <- result$replacement
        rem_lines <- substr(rem_lines, result$end_idx, nchar(rem_lines))
      }
      else {
        replacement <- result
      }

      fixed_lines <- c(
        fixed_lines,
        previous_str,
        replacement
      )
    }

    all_lines <- paste(c(fixed_lines, rem_lines), collapse = "")
  }

  writeLines(all_lines, file)
}

ascii_files <- normalizePath(dir("ascii", chapters_pattern, full.names = T))
image_files <- normalizePath(dir("images", chapters_pattern, full.names = T))

file.copy(from = ascii_files, "../learning-apache-spark-with-r/", overwrite = T)
file.copy(from = image_files, "../learning-apache-spark-with-r/images/", overwrite = T)

