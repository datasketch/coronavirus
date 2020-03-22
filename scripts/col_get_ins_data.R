library(rvest)
library(tidyverse)


# dotenv::load_dot_env()
# sheets_deauth()
# # INS
# gsheet_ins <- Sys.getenv("GSHEET_URL_INS")
# tabs <- sheets_sheets(gsheet_ins)
#
# tests <- read_sheet(gsheet_ins, sheet = "tests")
# colombia_reports <- tests %>% select(fecha = updated_date,
#                                      confirmed = `Casos Confirmados en Colombia`, everything())
# write_csv(colombia_reports, "data/ins/reports_gsheet.csv")
#
# cases_tabs <- tabs[grepl("rep_*[^v]*$", tabs)]
# #latest <- sort(tabs[grepl("rep_*[^v]*$", tabs)], decreasing = TRUE)[1]
# latest <- cases_tabs[1]
# message("\nLatest: ", latest)
#
# cases <- read_sheet(gsheet_ins, sheet = latest, skip = 1,
#                     col_types = "???????????????????")
#
# message("\nCases table with columns:\n", paste(names(cases), collapse = ", "),
#         "\n# nrow: ",nrow(cases),
#         "\n# col: ", ncol(cases))

### Load local cases
# latest <- list.files("data/ins", full.names = TRUE)
# cases <- read_csv("data/ins/ins_web.csv", col_types = cols(.default = "c"))
# names(cases)

# cases <- read_csv("data/ins/ins_web.csv", col_types = cols(.default = "c"))
# names(cases)



## Get data from web

system("phantomjs scripts/read_html.js")
ins <- read_html("static/data/ins/prep/ins.html")


x <- ins %>% html_table()


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
filename <- gsub(" ","_",gsub(":","-",reports$updated))
write_csv(reports, paste0("static/data/ins/reports/",filename, ".csv"))

all_reps <- list.files("static/data/ins/reports/", full.names = TRUE)
all_reps <- map(all_reps, read_csv) %>% bind_rows()

write_csv(all_reps, "static/data/ins/col_reports.csv")

cases_html_table <- ins_tables[[2]]

if(nrow(cases_html_table) < reports$`Casos Confirmados en Colombia`){
  # Try
  today <- as.character(Sys.Date())
  latest_local_case <- tail(list.files("static/data/ins/cases/", full.names = TRUE),1)
  if(!grepl(today, latest_local_case)){
    stop("No local file")
  }
  cases <- read_csv(latest_local_case)
}else{
  cases <- cases_html_table
  filename <- gsub(" ","_",gsub(":","-",reports$updated))
  write_csv(cases, paste0("static/data/ins/cases/",filename, ".csv"))
}

message("\nCases table with columns:\n", paste(names(cases), collapse = ", "),
        "\n# nrow: ",nrow(cases),
        "\n# col: ", ncol(cases))

cases <- cases %>%
  rename(idx = "ID de caso",
         fecha = "Fecha de diagnóstico",
         ciudad = "Ciudad de ubicación",
         atencion = "Atención",
         edad = "Edad",
         sexo = "Sexo",
         tipo_contagio = "Tipo*",
         pais_procedencia = "País de procedencia")

write_csv(cases, "static/data/ins/prep/ins_cases.csv")
# write_csv(cases, paste0("static/data/ins/", gsub("[ :]", "_", Sys.time()), "_ins.csv"))
