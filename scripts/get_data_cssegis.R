library(tidyverse)
library(lubridate)


# Timeseries
url <- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Confirmed.csv"
conf0 <- read_csv(url)
write_csv(conf0, "data/csse/cases_timeseries.csv")
selectedCountries <- c("Peru", "Argentina", "Brazil",
                       #"Colombia",
                       "Bolivia", "Chile", "Ecuador")

conf <- conf0 %>%
  select(-`Province/State`, -Lat, -Long) %>%
  filter(`Country/Region` %in% selectedCountries) %>%
  pivot_longer(cols = matches("^\\d+\\/\\d+\\/\\d+$"), names_to = "fecha")

# Clean dates
con <- conf %>%
  mutate(fecha = mdy(fecha)) %>%
  filter(value > 0) %>%
  rename(country = `Country/Region`, confirmed = value)

colombia <- read_csv("data/csse/colombia_cases.csv") %>%
  mutate(country = "Colombia")

cases <- con %>%
  bind_rows(colombia) %>%
  group_by(country) %>%
  mutate(day = 1:n())

write_csv(cases, "data/csse/cases_countries.csv")


