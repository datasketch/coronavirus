---
uid: world
datasources:
- uid: financial-times
  name: 'Coronavirus tracked: the latest figures as the pandemic spreads'
  url: https://www.ft.com/coronavirus-latest
- uid: Alan Li
  name: COVID-19 Timeseries+Lat/Lon (Active)
  url: https://www.kaggle.com/lihyalan/2020-corona-virus-timeseries
- uid: jhu-ccse
  name: Novel Coronavirus (COVID-19) Cases Data
  url: https://data.humdata.org/dataset/novel-coronavirus-2019-ncov-cases
- uid: BNO news
  name: 'TIMELINE: Coronavirus epidemic'
  url: https://bnonews.com/index.php/2020/01/timeline-coronavirus-epidemic/
- uid: ecdc
  name: Distribución geográfica de los casos de COVID-19
  url: https://www.ecdc.europa.eu/en/publications-data/download-todays-data-geographic-distribution-covid-19-cases-worldwide
- uid: csse
  name: COVID-19 Data Repository by Johns Hopkins CSSE
  url: http://github.com/CSSEGISandData/COVID-19
- uid: world-meters
  name: COVID-19 CORONAVIRUS PANDEMIC
  url: https://www.worldometers.info/coronavirus/#countries
- uid: Devakumar kp
  name: COVID-19 Complete Dataset (Updated every 24hrs)
  url: https://www.kaggle.com/imdevskp/corona-virus-report
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
- name: Coronavirus COVID-19 Global Cases by the Center for Systems Science and Engineering
    (CSSE) at Johns Hopkins Univ
  url: https://coronavirus.jhu.edu/map.html
  type: Dashboard
- name: ' COVID-19 Global Cases by CSSE Johns Hopkins University'
  url: https://gisanddata.maps.arcgis.com/apps/opsdashboard/index.html#/bda7594740fd40299423467b48e9ecf6
  type: Dashboard
- name: Number of novel coronavirus (COVID-19) cases worldwide as of March 26, 2020,
    by country*
  url: https://www.statista.com/statistics/1043366/novel-coronavirus-2019ncov-cases-worldwide-by-country/
  type: Single visualization
- name: Coronavirus Disease (COVID-19) – Statistics and Research
  url: https://ourworldindata.org/coronavirus
  type: Dashboard
- name: 'COVID-19 #Coronavirus Data Pack'
  url: https://informationisbeautiful.net/visualizations/covid-19-coronavirus-infographic-datapack/
  type: Infographics
  author: Information is beautiful
- name: COVID-19 Current World Situation
  url: https://datastudio.google.com/embed/u/0/reporting/55c64c82-fdcf-44c0-ae91-b5f83b54b9d1
  type: Dashboard
  author: Mathias Leroy
  author_link: https://twitter.com/MathiasLeroy_
- name: COVID19 Live Interactive Dashboard (v2)
  url: https://www.gohkokhan.com/corona-virus-interactive-dashboard-tweaked/
  type: Dashboard
- name: 'Tracking coronavirus: Real-time visualizations'
  url: https://bnonews.com/index.php/2020/03/tracking-coronavirus-real-time-visualizations/
  type: Visualizations
  author: James Valles
- name: Coronavirus COVID-19 Global Cases by the Center for Systems Science and Engineering
    (CSSE) at Johns Hopkins University (JHU)
  url: https://www.arcgis.com/apps/opsdashboard/index.html#/bda7594740fd40299423467b48e9ecf6
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
  description: The medical director of a general medicine clinic created an emergency
    response guide for the pandemic emergency.
  date_published: '2020-03-25'
- name: Updated understanding of the outbreak of 2019 novel coronavirus (2019‐nCoV)
    in Wuhan, China
  url: https://onlinelibrary.wiley.com/doi/full/10.1002/jmv.25689?af=R
  description: To help health workers and the public recognize and deal with the 2019
    novel coronavirus quickly, effectively, and calmly with an updated understanding.
  date_published: '2020-01-29'
- name: The 1957 pandemic.
  url: https://twitter.com/NAChristakis/status/1238934000187707400
  description: Flu pandemics recur reliably but unpredictably every decade or so,
    and their extent and intensity varies.
  date_published: '2020-03-14'
- name: 'Coronavirus Disease 2019 (COVID‐19): What we know?'
  url: https://app.dimensions.ai/details/publication/pub.1125633404?search_text=%222019-nCoV%22%20OR%20%22COVID-19%22%20OR%20%E2%80%9CSARS-CoV-2%E2%80%9D%20OR%20%22HCoV-2019%22%20OR%20%22hcov%22%20OR%20%22NCOVID-19%22%20OR%20%20%22severe%20acute%20respiratory%20syndrome%20coronavirus%202%22%20OR%20%22severe%20acute%20respiratory%20syndrome%20corona%20virus%202%22%20OR%20((%22coronavirus%22%20%20OR%20%22corona%20virus%22)%20AND%20(Wuhan%20OR%20China%20OR%20novel))&search_type=kws&search_field=full_search&and_facet_year=2020
  description: In late December 2019, a cluster of unexplained pneumonia cases has
    been reported in Wuhan, China.
  date_published: '2020-03-01'
- name: Preliminary estimation of the basic reproduction number of novel coronavirus
    (2019-nCoV) in China, from 2019 to 2020
  url: https://www.sciencedirect.com/science/article/pii/S1201971220300539
  description: A data-driven analysis in the early phase of the outbreak.
  date_published: '2020-03-01'
- name: 'Coronavirus tracked: the latest figures as the pandemic spreads'
  url: https://www.ft.com/content/a26fbf7e-48f8-11ea-aeb3-955839e06441
  description: The countries affected, the number of deaths and the economic impact.
  date_updated: '2020-03-21'
- name: What I don't know as a computational systems bioligist
  url: https://twitter.com/BallouxFrancois/status/1238837158007447558
  description: '"I should be qualified to comment on the covid-19 pandemic. (...)
    In this thread, I will summarise what I believe I (don''t) know."'
- name: A novel coronavirus outbreak of global health concern
  url: https://www.thelancet.com/journals/lancet/article/PIIS0140-6736(20)30185-9/fulltext#tbl1
  description: In December, 2019, Wuhan, Hubei province, China, became the centre
    of an outbreak of pneumonia of unknown cause.
  date_published: '2020-01-24'
- name: Early Transmissibility Assessment of a Novel Coronavirus in Wuhan, China
  url: https://papers.ssrn.com/sol3/papers.cfm?abstract_id=3524675
  description: '"In this short analysis, we combine publicly available cumulative
    case data from the ongoing outbreak with phenomenological modeling methods".'
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

