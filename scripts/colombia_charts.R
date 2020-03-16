library(tidyverse)
library(hgchmagic)
library(glue)

cases <- read_csv("data/cases_colombia_detail.csv")
cases_col <- read_csv("data/colombia_cases.csv")
n_cases <- nrow(cases)


thm <- hc_theme(chart = list(backgroundColor = NULL),
                colors = c('#a0f0da','#f03f4e', '#17a398'),
                title = list(style = list(color = '#3a4454',
                                          fontFamily = "Roboto Condensed",
                                          fontSize = "20px",
                                          fontWeight = "bold")),
                legend = list(itemStyle = list(fontFamily = 'Roboto Condensed',
                                               color = "#3a4454")),
                tooltip = list(style = list(fontFamily = "Roboto Condensed",
                                            color = "#3a4454")),
                credits = list(style = list(fontFamily = "Roboto Condensed",
                                            fontSize = "12px",
                                            color = "#a9b8c9")))


# Casos género
d <- cases %>%
  select(`Sexo` = sexo) %>%
  count(Sexo) %>% select(Sexo, Total = n)
d$Sexo[d$Sexo == "Masculino"] <- "Hombre"
d$Sexo[d$Sexo == "Femenino"] <- "Mujere"

h <- hgch_treemap_CatNum(d, title = glue("{n_cases} casos confirmados"),
                         agg_text = "",
                         caption = "Fuente: INS. Gráficos http://datasketch.co",
                         colors = c('#f03f4e','#a0f0da')) %>%
  hc_plotOptions(
    treemap = list(dataLabels = list(style = list(fontFamily = "Roboto Condensed",
                                                  fontSize = "16px",
                                                  align = "right",
                                                  textOutline = "none",
                                                  fontWeight = "regular"),
                                     allowHTML = TRUE,
                                     format = "<b>{point.name}s</b><br>{point.value}"))) %>%
  hc_add_theme(thm)
h

filename <- "col_confirmados_sexo.html"
save_hgchmagic(h, filename, height = 100)
file.rename(filename, file.path("docs/viz", filename))




# Casos confirmados
d <- cases %>%
  select(`Tipo contagio` = tipo_contagio) %>%
  count(`Tipo contagio`) %>% select(`Tipo contagio`, Total = n)

h <- hgch_treemap_CatNum(d, title = glue("{n_cases} casos confirmados"),
                         agg_text = "",
                         caption = "Fuente: INS. Gráficos http://datasketch.co",
                         colors = c('#f03f4e','#a0f0da')) %>%
  hc_plotOptions(
    treemap = list(dataLabels = list(style = list(fontFamily = "Roboto Condensed",
                                                  fontSize = "16px",
                                                  align = "right",
                                                  textOutline = "none",
                                                  fontWeight = "regular"),
                                     allowHTML = TRUE,
                                     format = "<b>{point.name}s</b><br>{point.value}"))) %>%
  hc_add_theme(thm)
h

filename <- "col_confirmados_tipo.html"
save_hgchmagic(h, filename, height = 100)
file.rename(filename, file.path("docs/viz", filename))


# Casos por grupo de edad

thm2 <- hc_theme_merge(thm, hc_theme(chart = list(backgroundColor = NULL),
                                     colors = c('#a0f0da', '#ff9d28')))
d <- cases %>%
  select(`Total` = age_group)
h <- hgch_bar_Cat(d, title = glue("Casos confirmados por edad"),
                  ver_label = "", hor_label = "",
                  agg_text = "",
                  colors = c('#f03f4e','#a0f0da'),
                  caption = "Fuente: INS. Gráficos http://datasketch.co") %>%
  hc_xAxis(tickWidth = 0,
           labels = list(style = list( fontSize = "13px",
                                        fontFamily = "Roboto Condensed",
                                        color = "#3a4454"),
                         format = "{value} años")
  ) %>%
  hc_yAxis(gridLineWidth = 1,
           gridLineDashStyle = "dot",
           gridLineColor = "#c7d7e5",
           title = list(text = "Número de casos",
                        style = list(color = '#3a4454',
                                     fontSize = "16px",
                                     fontFamily = "Roboto Condensed")),
           labels = list(style = list( color = '#3a4454',
                                        fontSize = "13px",
                                        fontFamily = "Roboto Condensed"))) %>%
  hc_add_theme(thm2)
h
filename <- "col_confirmados_edad.html"
save_hgchmagic(h, filename, height = 100)
file.rename(filename, file.path("docs/viz", filename))

# Casos por departamento

thm3 <- hc_theme_merge(thm, hc_theme(chart = list(backgroundColor = NULL),
                                     colors = c('#ff9d28', '#ff9d28')))
d <- cases %>%
  select(Total = department) %>%
  mutate(Total = stringr::str_to_title(Total, locale = "es"))
h <- hgch_bar_Cat(d, title = glue("Casos confirmados por departamento"),
                  ver_label = "", hor_label = "",
                  orientation = "hor", sort = "desc",
                  label_wrap = 40,
                  agg_text = "",
                  caption = "Fuente: INS. Gráficos http://datasketch.co") %>%
  hc_xAxis(tickWidth = 0,
           lineWidth = 0,
           labels = list( style = list( fontSize = "13px",
                                        fontFamily = "Roboto Condensed",
                                        color = "#3a4454"))
  ) %>%
  hc_yAxis(gridLineWidth = 1,
           gridLineDashStyle = "dot",
           gridLineColor = "#c7d7e5",
           title = list(text = "Número de casos",
                        style = list(color = '#3a4454',
                                     fontSize = "16px",
                                     fontFamily = "Roboto Condensed")),
           labels = list( style = list( color = '#3a4454',
                                        fontSize = "13px",
                                        fontFamily = "Roboto Condensed"))) %>%
  hc_add_theme(thm3)
h
filename <- "col_confirmados_departamento.html"
save_hgchmagic(h, filename, height = 100)
file.rename(filename, file.path("docs/viz", filename))


thm4 <- hc_theme_merge(thm, hc_theme(chart = list(backgroundColor = NULL),
                                     colors = c('#f03f4e',
                                                '#ff9d28', '#ffdd4c', '#c2f9bb',
                                                '#a0f0da', '#17a398', '#133c55',
                                                '#93bedf', '#62356d','#af2276')))

# Casos acumulados por departamento

d0 <- cases %>% select(department,fecha)

other_threshold <- 3
other_cats <- d0 %>% group_by(department) %>%
  summarise(total_cases = n()) %>%
  filter(total_cases < other_threshold) %>%
  pull(department)
dother <- d0 %>%
  mutate(department = ifelse(department %in% other_cats, "OTROS", department))

d <- dother %>%
  mutate(cases = 1, cumcases = cumsum(cases)) %>%
  select(department, fecha, cases = cases, cumcases = cumcases)


dates <- full_seq(d$fecha, 1)
d1 <- d %>% group_by(department, fecha) %>%
  summarise(cases = sum(cases)) %>%
  ungroup()
d2 <- d1 %>%
  group_by(department) %>%
  mutate(cumcases = cumsum(cases)) %>% ungroup() %>%
  select(-cases)
d3 <- d2 %>%
  complete(fecha = dates, department, fill = list(cumcases = NA)) %>%
  group_by(department) %>%
  fill(cumcases) %>%
  ungroup() %>%
  mutate(cumcases = ifelse(is.na(cumcases), 0, cumcases)) %>%
  select(2,1,Casos = cumcases)

d4 <- d3 %>%
  mutate(department = stringr::str_to_title(department, locale = "es"))



h <- hgch_area_CatCatNum(d4, graph_type = "stacked", agg = "sum",
                         title = "Casos acumulados por departamento",
                         ver_label = "", hor_label = "",
                         label_wrap = 40, spline = TRUE) %>%
  hc_xAxis(tickWidth = 0,
           labels = list( style = list( fontSize = "13px",
                                        fontFamily = "Roboto Condensed",
                                        color = "#3a4454"))
  ) %>%
  hc_yAxis(gridLineWidth = 1,
           gridLineDashStyle = "dot",
           gridLineColor = "#c7d7e5",
           title = list(text = "Número de casos",
                        style = list(color = '#3a4454',
                                     fontSize = "16px",
                                     fontFamily = "Roboto Condensed")),
           labels = list( style = list( color = '#3a4454',
                                        fontSize = "13px",
                                        fontFamily = "Roboto Condensed"))) %>%
  hc_plotOptions(
    areaspline = list(lineWidth = 2.5,
                      marker = list(radius = 3.5,
                                    symbol = "circle"))
  ) %>%
  hc_add_theme(thm4)
h
filename <- "col_confirmados_acu_departamento.html"
save_hgchmagic(h, filename, height = 100)
file.rename(filename, file.path("docs/viz", filename))


# Casos acumulados por sexo

thm5 <- hc_theme_merge(thm, hc_theme(chart = list(backgroundColor = NULL),
                                     colors = c('#a0f0da', '#f03f4e')))
d <- cases %>% select(sexo,fecha) %>%
  mutate(cases = 1, cumcases = cumsum(cases)) %>%
  select(sexo, fecha, cases = cases, cumcases = cumcases)
dates <- full_seq(d$fecha, 1)
d1 <- d %>% group_by(sexo, fecha) %>%
  summarise(cases = sum(cases)) %>%
  ungroup()
d2 <- d1 %>%
  group_by(sexo) %>%
  mutate(cumcases = cumsum(cases)) %>% ungroup() %>%
  select(-cases)
d3 <- d2 %>%
  complete(fecha = dates, sexo, fill = list(cumcases = NA)) %>%
  group_by(sexo) %>%
  fill(cumcases) %>%
  ungroup() %>%
  mutate(cumcases = ifelse(is.na(cumcases), 0, cumcases)) %>%
  select(2,1,Casos = cumcases)
h <- hgch_area_CatCatNum(d3, graph_type = "stacked",
                         colors = c("#45dcdc", "#dcdc45"),
                         title = "Casos acumulados por sexo",
                         ver_label = "", hor_label = "",
                         agg_text = "Total",
                         label_wrap = 40, spline = TRUE) %>%
  hc_xAxis(tickWidth = 0,
           labels = list( style = list( fontSize = "13px",
                                        fontFamily = "Roboto Condensed",
                                        color = "#3a4454"))
  ) %>%
  hc_yAxis(gridLineWidth = 1,
           gridLineDashStyle = "dot",
           gridLineColor = "#c7d7e5",
           title = list(text = "Número de casos",
                        style = list(color = '#3a4454',
                                     fontSize = "16px",
                                     fontFamily = "Roboto Condensed")),
           labels = list(style = list(color = '#3a4454',
                                      fontSize = "13px",
                                      fontFamily = "Roboto Condensed"))) %>%
  hc_plotOptions(
    areaspline = list(lineWidth = 2.5,
                      fillOpacity = 1,
                      marker = list(radius = 3.5,
                                    symbol = "circle"))
  ) %>%
  hc_add_theme(thm5)
h
filename <- "col_confirmados_acu_sexo.html"
save_hgchmagic(h, filename, height = 100)
file.rename(filename, file.path("docs/viz", filename))



