---
uid: colombia
dashboard:
- name: Confirmed cases since first report
  url: https://public.tableau.com/profile/john.alexis.guerra.g.mez#!/vizhome/time_series_19-covid-Confirmed/Confirmedcaseslatam?publish=yes
  type: Single visualization
  description: 'number of confirmed cases of #COVIDー19 in #Colombia compares with
    other countries of the region. We are starting worse than #Brazil, let''s hope
    we don''t follow their steps.'
  author: John Guerra
  author_link: https://twitter.com/duto_guerra
name: Colombia
datasources:
- uid: ins-col
  name: INS - Coronavirus en Colombia
  url: https://coronaviruscolombia.gov.co/Covid19/index.html
tools: []
datasets:
- col-ins-reports
- col-ins-cases
- col-ins-cases-municipio
reads: []
viz:
- uid: col-casos-sexo-acumulado
  name: Casos confirmados (acumulado) por sexo
- uid: col-casos-por-sexo
  name: Casos por sexo
- uid: col-casos-edad
  name: Casos por edad
- uid: col-casos-departamento-acumulado
  name: Casos confirmados (acumulado) por departamento
- uid: col-casos-departamento
  name: Casos confirmados por departamento
- uid: col-casos-por-atencion
  name: Casos por atencion
- uid: col-casos-mapa
  name: Mapa de casos por municipio
- uid: col-casos-departamento-acumulado-spline
  name: Casos confirmados (acumulado) por departamento
- uid: col-casos-por-tipo
  name: Casos por tipo
datasets_info:
- uid: col-ins-reports
  name: Casos de coronavirus en Colombia
- uid: col-ins-cases
  name: Casos de coronavirus en Colombia
- uid: col-ins-cases-municipio
  name: Casos de coronavirus en Colombia
---

