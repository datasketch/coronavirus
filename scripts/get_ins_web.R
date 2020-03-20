library(rvest)
library(tidyverse)

system("phantomjs read_html.js")
ins <- read_html("static/data/ins/ins.html")

ins_tables <- ins %>% html_table()

updated <- gsub("COVID-19 Colombia \\| Reporte |Corte ","", names(ins_tables[[1]]))
updated_date <- lubridate::dmy(substr(updated, 1, 10))
updated_time <- substr(updated, 12, nchar(updated) - 2)

number <- ins %>%
  html_nodes(".igc-textual-figure") %>%
  html_text()

info <- ins %>%
  html_nodes(".igc-textual-fact") %>%
  html_text()

x <- tibble(info = info, number = number) %>%
  filter(info != "") %>%
  mutate(number = as.numeric(gsub("\\.","", number)))

reports <- transpose(x) %>%
  map("number") %>%
  set_names(x$info) %>%
  as_tibble()

reports$updated <- lubridate::parse_date_time(updated, orders = "dmyIp", tz = "America/Bogota")
reports$updated <- as.character(reports$updated)
reports$updated_date <- substr(reports$updated,1,10)
reports$updated_time <- substr(reports$updated,12,16)

message("\nUpdated: \n",reports$updated)

reports <- reports %>% select(updated, updated_date, updated_time, everything())
write_csv(reports, paste0("static/data/ins/reports/", reports$updated, ".csv"))

all_reps <- list.files("static/data/ins/reports/", full.names = TRUE)
all_reps <- map(all_reps, read_csv) %>% bind_rows()

write_csv(all_reps, "static/data/ins/ins_reports.csv")

cases <- ins_tables[[2]]
message("\nCases table with columns:\n", paste(names(cases), collapse = ", "),
        "\n# nrow: ",nrow(cases),
        "\n# col: ", ncol(cases))

cases <- cases %>%
  rename(idx = "ID de caso",
         fecha = "Fecha de diagnóstico",
         ciudad = "Ciudad de ubicación",
         sexo = "Sexo",
         tipo_contagio = "Tipo")

write_csv(cases, "static/data/ins/ins_web.csv")
write_csv(cases, paste0("static/data/ins/", gsub("[ :]", "_", Sys.time()), "_ins.csv"))
