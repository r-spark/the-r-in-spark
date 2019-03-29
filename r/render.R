render_nomnoml <- function(code, png, caption = NULL, styles = "") {
  nomnoml::nomnoml(paste0(styles, "\n", code), png = png)
  png_resized <- resize_image_if_needed(png)

  if (identical(Sys.getenv("ASCIITEXT_RENDERING"), "TRUE")) {
    if (is.null(caption)) {
      caption <- knitr::opts_current$get()[["fig.cap"]]
      if (nchar(as.character(caption)) == 0)
        caption <- "CAPTION IS MISSING!"
    }

    knitr::asis_output(paste0("![", caption, "||", knitr::opts_current$get()$label, "](", png_resized, ")"))
  } else {
    knitr::include_graphics(png_resized)
  }
}

resize_image_if_needed <- function(image) {
  image_name <- basename(image)
  image_noext <- tools::file_path_sans_ext(image_name)
  image_resized <- file.path(dirname(image), paste0(image_noext, "-resized.png"))

  original <- png::readPNG(image)
  org_width <- ncol(original)
  org_height <- nrow(original)

  max_width <- 3000
  max_height <- 1400

  ratio <- org_width / org_height
  if (ratio >= max_width / max_height) {
    image_resized <- image
  }
  else {
    output <- grDevices::png(image_resized, width = max_width, height = max_height)
    graphics::plot.new()
    graphics::par(mar=c(0,0,0,0))
    graphics::plot.window(c(0, max_width), c(0, max_height), xaxs = "i", yaxs = "i")
    usr <- graphics::par("usr")

    tar_width <- ratio * max_height
    graphics::rasterImage(original, usr[1] + (max_width - tar_width) / 2, usr[3], usr[2] - (max_width - tar_width) / 2, usr[4])
    grDevices::dev.off()
  }

  image_resized
}

render_image <- function(image, caption = NULL) {
  image_resized <- resize_image_if_needed(image)

  if (identical(Sys.getenv("ASCIITEXT_RENDERING"), "TRUE")) {
    if (is.null(caption)) {
      caption <- knitr::opts_current$get()$caption
      if (nchar(ascharacter(caption)) == 0)
        caption <- "CAPTION IS MISSING!"
    }

    knitr::asis_output(
      paste0("![", caption, "||", knitr::opts_current$get()$label, "](", image_resized, ")")
    )
  } else {
    knitr::include_graphics(image_resized)
  }
}

render_clear_resized <- function() {
  unlink(dir("images/", "resized.png", full.names = T))
}
