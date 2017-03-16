library(tidyverse)
library(leaflet)
library(RColorBrewer)


states <- rgdal::readOGR("statedata.json", "OGRGeoJSON")
bins <- c(0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100)
pal <- colorBin("Spectral", domain = newtable$Data_Value, bins = bins)
newtable.data_value <- filter(newtable, Break_Out_Category == "None", Response == "Yes", Indicator == "Adults aged 18+ who have visited a dentist or dental clinic in the past year")
read.table(newtable.data_value)

leaflet(states) %>% setView(lng=-100, lat= 40, zoom=4) %>%
  addTiles() 
  addPolygons(
  fillColor = ~pal(newtable.data_value$Data_Value)
  )
    

