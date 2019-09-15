exercises_chapters <- list(
  "starting",
  "analysis",
  "modeling",
  "pipelines",
  "data",
  "extensions",
  "distributed-r",
  "streaming"
)

build_exercises <- function() {
  chapters <- exercises_chapters

  file.copy(
    dir(".", pattern = paste(chapters, collapse = "|"), full.names = TRUE),
    "excersises/",
    overwrite = TRUE
  )

  for (file in dir("excersises", full.names = TRUE)) {
    reg_comment <- "^#+ [A-Z][a-z]+.*$"
    reg_rcode <- "^```\\{r.*"
    reg_code <- "^```.*$"
    reg_rmarkdown <- "^````markdown"

    content <- readLines(file)
    matches <- which(grepl(paste(reg_comment, reg_rcode, reg_code, reg_rmarkdown, sep = "|"), content))
    match_endings <- which(grepl("^```$", content))
    match_endings_rmd <- which(grepl("^````$", content))

    new_content <- c()
    match_idx <- 1
    while (match_idx <= length(matches)) {
      match <- matches[match_idx]

      comment <- grepl(reg_comment, content[match])
      rcode <- grepl(reg_rcode, content[match])
      rmarkdown <- grepl(reg_rmarkdown, content[match])

      if (comment) {
        new_content <- c(new_content, "", content[match])

        match_idx <- match_idx + 1
      }
      else if (rmarkdown) {
        ending_idx <- which(match_endings_rmd > match)
        if (length(ending_idx) == 0) {
          warning("Can't find closing RMD statement in ", file, "#", matches[match_idx], " for: ", content[match])
          match_idx <- length(matches) + 1
        }
        else {
          chunk_content <- content[match:match_endings_rmd[ending_idx[1]]]
          new_content <- c(new_content, "", chunk_content)

          match_next <- which(matches > match_endings_rmd[ending_idx[1]])
          match_idx <- if (length(match_next) == 0 ) length(matches) + 1 else match_next[1]
        }
      }
      else {
        ending_idx <- which(match_endings > match)
        if (length(ending_idx) == 0) {
          warning("Can't find closing statement in ", file, "#", matches[match_idx], " for: ", content[match])
          match_idx <- length(matches) + 1
        }
        else {
          chunk_content <- content[match:match_endings[ending_idx[1]]]

          skip <- grepl("eval ?= ?FALSE|echo ?= ?FALSE", content[match]) && !grepl("exercise=TRUE", content[match])
          skip <- skip || grepl("include=FALSE", content[match])
          skip <- skip || any(grepl("render_image\\(|render_nomnoml\\(", chunk_content))

          if (skip) rcode <- FALSE

          if (rcode) {
            new_content <- c(new_content, "", chunk_content)
          }

          match_next <- which(matches > match_endings[ending_idx[1]])
          match_idx <- if (length(match_next) == 0 ) length(matches) + 1 else match_next[1]
        }
      }
    }

    writeLines(new_content, file)
  }
}
