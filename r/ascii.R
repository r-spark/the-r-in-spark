ascii_add_references <- function(lines, references) {
  fixed <- c()
  for (line in lines) {
    if (line %in% names(references)) {
      fixed <- c(
        fixed,
        paste0("[[", references[[line]], "]]")
      )
    }
    fixed <- c(fixed, line)
  }

  fixed
}

ascii_add_footnotes <- function(line, books_bib) {
  if (grepl("\\[@[a-zA-Z\\-]+\\]", line)) {
    parts <- regmatches(line, regexec("(.*)\\[@([a-zA-Z\\-]+)\\](.*)", line))[[1]]
    book_name <- parts[3]

    line <- paste(
      parts[2],
      "footnote:[",
      format(books_bib[[book_name]]),
      "]",
      parts[4],
      sep = ""
    )

    gsub("\n", " ", line)
  }

  line
}
