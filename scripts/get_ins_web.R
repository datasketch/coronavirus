library(rvest)
library(tidyverse)

## Ins
# url <- "http://www.ins.gov.co/Noticias/Paginas/Coronavirus.aspx"
#
# h <- read_html(url)
# scripts <- h %>%
#   html_nodes("script")
# script_ids <- scripts %>%
#   html_attr("id")
# infogram <- scripts[[grep("infogram", script_ids)]]
# infogram_id <- infogram %>% html_attr("id")
# infogram_url <- paste0("http://infogram.com/",
#                        gsub("infogram_0_", "", infogram_id, fixed = TRUE)
#                        )

## Save local html

message("\nPhantom\n")

system("phantomjs read_html.js")
message("\nSaved page contents\n")
local_url <- "data/ins/ins.html"
h <- read_html(local_url) %>%
  rvest::html_table()
cases <- h[[2]]

message("\nTable with columns:\n", paste(names(cases), collapse = ", "),
        "\n# nrow: ",nrow(cases),
        "\n# col: ", ncol(cases))

message("\nWriting table\n")
cases <- cases %>%
  rename(idx = "ID de caso",
         fecha = "Fecha de diagnóstico",
         ciudad = "Ciudad de ubicación"
         )
write_csv(cases, "data/ins/ins_web.csv")


# write_csv(cases, paste0("data/ins/",gsub("[ :]","_",Sys.time()),"_ins.csv"))

