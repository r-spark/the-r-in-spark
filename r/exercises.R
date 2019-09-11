exercises_chapters <- list(
  "starting",
  "analysis",
  "modeling",
  "pipelines",
  "data",
  "tuning",
  "extensions",
  "distributed-r",
  "streaming",
  "contributing",
  "appendix"
)

build_exercises <- function() {
  chapters <- exercises_chapters

  file.copy(
    dir(".", pattern = paste(chapters, collapse = "|"), full.names = TRUE),
    "excersises/"
  )

  for (file in dir("excersises", full.names = TRUE)) {
    content <- readLines(file)
    matches <- which(grepl("^#+ [A-Z][a-z]+.*$", content))

    new_content <- c()
    for (match in matches) {
      new_content <- c(new_content, content[match])
    }

    writeLines(new_content, file)
  }
}
