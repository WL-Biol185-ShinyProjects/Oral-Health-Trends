library(ggplot2)
library(tidyverse)
library(dplyr)
install.packages("leaflet")
library(leaflet)

states <- geojsonio::geojson_read("json/us-states.geojson", what = "sp")
class(states)