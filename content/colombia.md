---
uid: colombia
datasources:
- uid: ins-col
  name: INS - Coronavirus en Colombia
  url: https://coronaviruscolombia.gov.co/Covid19/index.html
- uid: el-tiempo
  name: Casos actualizados de Coronavirus en Colombia
  url: https://www.eltiempo.com/datos/coronavirus-en-colombia-casos-actualizados-y-confirmados-471650
- uid: el-colombiano
  name: Coronavirus en Antioquia
  url: https://www.elcolombiano.com/coronavirus-en-colombia-contra-el-miedo
dashboard:
- name: Covid19 en Colombia
  url: http://www.genetica.unal.edu.co/gibbs/index.php?id=covid19-en-colombia
  type: Visualizations
- name: Número de camas hospitalarias / UCI en Colombia
  url: https://app.powerbi.com/view?r=eyJrIjoiNDc5YzUyMzctZTI1MS00NzgxLTkxYTAtODY0ZTM4MDk5ZWFjIiwidCI6ImZjNTMxMjM3LTQzYzYtNDRkZS1hMWU4LWQzYmY2ZGM0MzZlMSIsImMiOjR9
  type: Dashboard
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
reads:
- name: COVID-19 I El cuidado ahora es colectivo
  url: https://cerosetenta.uniandes.edu.co/el-cuidado-ahora-es-colectivo/
  description: Esta es una coyuntura que demuestra que estamos pensando la salud tal
    vez de una forma menos antropocentrista.
  date_published: '2020-03-18'
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

