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
html <- read_html(local_url)

html_tables <- html %>%
  rvest::html_table()
last_updated <- names(html_tables[[1]])
updated <- gsub("COVID-19 Colombia \\| Reporte |Corte ","", last_updated)
updated_date <- lubridate::dmy(substr(updated,1,10))
updated_time <- substr(updated,12,nchar(updated)-1)

cases <- html_tables[[2]]


number <- html %>%
  html_nodes(".igc-textual-figure") %>%
  html_text()
info <- html %>%
  html_nodes(".igc-textual-fact") %>%
  html_text()
x <- tibble(info = info, number = number) %>%
  filter(info != "") %>%
  mutate(number = as.numeric(gsub("\\.","", number)))
reports <- transpose(x) %>%
  map("number") %>%
  set_names(x$info) %>%
  as_tibble()
reports$updated <- parse_date_time(updated, orders = "dmyIp", tz = "America/Bogota")
reports$updated <- as.character(reports$updated)
reports$updated_date <- substr(reports$updated,1,10)
reports$updated_time <- substr(reports$updated,12,16)

message("\nUpdated: \n",reports$updated)
reports <- reports %>% select(updated, updated_date, updated_time, everything())
write_csv(reports, paste0("data/ins/reports/",reports$updated,".csv"))

all_reps <- list.files("data/ins/reports/", full.names = TRUE)
all_reps <- map(all_reps, read_csv) %>% bind_rows()

write_csv(all_reps, "data/ins/ins_reports.csv")

message("\nCases table with columns:\n", paste(names(cases), collapse = ", "),
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

