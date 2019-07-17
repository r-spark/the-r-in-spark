
ascii_add_footnotes <- function(groups, books_bib, remaining) {
  book_name <- groups[1]

  paste(
    "footnote:[",
    gsub("\n", " ", format(books_bib[[book_name]])),
    "]",
    sep = ""
  )
}

ascii_add_image_captions <- function(groups, books_bib, remaining) {
  image_caption_raw <- gsub("\n", " ", groups[2])
  image_caption_parts <- strsplit(image_caption_raw, "\\|\\|")
  image_caption <- image_caption_parts[[1]][1]
  image_label <- image_caption_parts[[1]][2]

  paste0(
    "\n[[", image_label, "]]\n",
    ".", image_caption, "\n",
    paste0(
      "image::images",
      groups[1],
      "[",
      image_caption,
      "]"
    )
  )
}

ascii_add_notes <- function(groups, books_bib, remaining) {
  note_type <- groups[1]

  end_idx <- regexpr("\n\n", remaining)[1] + 1
  note_value <- substr(remaining, 1, end_idx - 2)

  list(
    replacement = paste0("\n[", toupper(note_type), "]\n====\n", note_value, "\n====\n\n"),
    end_idx = end_idx
  )
}

ascii_add_figure_references <- function(groups, books_bib, remaining) {
  paste0("<<", groups[1], ">>")
}

ascii_remove_later <- function(groups, books_bib, remaining) {
  list(
    replacement = "",
    end_idx = nchar(remaining) + 1
  )
}
