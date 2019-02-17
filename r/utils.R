`%<-%` <- function(x, value) {
  dest <- as.character(as.list(substitute(x))[-1])
  if (length(dest) != length(value)) stop("Assignment must contain same number of elements")

  for (i in seq_along(dest)) {
    assign(dest[i], value[i], envir = sys.frame(which =sys.parent(n = 1)))
  }

  invisible(NULL)
}
