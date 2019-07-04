if (dir.exists("sources")) unlink("sources", recursive = TRUE)
if (dir.exists("sources")) unlink("output", recursive = TRUE)

if (!dir.exists("sources")) dir.create("sources")

file.copy(dir("../../", pattern = "*.Rmd", full.names = TRUE), "sources/", recursive = TRUE)
file.copy("../../data/", "sources/", recursive = TRUE)
file.copy("../../images/", "sources/", recursive = TRUE)

for (rmd in dir("sources", pattern = "*.Rmd", full.names = TRUE)) {
  lines <- readLines(rmd)

  comments <- which(grepl( "# .*", lines))

  if (length(comments) > 0) {
    start <- comments[[1]]
    writeLines(lines[start:length(lines)], rmd)
  }
}
