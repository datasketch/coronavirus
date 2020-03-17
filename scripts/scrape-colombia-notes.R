library(RSelenium)
appURL <- "http://infogram.com/3a4c9dd3-fbb8-4f59-8d82-eb1edc01604b"
RSelenium::startServer()
remDr <- remoteDriver()
remDr$open()
remDr$navigate(appURL)
tblSource <- remDr$executeScript("return tbls[0].outerHTML;")[[1]]
readHTMLTable(tblSource)




library(rvest)
library(tidyverse)

url <- "data/web/ins.html"
css <- "igc-table __fixed __dynamic"

h <- read_html(url) %>%
  rvest::html_table()
table <- h[[2]]
#html_nodes(css = css)



library(rvest)

library(tidyverse)

# Reportes página

url <- "http://www.ins.gov.co/Noticias/Paginas/Coronavirus.aspx"

h <- read_html(url)

scripts <- h %>%
  html_nodes("script")
script_ids <- scripts %>%
  html_attr("id")

infogram <- scripts[[grep("infogram", script_ids)]]
infogram_id <- infogram %>% html_attr("id")

infogram_url <- paste0("http://infogram.com/",
                       gsub("infogram_0_", "", infogram_id, fixed = TRUE)
)

inf <- read_html(infogram_url)


tabs <- inf %>% html_nodes(css = ".__dynamic")


x %>% html_attr("src")

tables <- read_csv("data/colombia/reportes.csv")

tabs <- transpose(tables)

map(tabs, function(x){
  #x <- tabs[[2]]
  message(x$url)
  tmp <- x$url %>%
    read_html %>%
    html_nodes("table")
  data <- html_table(tmp[[x$position]])
  if(is.na(x$ctypes)){
    ctypes <- NULL
  }else{
    ctypes <- strsplit(x$ctypes, "-")[[1]]
  }
  if(x$new_dic){
    dd <- make_dic(data, ctypes)
    data <- dd$data
    write_csv(dd$dic, paste0("data/", x$id,"-",mop::create_slug(x$title), ".dic.csv"))
  }else{
    #dic <- read_csv("")
    #names(data) <-
  }
  write_csv(data, paste0("data/", x$id, "-", mop::create_slug(x$title), ".csv"))

})

