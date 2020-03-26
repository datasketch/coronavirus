---
uid: world
datasources:
- uid: financial-times
  name: 'Coronavirus tracked: the latest figures as the pandemic spreads'
  url: https://www.ft.com/coronavirus-latest
- uid: ecdc
  name: Distribución geográfica de los casos de COVID-19
  url: https://www.ecdc.europa.eu/en/publications-data/download-todays-data-geographic-distribution-covid-19-cases-worldwide
- uid: csse
  name: COVID-19 Data Repository by Johns Hopkins CSSE
  url: http://github.com/CSSEGISandData/COVID-19
- uid: world-meters
  name: COVID-19 CORONAVIRUS PANDEMIC
  url: https://www.worldometers.info/coronavirus/#countries
- uid: who
  name: Novel Coronavirus (COVID-19) Situation
  url: https://experience.arcgis.com/experience/685d0ace521648f8a5beeeee1b9125cd
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
tools: []
datasets:
- tidy-csse-es
- tidy-csse-en
- tidy-csse-langs
- tidy-csse
- tidy-csse-pt
reads:
- name: 'Seeking Evidence-Based Covid-19 Preparedness: A FEMA Framework for Clinic
    Management'
  url: https://catalyst.nejm.org/doi/full/10.1056/CAT.20.0079
  date_published: '2020-03-25'
- name: The 1957 pandemic.
  url: https://twitter.com/NAChristakis/status/1238934000187707400
  date_published: '2020-03-14'
- name: 'Coronavirus tracked: the latest figures as the pandemic spreads'
  url: https://www.ft.com/content/a26fbf7e-48f8-11ea-aeb3-955839e06441
  description: https://twitter.com/jburnmurdoch/status/1238913530973339648?s=09
  date_updated: '2020-03-21'
- name: What I don't know as a computational systems bioligist
  url: https://twitter.com/BallouxFrancois/status/1238837158007447558
- name: A novel coronavirus outbreak of global health concern
  url: https://www.thelancet.com/journals/lancet/article/PIIS0140-6736(20)30185-9/fulltext#tbl1
  date_published: '2020-01-24'
- name: Early Transmissibility Assessment of a Novel Coronavirus in Wuhan, China
  url: https://papers.ssrn.com/sol3/papers.cfm?abstract_id=3524675
  date_published: '2020-01-24'
viz: []
datasets_info:
- uid: tidy-csse-es
  name: Datos mundiales de coronavirus (confirmados, muertos, recuperados)
- uid: tidy-csse-en
  name: Tidy world coronavirus cases (confirmed, death, recovered) with country codes
- uid: tidy-csse-langs
  name: Tidy world coronavirus cases (confirmed, death, recovered) with country names
    in multiple languages
- uid: tidy-csse
  name: Tidy world coronavirus cases (confirmed, death, recovered) with country codes
- uid: tidy-csse-pt
  name: Dados mundiais de coronavirus
type: scope
---

