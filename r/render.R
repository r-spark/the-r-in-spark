render_nomnoml <- function(code, png, caption, styles = "") {
  diagram <- nomnoml::nomnoml(paste0(styles, "\n", code), png = png)

  if (identical(Sys.getenv("ASCIITEXT_RENDERING"), "TRUE")) {
    knitr::asis_output(paste0("![", caption, "](", png, ")"))
  } else {
    diagram
  }
}
