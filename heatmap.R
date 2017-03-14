library(tidyverse)
library(leaflet)

states <- rgdal::readOGR("statedata.json", "OGRGeoJSON")

leaflet(states) %>% setView(lng=-100, lat= 40, zoom=4) %>%
  addTiles() %>%
  addPolygons()
    

