library(tidyverse)
library(glue)
library(airtabler)
dotenv::load_dot_env()

tables <- c("datasets", "viz", "datasources", "dashboards",
            "reads","tools","scopes","tags")
db <- airtable(
  base = Sys.getenv("AIRTABLE_BASE"),
  tables = tables)

dfs <- map(tables, function(x){
  db[[x]]$select_all()
}) %>% set_names(tables)


# Datasets
datasets0 <- dfs[["datasets"]] %>% filter(!is.na(uid)) %>%
  filter(status == "Published")
# Dataources
datasources0 <- dfs[["datasources"]] %>% filter(!is.na(uid))
# Viz
viz0 <- dfs[["viz"]] %>% filter(!is.na(uid)) %>%
  filter(status == "Published")
# Scopes
scopes0 <- dfs[["scopes"]] %>% filter(!is.na(uid))
# Datasources
datasources0 <- dfs[["datasources"]] %>% filter(!is.na(uid))
# Dashboards
dashboards0 <- dfs[["dashboards"]] %>% filter(!is.na(name))
# Reads
reads0 <- dfs[["reads"]] %>% filter(!is.na(name))
# Tools
tools0 <- dfs[["tools"]] %>% filter(!is.na(name))


# Datasets
scopes_min <- scopes0 %>% select(id, uid, name)
datasets <- datasets0
datasets$scope <- map_chr(datasets0$scope, function(x){
  filter(scopes_min, id == x) %>% pull(uid)
})
datasets$scope_info <- map(datasets0$scope, function(x){
  filter(scopes_min, id == x) %>% select(-id)
})
datasources_min <- datasources0 %>% select(id, uid, name, url, type)
datasets$datasource <- map_chr(datasets0$datasource, function(x){
  filter(datasources_min, id == x) %>% pull(uid)
})
datasets$datasource_info <- map(datasets0$datasource, function(x){
  filter(datasources_min, id == x) %>% select(-id)
})
viz_min <- viz0 %>% select(id, uid, name)
datasets$viz <- map(datasets0$viz, function(x){
  filter(viz_min, id %in% x) %>% select(-id)
})
datasets <- datasets %>% select(-id, -createdTime)
jsonlite::write_json(datasets, "data/datasets.json", auto_unbox = TRUE)

# Viz
scopes_min <- scopes0 %>% select(id, uid, name)
viz <- viz0
viz$scope <- map_chr(viz0$scope, function(x){
  filter(scopes_min, id == x) %>% pull(uid)
})
viz$scope_info <- map(viz0$scope, function(x){
  filter(scopes_min, id == x) %>% select(-id)
})
datasets_min <- datasets0 %>% select(id, uid, name, path)
viz$dataset <- map(viz0$dataset, function(x){
  filter(datasets_min, id %in% x) %>% pull(uid)
})
viz$dataset_info <- map(viz0$dataset, function(x){
  filter(datasets_min, id %in% x) %>% select(-id)
})
viz$recommended_viz <- map(viz0$recommended_viz, function(x){
  filter(viz, id %in% x) %>% select(uid, name, scope)
})
viz <- viz %>% select(-id, -createdTime, -viz_fun, -viz_params)
jsonlite::write_json(viz, "data/viz.json", auto_unbox = TRUE)

# Scopes
datasets_min <- datasets0 %>% select(id, uid, name)
scopes <- scopes0 %>% select(-events)
scopes$datasets <- map(scopes0$dataset, function(x){
  filter(datasets_min, id %in% x) %>% pull(uid)
})
scopes$datasets_info <- map(scopes0$dataset, function(x){
  filter(datasets_min, id %in% x) %>% select(-id)
})
viz_min <- viz0 %>% select(id, uid, name)
scopes$viz <- map(scopes0$viz, function(x){
  filter(viz_min, id %in% x) %>% select(-id)
})
datasources_min <- datasources0 %>% select(id, uid, name, url)
scopes$datasources <- map(scopes0$datasources, function(x){
  filter(datasources_min, id %in% x) %>% select(-id)
})
dashboards_min <- dashboards0 %>%
  select(id, name, url, type, description,
         author, author_link)
scopes$dashboard <- map(scopes0$dashboard, function(x){
  filter(dashboards_min, id %in% x) %>% select(-id)
})
reads_min <- reads0 %>% select(id, name, url, description,
                               date_published, date_updated)
scopes$reads <- map(scopes0$reads, function(x){
  filter(reads_min, id %in% x) %>% select(-id)
})
tools_min <- tools0 %>% select(id, name, url, description,
                               author, author_link)
scopes$tools <- map(scopes0$reads, function(x){
  filter(tools_min, id %in% x) %>% select(-id)
})
scopes <- scopes %>%
  select(-id, -createdTime)

scopes_no_empty <- scopes %>%
  mutate(
    with_dashboard = map_lgl(dashboard, ~ nrow(.) > 0),
    with_datasources = map_lgl(datasources, ~ nrow(.) > 0),
    with_dataset = map_lgl(datasets_info, ~ nrow(.) > 0),
    with_viz = map_lgl(viz, ~ nrow(.) > 0),
    with_info = with_dashboard | with_datasources | with_dataset | with_viz
  ) %>%
  filter(with_info) %>%
  select(-starts_with("with_"))
jsonlite::write_json(scopes0$uid, "data/all-scopes.json")
jsonlite::write_json(scopes_no_empty, "data/scopes.json", auto_unbox = TRUE)


