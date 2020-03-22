library(tidyverse)
library(lubridate)


# Timeseries
url <- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Confirmed.csv"
conf_cases <- read_csv(url)
write_csv(conf_cases, "static/data/csse/cases_timeseries.csv")

# selectedCountries <- c("Peru", "Argentina", "Brazil",
#                        "Colombia",
#                        "Bolivia", "Chile", "Ecuador")

csse_cases <- read_csv("static/data/csse/cases_timeseries.csv")

conf_cases <- csse_cases %>%
  select(-`Province/State`, -Lat, -Long) %>%
  #filter(`Country/Region` %in% selectedCountries) %>%
  pivot_longer(cols = matches("^\\d+\\/\\d+\\/\\d+$"), names_to = "date") %>%
  group_by(`Country/Region`, date) %>%
  summarise(value = sum(value))

# Clean dates
conf_cases <- conf_cases %>%
  mutate(date = mdy(date)) %>%
  filter(value > 0) %>%
  rename(country = `Country/Region`, confirmed = value)

# colombia <- read_csv("data/csse/colombia_cases.csv") %>%
#   mutate(country = "Colombia")

conf_cases <- conf_cases %>%
  # bind_rows(colombia) %>%
  group_by(country) %>%
  mutate(day = 1:n()) %>%
  ungroup()
## Add isocode
library(geodata)
countries <- conf_cases %>% select(country) %>% distinct()
countries_with_isocode <- geocode(countries, col = "country", "world_countries")


conf_cases_iso <- left_join(conf_cases, countries_with_isocode) %>%
  select(-name, -name_long)
write_csv(conf_cases_iso, "static/data/csse/cases_countries.csv")

# Trnaslations
translations <- read_csv("static/data/helpers/country-names-translations.csv")

countries_trans <- countries_with_isocode %>%
  left_join(translations, by = c(id = "ISOalpha3"))

conf_cases_trans <- conf_cases %>% left_join(countries_trans)

write_csv(conf_cases_trans, "static/data/csse/cases_countries_all_langs.csv")

conf_cases_es <- conf_cases_trans %>%
  select(country = es, isocode = id, date, day, confirmed, lat, lon)
write_csv(conf_cases_es, "static/data/csse/cases_countries_all_langs.csv")




