library(shiny)


states <- geojsonio::geojson_read("json/us-states.geojson", what = "sp")
class(states)