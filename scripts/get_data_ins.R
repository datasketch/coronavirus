library(tidyverse)
library(googlesheets4)
library(lubridate)

dotenv::load_dot_env()
sheets_deauth()
# INS
# gsheet_ins <- Sys.getenv("GSHEET_URL_INS")
# tabs <- sheets_sheets(gsheet_ins)
#
# tests <- read_sheet(gsheet_ins, sheet = "tests")
# colombia_cases <- tests %>% select(fecha = informe, confirmed = positivas)
# write_csv(colombia_cases, "data/colombia_cases.csv")

# cases_tabs <- tabs[grepl("rep_*[^v]*$", tabs)]
# #latest <- sort(tabs[grepl("rep_*[^v]*$", tabs)], decreasing = TRUE)[1]
# latest <- cases_tabs[1]
# message("\nLatest: ", latest)
#
# cases <- read_sheet(gsheet_ins, sheet = latest, skip = 1,
#                     col_types = "???????????????????")

### Load local cases
# latest <- list.files("data/ins", full.names = TRUE)
cases <- read_csv("data/ins/ins_web.csv", col_types = cols(.default = "c"))
names(cases)

age_group_vars <- names(cases)[grepl("[0-9]", names(cases))]

# Clean data
x <- pivot_longer(cases, all_of(age_group_vars),
                  names_to = "age_group", values_drop_na = TRUE) %>% select(-value)
x <- x %>% pivot_longer(c("Masculino", "Femenino"),
                  names_to = "sexo", values_drop_na = TRUE) %>% select(-value)
x <- x %>% pivot_longer(c("Importado", "Asociado"),
                  names_to = "tipo_contagio", values_drop_na = TRUE) %>% select(-value)
x <- x %>% mutate(fecha = dmy(fecha))

library(geodata)

x$ciudad[x$ciudad == "Meta"] <- "Villavicencio"

xgeo <- geocode(x, col = "ciudad", "col_municipalities")

write_csv(xgeo, "data/ins/cases_colombia_detail.csv")






