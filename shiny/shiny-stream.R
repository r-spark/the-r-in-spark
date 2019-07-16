library(sparklyr)
library(shiny)

unlink("shiny-stream", recursive = TRUE)
dir.create("shiny-stream", showWarnings = FALSE)

sc <- spark_connect(
  master = "local", version = "2.3",
  config = list(sparklyr.sanitize.column.names = FALSE))

ui <- pageWithSidebar(
  headerPanel('Iris k-means clustering from Spark stream'),
  sidebarPanel(
    selectInput('xcol', 'X Variable', names(iris)),
    selectInput('ycol', 'Y Variable', names(iris),
                selected=names(iris)[[2]]),
    numericInput('clusters', 'Cluster count', 3,
                 min = 1, max = 9)
  ),
  mainPanel(plotOutput('plot1'))
)

server <- function(input, output, session) {
  iris <- stream_read_csv(sc, "shiny-stream",
                          columns = sapply(datasets::iris, class)) %>%
    reactiveSpark()

  selectedData <- reactive(iris()[, c(input$xcol, input$ycol)])
  clusters <- reactive(kmeans(selectedData(), input$clusters))

  output$plot1 <- renderPlot({
    par(mar = c(5.1, 4.1, 0, 1))
    plot(selectedData(), col = clusters()$cluster, pch = 20, cex = 3)
    points(clusters()$centers, pch = 4, cex = 4, lwd = 4)
  })
}

shinyApp(ui, server)
