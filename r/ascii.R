
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

ascii_add_notes <- function(lines) {
  all_lines <- paste(lines, collapse = "\n")

  while (grepl("\n\\*(Note|Tip|Warning):\\*.*\n\n", all_lines)) {
    r <- regexec("\n\\*(Note|Tip|Warning):\\*.*\n\n", all_lines)

    start_idx <- r[[1]][1]
    start <- substr(all_lines, 1, start_idx)
    remaining <- substr(all_lines, start_idx, nchar(all_lines))
    end_idx <- regexec("\n\n", remaining)[[1]][1]
    replacement <- substr(all_lines, start_idx, start_idx + end_idx - 1)
    end <- substr(remaining, end_idx, nchar(remaining))

    note_type <- regmatches(replacement, regexec("Note|Tip|Warning", replacement))[[1]]

    all_lines <- paste0(start, "[", toupper(note_type), "]\n====", gsub("\\*(Note|Tip|Warning):\\* +", "", replacement), "====\n", end)
  }

  strsplit(all_lines, "\n")[[1]]
}

ascii_add_figure_references <- function(line) {
  if (grepl("Figure @ref\\(fig:.*", line)) {
    parts <- regmatches(line, regexec("Figure @ref\\(fig:([^\\)]+)", line))[[1]]
    image_reference <- gsub("\n", " ", parts[2])

    line <- gsub("Figure @ref\\(fig:([^\\)]+)\\)", paste0("<<", image_reference, ">>"), line)
  }

  line
}
