ascii_add_references <- function(files, references) {
  for (file in files) {
    lines <- readLines(file)
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

    writeLines(fixed, file)
  }
}
