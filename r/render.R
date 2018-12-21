render_nomnoml <- function(code, png, caption, styles = "") {
  if (identical(Sys.getenv("ASCIITEXT_RENDERING"), "TRUE")) {
    if (!file.exists(png))
      nomnoml::nomnoml(paste0(styles, "\n", code), png = png)
    knitr::asis_output(paste0("![", caption, "](", png, ")"))
  } else {
    nomnoml::nomnoml(paste0(styles, "\n", code))
  }
}
