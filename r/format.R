format_footnote_with_period <- function(groups, remaining) {
  footnote_name <- groups[1]

  paste(
    ". [@",
    footnote_name,
    "]",
    sep = ""
  )
}

format_transformations <- list(
  " \\[@([a-zA-Z0-9\\-]+)\\]\\." = format_footnote_with_period
)

format_chapters <- list(
  "preface",
  "intro",
  "starting",
  "analysis",
  "modeling"
)

format_chapters_pattern <- paste(format_chapters, collapse = "|")
format_chapters_files <- dir(pattern = paste0(format_chapters_pattern, ".Rmd"))

# Apply editorial formatting rules
format_all_chapters <- function() {
  for (chapter_file in format_chapters_files) {
    lines <- readLines(chapter_file)
    all_lines <- paste(lines, collapse = "\n")

    for (regval in names(format_transformations)) {
      rem_lines <- all_lines
      fixed_lines <- c()

      while (grepl(regval, rem_lines, perl = TRUE)) {
        r <- regexec(regval, rem_lines, perl = TRUE)
        groups <- regmatches(rem_lines, r)[[1]]

        start_idx <- r[[1]][1]
        end_idx <- start_idx + nchar(groups[1])
        previous_str <- substr(rem_lines, 1, start_idx - 1)

        rem_lines <- substr(rem_lines, end_idx, nchar(rem_lines))
        result <- format_transformations[[regval]](groups[-1], rem_lines)

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

    writeLines(all_lines, chapter_file)
  }
}
