if (dir.exists("sources")) unlink("sources", recursive = TRUE)
if (dir.exists("sources")) unlink("output", recursive = TRUE)

if (!dir.exists("sources")) dir.create("sources")

file.copy(dir("../../", pattern = "*.Rmd", full.names = TRUE), "sources/", recursive = TRUE)
file.copy("../../rmds/report.Rmd", "sources/", recursive = TRUE)
file.copy("../../plumber/", "sources/", recursive = TRUE)
file.copy("../../r/", "sources/", recursive = TRUE)
file.copy("../../data/", "sources/", recursive = TRUE)
file.copy("../../images/", "sources/", recursive = TRUE)

for (rmd in dir("sources", pattern = "*.Rmd", full.names = TRUE)) {
  lines <- readLines(rmd)

  comments <- which(grepl( "# .*", lines))

  if (length(comments) > 0) {
    start <- comments[[1]]
    writeLines(c(
      "```{r include=FALSE}",
      "source(\"r/render.R\")",
      "```",
      lines[start:length(lines)]), rmd)
  }
}
