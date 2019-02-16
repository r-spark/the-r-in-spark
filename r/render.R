render_nomnoml <- function(code, png, caption, styles = "") {
  if (identical(Sys.getenv("ASCIITEXT_RENDERING"), "TRUE")) {
    if (!file.exists(png))
      nomnoml::nomnoml(paste0(styles, "\n", code), png = png)
    knitr::asis_output(paste0("![", caption, "||", knitr::opts_current$get()$label, "](", png, ")"))
  } else {
    nomnoml::nomnoml(paste0(styles, "\n", code))
  }
}

render_image <- function(image, caption) {
  if (identical(Sys.getenv("ASCIITEXT_RENDERING"), "TRUE")) {
    knitr::asis_output(
      paste0("![", caption, "||", knitr::opts_current$get()$label, "](", image, ")")
    )
  } else {
    knitr::include_graphics(image)
  }
}
