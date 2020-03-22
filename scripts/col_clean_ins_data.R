library(tidyverse)
library(geodata)
library(lubridate)



cases <- read_csv("static/data/ins/prep/ins_cases.csv",
                  col_types = cols(.default = "c"))

x <- cases %>% mutate(fecha = dmy(fecha))

xgeo <- geocode(x, col = "ciudad", "col_municipalities")

write_csv(xgeo, "static/data/ins/col_cases.csv")
