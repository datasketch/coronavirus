library(jsonlite)
library(tidyverse)
library(yaml)


# Generate Datasets
l <- fromJSON("data/datasets.json", simplifyDataFrame = FALSE)
path <- "content/datasets/"
unlink("content/datasets/", recursive = TRUE)
dir.create("content/datasets/")
walk(l, function(x){
  yaml <- paste0("---\n",as.yaml(x),"---\n")
  write_lines(yaml, file.path(path,paste0(x$uid,".md")))
})

# Generate Viz
l <- fromJSON("data/viz.json", simplifyDataFrame = FALSE)
path <- "content/viz/"
unlink("content/viz/", recursive = TRUE)
dir.create("content/viz/")
walk(l, function(x){
  yaml <- paste0("---\n",as.yaml(x),"---\n")
  write_lines(yaml, file.path(path,paste0(x$uid,".md")))
})

# Generate Scope
l <- fromJSON("data/scopes.json", simplifyDataFrame = FALSE)
path <- "content"
all_scopes <- jsonlite::fromJSON("data/all-scopes.json")
unlink(paste0("content/",all_scopes,".md"), recursive = FALSE)
# dir.create("content")
walk(l, function(x){
  x$type <- "scope"
  yaml <- paste0("---\n",as.yaml(x),"---\n")
  write_lines(yaml, file.path(path,paste0(x$uid,".md")))
})
