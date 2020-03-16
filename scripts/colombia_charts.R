
library(tidyverse)
library(hgchmagic)
library(glue)

cases <- read_csv("data/cases_colombia_detail.csv")

cases_col <- read_csv("data/colombia_cases.csv")

n_cases <- nrow(cases)

# Casos confirmados
d <- cases %>%
  select(`Tipo contagio` = tipo_contagio) %>%
  count(`Tipo contagio`) %>% select(`Tipo contagio`, Total = n)
h <- hgch_treemap_CatNum(d, title = glue("{n_cases} casos confirmados"),
                      agg_text = "",
                      caption = "Fuente: INS. Gráficos http://datasketch.co")
h
filename <- "col_confirmados_tipo.html"
save_hgchmagic(h, filename, height = 100)
file.rename(filename, file.path("docs/viz", filename))


# Casos por grupo de edad
d <- cases %>%
  select(`Total` = age_group)
h <- hgch_bar_Cat(d, title = glue("Casos confirmados por edad"),
                  ver_label = "", hor_label = "",
                  agg_text = "",
                  colors = rep(c("#dc4444"),10),
                  caption = "Fuente: INS. Gráficos http://datasketch.co")
h
filename <- "col_confirmados_edad.html"
save_hgchmagic(h, filename, height = 100)
file.rename(filename, file.path("docs/viz", filename))

# Casos por departamento
d <- cases %>%
  select(Total = department)
h <- hgch_bar_Cat(d, title = glue("Casos confirmados por departamento"),
                  ver_label = "", hor_label = "",
                  orientation = "hor", sort = "desc",
                  label_wrap = 40,
                  agg_text = "",
                  colors = rep(c("#dc4444"),10),
                  caption = "Fuente: INS. Gráficos http://datasketch.co")
h
filename <- "col_confirmados_departamento.html"
save_hgchmagic(h, filename, height = 100)
file.rename(filename, file.path("docs/viz", filename))


# Casos acumulados por departamento
d <- cases %>% select(department,fecha) %>%
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

h <- hgch_area_CatCatNum(d3, graph_type = "stacked", agg = "sum",
                    title = "Casos acumulados por departamento",
                    ver_label = "", hor_label = "",
                    label_wrap = 40)
h
filename <- "col_confirmados_acu_departamento.html"
save_hgchmagic(h, filename, height = 100)
file.rename(filename, file.path("docs/viz", filename))


# Casos acumulados por sexo
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
                         label_wrap = 40)
h
filename <- "col_confirmados_acu_sexo.html"
save_hgchmagic(h, filename, height = 100)
file.rename(filename, file.path("docs/viz", filename))



