library(tidyverse)
library(geodata)
library(lubridate)
library(vctrs)

cases <- read_csv("static/data/ins/prep/ins_cases.csv",
                  col_types = cols(.default = "c"))

x <- cases %>%
  mutate(fecha2 = mdy(fecha)) %>%
  mutate(fecha3 = ifelse(is.na(fecha2), dmy(fecha), fecha2)) %>%
  mutate(fecha4 = as.character(new_date(fecha3))) %>%
  mutate(fecha = fecha4) %>%
  select(-fecha2, -fecha3, -fecha4)
xgeo <- geodata::geocode(x, col = "ciudad", "col_municipalities")

write_csv(xgeo, "static/data/ins/col_cases.csv")
