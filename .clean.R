# remove pdfslides
src_files <- c("index.pdf", list.files("content", pattern = "*.pdf"))
fs::file_delete(src_files)
