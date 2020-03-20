library(tidyverse)
library(geodata)
library(lubridate)

cases <- read_csv("static/data/ins/ins_web.csv", col_types = cols(.default = "c"))

# age_group_vars <- names(cases)[grepl("[0-9]", names(cases))]

# Clean data
# x <- pivot_longer(cases, all_of(age_group_vars),
#                   names_to = "age_group", values_drop_na = TRUE) %>% select(-value)
# x <- x %>% pivot_longer(c("Masculino", "Femenino"),
#                   names_to = "sexo", values_drop_na = TRUE) %>% select(-value)
# x <- x %>% pivot_longer(c("Importado", "Asociado"),
#                   names_to = "tipo_contagio", values_drop_na = TRUE) %>% select(-value)
# Seems like the data is already in long format
x <- cases %>% mutate(fecha = dmy(fecha))

x$ciudad[x$ciudad == "Meta"] <- "Villavicencio"

xgeo <- geocode(x, col = "ciudad", "col_municipalities")

write_csv(xgeo, "static/data/ins/cases_colombia_detail.csv")
