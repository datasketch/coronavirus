library(rvest)
library(tidyverse)

## Get data from web

scrape_ins <- function(){
  system("phantomjs scripts/read_html.js")
  ins <- read_html("static/data/ins/prep/ins.html")
  ins %>% html_table()
}
x <- scrape_ins()
if(length(x) < 2){
  x <- scrape_ins()
}

ins_tables <- ins %>% html_table()

updated <- gsub("COVID-19 Colombia \\| Reporte |Corte ","", names(ins_tables[[1]]))
updated_date <- lubridate::dmy(substr(updated, 1, 10))
updated_time <- substr(updated, 12, nchar(updated) - 2)


entry <- ins %>%
  html_nodes(".igc-textual-entry")

entryNumber <- entry %>%
  html_nodes(".igc-textual-figure") %>%
  html_text()
entryText <- entry %>%
  html_nodes(".igc-textual-fact") %>%
  html_text()
entryText <- gsub("Ingresó a Colombia después de venir de un país con circulación de COVID",
                  "",
                  entryText)
entryText <- gsub("Tuvo contacto con un caso confirmado de COVID",
                  "",
                  entryText)
entryText <- gsub("se está definiendo la cadena de transmisión",
                  "",
                  entryText)

# number <- ins %>%
#   html_nodes(".igc-textual-figure") %>%
#   html_text()
# info <- ins %>%
#   html_nodes(".igc-textual-fact b") %>%
#   html_text()
number <- entryNumber
info <- entryText

x <- tibble(info = info, number = number) %>%
  filter(info != "") %>%
  mutate(number = as.numeric(gsub("\\.","", number)))

reports <- transpose(x) %>%
  map("number") %>%
  set_names(x$info) %>%
  as_tibble()

if(ncol(reports) < 7){
  # stop("Update recent report by hand")
  today <- as.character(Sys.Date())
  latest_local_report <- tail(list.files("static/data/ins/cases",
                                         full.names = TRUE),1)
  if(!grepl(today, latest_local_report)){
    stop("No local report")
  }
  message("Found latest local report")
}else{
  reports$updated <- lubridate::parse_date_time(updated, orders = "dmyIp", tz = "America/Bogota")
  reports$updated <- as.character(reports$updated)
  reports$updated_date <- substr(reports$updated,1,10)
  reports$updated_time <- substr(reports$updated,12,16)

  message("\nUpdated: \n",reports$updated)

  reports <- reports %>% select(updated, updated_date, updated_time, everything())
  filename <- gsub(" ","_",gsub(":","-",reports$updated))
  write_csv(reports, paste0("static/data/ins/reports/",filename, ".csv"))
}

all_reps <- list.files("static/data/ins/reports/", full.names = TRUE)
all_reps <- map(all_reps, read_csv) %>% bind_rows() %>%
  select(one_of(names(reports)))

write_csv(all_reps, "static/data/ins/col_reports.csv")

cases_html_table <- ins_tables[[2]]

n_cases <- reports$`Casos Confirmados en Colombia`
if(is.null(n_cases)){
  n_cases <- reports$`Casos Importados` +
    reports$`Casos Relacionados` +
    reports$`Casos en Estudio`
}

if(nrow(cases_html_table) < n_cases){
  # Try
  today <- as.character(Sys.Date())
  latest_local_case <- tail(list.files("static/data/ins/cases", full.names = TRUE),1)
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
