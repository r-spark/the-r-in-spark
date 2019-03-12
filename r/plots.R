plot_style <- function() {
  font <- "Helvetica"

  ggplot2::theme(
    plot.title = ggplot2::element_text(family = font,
                                       size=14,
                                       color = "#222222"),
    plot.subtitle = ggplot2::element_text(family=font,
                                          size=12,
                                          color = "#666666"),

    legend.position = "right",
    legend.background = ggplot2::element_blank(),
    legend.title = ggplot2::element_blank(),
    legend.key = ggplot2::element_blank(),
    legend.text = ggplot2::element_text(family=font,
                                        size=14,
                                        color="#222222"),

    axis.title.y = element_text(margin = margin(t = 0, r = 8, b = 0, l = 0),
                                size = 14,
                                color="#666666"),
    axis.title.x = element_text(margin = margin(t = -2, r = 0, b = 0, l = 0),
                                size = 14,
                                color = "#666666"),
    axis.text = ggplot2::element_text(family=font,
                                      size=14,
                                      color="#222222"),
    axis.text.x = ggplot2::element_text(margin=ggplot2::margin(5, b = 10)),
    axis.ticks = ggplot2::element_blank(),
    axis.line = ggplot2::element_blank(),

    panel.grid.minor = ggplot2::element_blank(),
    panel.grid.major.y = ggplot2::element_line(color = "#eeeeee"),
    panel.grid.major.x = ggplot2::element_line(color = "#ebebeb"),

    panel.background = ggplot2::element_blank(),

    strip.background = ggplot2::element_rect(fill = "white"),
    strip.text = ggplot2::element_text(size  = 20,  hjust = 0)
  )
}
