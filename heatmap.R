library(tidyverse)
library(leaflet)
library(RColorBrewer)
library(htmltools)

states <- rgdal::readOGR("statedata.json", "OGRGeoJSON")
bins <- c(0, 50, 55, 60, 65, 70, 75, 80, 100)
pal <- colorBin("YlGnBu", domain = newtable.data_value$Data_Value, bins = bins)
newtable.data_value <- filter(newtable, Break_Out_Category == "None", Response == "Yes", Indicator == "Adults aged 18+ who have visited a dentist or dental clinic in the past year")

joinedTable <- left_join(states@data, filter(newtable.data_value, Year == 2014), c("NAME" = "LocationDesc"))
states@data <- joinedTable

labels <- sprintf(
  "<strong>%s</strong><br/>%g Percent of People",
  joinedTable$NAME, joinedTable$Data_Value
) %>% lapply(htmltools::HTML)

leaflet(states)  %>% setView(lng = -100, lat = 40, zoom = 4) %>%
  addTiles() %>%
  addPolygons(
  fillColor = ~pal2(Data_Value), 
  weight = 2,
  color = "white",
  highlight= highlightOptions(
    weight = 5,
    color = "#666",
    dashArray = "",
    fillOpacity = 0.7,
    bringToFront = TRUE),
label = labels,
  labelOptions = labelOptions(
  style= list("font-weight" = "normal", padding = "3px 8px"),
  textsize = "15px",
  direction = "auto"
   )) %>%
  addLegend(pal = pal, values= ~Data_Value, opacity = 0.7, title= NULL, position= "bottomright"
  )




# THIS WORKS: 
pal2 <- colorBin("YlGnBu", domain = states@data$Data_Value)

leaflet(states) %>%
  addTiles() %>%
  addPolygons(
    label = ~NAME,
    fillColor = ~pal2(Data_Value)
      )
  

# %>% setView(lng=-100, lat= 40, zoom=4)


