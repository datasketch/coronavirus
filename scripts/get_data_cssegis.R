library(tidyverse)
library(lubridate)


# Timeseries
url <- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Confirmed.csv"
confirmed_cases <- read_csv(url)
write_csv(confirmed_cases, "data/csse/cases_timeseries.csv")
selectedCountries <- c("Peru", "Argentina", "Brazil",
                       "Colombia",
                       "Bolivia", "Chile", "Ecuador")

confirmed_cases <- confirmed_cases %>%
  select(-`Province/State`, -Lat, -Long) %>%
  filter(`Country/Region` %in% selectedCountries) %>%
  pivot_longer(cols = matches("^\\d+\\/\\d+\\/\\d+$"), names_to = "fecha")

# Clean dates
confirmed_cases <- confirmed_cases %>%
  mutate(fecha = mdy(fecha)) %>%
  filter(value > 0) %>%
  rename(country = `Country/Region`, confirmed = value)

# colombia <- read_csv("data/csse/colombia_cases.csv") %>%
#   mutate(country = "Colombia")

confirmed_cases <- confirmed_cases %>%
  # bind_rows(colombia) %>%
  group_by(country) %>%
  mutate(day = 1:n())

write_csv(confirmed_cases, "data/csse/cases_countries.csv")


