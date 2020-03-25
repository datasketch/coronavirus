---
uid: world
dashboard:
- name: Coronavirus Tracking
  url: https://www.domo.com/coronavirus-tracking
  type: Dashboard
  author: Domo
- name: Coronavirus Map
  url: https://coronavirusdatamap.com/
  type: Dashboard
- name: ' COVID-19 Global Cases by CSSE Johns Hopkins University'
  url: https://gisanddata.maps.arcgis.com/apps/opsdashboard/index.html#/bda7594740fd40299423467b48e9ecf6
  type: Dashboard
- name: Coronavirus Disease (COVID-19) – Statistics and Research
  url: https://ourworldindata.org/coronavirus
  type: Dashboard
- name: COVID-19 Current World Situation
  url: https://datastudio.google.com/embed/u/0/reporting/55c64c82-fdcf-44c0-ae91-b5f83b54b9d1
  type: Dashboard
  author: Mathias Leroy
  author_link: https://twitter.com/MathiasLeroy_
- name: COVID19 Live Interactive Dashboard (v2)
  url: https://www.gohkokhan.com/corona-virus-interactive-dashboard-tweaked/
  type: Dashboard
- name: Real time COVID-19 Coronavirus Pandemic
  url: https://www.worldometers.info/coronavirus/
  type: Dashboard
name: World
datasources:
- uid: csse
  name: COVID-19 Data Repository by Johns Hopkins CSSE
  url: http://github.com/CSSEGISandData/COVID-19
tools: []
datasets:
- tidy_csse_es
- cases
- tidy_csse_en
- tidy_csse_langs
- tidy_csse
- tidy_csse_pt
reads:
- name: The 1957 pandemic.
  url: https://twitter.com/NAChristakis/status/1238934000187707400
  date_published: '2020-03-14'
- name: 'Coronavirus tracked: the latest figures as the pandemic spreads'
  url: https://www.ft.com/content/a26fbf7e-48f8-11ea-aeb3-955839e06441
  description: https://twitter.com/jburnmurdoch/status/1238913530973339648?s=09
  date_updated: '2020-03-21'
- name: What I don't know as a computational systems bioligist
  url: https://twitter.com/BallouxFrancois/status/1238837158007447558
viz: []
datasets_info:
- uid: tidy_csse_es
  name: Datos mundiales de coronavirus (confirmados, muertos, recuperados)
- uid: cases
  name: Novel Coronavirus (COVID-19) Situation
- uid: tidy_csse_en
  name: Tidy world coronavirus cases (confirmed, death, recovered) with country codes
- uid: tidy_csse_langs
  name: Tidy world coronavirus cases (confirmed, death, recovered) with country names
    in multiple languages
- uid: tidy_csse
  name: Tidy world coronavirus cases (confirmed, death, recovered) with country codes
- uid: tidy_csse_pt
  name: Dados mundiais de coronavirus
---
