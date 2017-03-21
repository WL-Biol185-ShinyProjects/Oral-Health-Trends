library(tidyverse)
library(leaflet)
library(RColorBrewer)


states <- rgdal::readOGR("statedata.json", "OGRGeoJSON")
bins <- c(0, 50, 55, 60, 65, 70, 75, 80, 100)
pal <- colorBin("YlGnBu", domain = newtable.data_value$Data_Value, bins = bins)
newtable.data_value <- filter(newtable, Break_Out_Category == "None", Response == "Yes", Indicator == "Adults aged 18+ who have visited a dentist or dental clinic in the past year")

 labels <- sprintf(
   "People that visit the dentist",
  states$name, newtable.data_value$Data_Value
)

leaflet(data = states) %>% setView(lng=-100, lat= 40, zoom=4) %>%
  addTiles() %>%
  addPolygons(
  fillColor = ~pal(newtable.data_value$Data_Value), 
  weight = 2,
  color = "white",
  highlight= highlightOptions(
    weight = 5,
    color = "#666",
    dashArray = "",
    fillOpacity = 0.7,
    bringToFront = TRUE),
  label = labels,labels,
  labelOptions = labelOptions(
     style= list("font-weight" = "normal", padding = "3px 8px"),
     textsize = "15px",
     direction = "auto"
   )) %>%
  addLegend(pal = pal, values= ~newtable.data_value$Data_Value, opacity = 0.7, title= NULL, position= "bottomright"
  )


