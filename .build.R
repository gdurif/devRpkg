# slides
src_files <- c("index.md", list.files("content", pattern = "*.md", ))
output_format <- "binb::metropolis"
rmarkdown::render(src_files, output_format)
