---
uid: colombia
datasources:
- uid: ins-col
  name: INS - Coronavirus en Colombia
  url: https://coronaviruscolombia.gov.co/Covid19/index.html
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
tools: []
datasets:
- col-ins-casos-municipio-fecha
- col-ins-reportes
- col-ins-casos
- col-ins-casos-municipio
- col-ins-casos-departamento-fecha
- col-ins-casos-departamento
reads: []
viz:
- uid: col-casos-por-sexo
  name: Casos por sexo
- uid: col-casos-edad
  name: Casos por edad
- uid: col-casos-departamento
  name: Casos confirmados por departamento
- uid: col-casos-por-atencion
  name: Casos por atencion
- uid: col-casos-por-tipo
  name: Casos por tipo
datasets_info:
- uid: col-ins-casos-municipio-fecha
  name: Casos de coronavirus en Colombia por municipios
- uid: col-ins-reportes
  name: Reportes de casos de coronavirus en Colombia
- uid: col-ins-casos
  name: Casos de coronavirus en Colombia
- uid: col-ins-casos-municipio
  name: Casos de coronavirus en Colombia por municipios
- uid: col-ins-casos-departamento-fecha
  name: Reportes de casos de coronavirus en Colombia
- uid: col-ins-casos-departamento
  name: Reportes de casos de coronavirus en Colombia
type: scope
---

