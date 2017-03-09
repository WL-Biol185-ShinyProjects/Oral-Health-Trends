library(ggplot2)
library(tidyverse)
library(dplyr)
install.packages("leaflet")
library(leaflet)

leaflet() %>% setView(lng = -79.442778, lat = 37.783889, zoom = 12) %>% addTiles()

