
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

ascii_add_image_captions <- function(line) {
  if (grepl("^image:images.*", line)) {
    parts <- regmatches(line, regexec("^image:images[^\\[]+\\[([^\\]+)\\].*", line))[[1]]
    image_caption <- gsub("\n", " ", parts[2])

    line <- paste0(
      "[[", gsub("[^a-zA-Z]+", "_", image_caption), "]]\n",
      ".", image_caption, "\n",
      gsub("image:images", "image::images", line)
    )
  }

  line
}
