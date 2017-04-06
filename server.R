library(shiny)
library(ggplot2)
library(leaflet)
library(RColorBrewer)
library(htmltools)

gender <- read.csv("gender.csv")
genderB <- read.csv("genderB.csv")
age5 <- read.csv("age5.csv")
age <- read.csv("age.csv")
race <- read.csv("race.csv")
race2 <- read.csv("race2.csv")
income <- read.csv("income.csv")
education2 <- read.csv("education2.csv")
countryplot <- read.csv("countryplot.csv")
newtable.data_value <- read.csv("newtable.data_value.csv")
newtable <- read.csv("newtable.csv")

function(input, output, session) {


  thingsToSay <- c("Diabetes", "Leukemia", "Oral cancer", "Pancreatic cancer", "Heart disease", "Kidney disease")
  
  output$problems <- renderText({
    if (input$ohno > 0 && input$ohno < 7) {
      thingsToSay[input$ohno]    
    } else {""}
  })
  
  thingsToSayHere <- c("Brush twice a day for two minutes with fluoridated toothpaste", "Floss daily to remove plaque that your toothbrush can't reach", "Maintain a healthy diet to obtain the nutrients that prevent gum disease", "Avoid cigarettes and smokeless tobacco", "Visit the dentist regularly for cleanings and exams", "Keep your dentist informed of your medical history and any health developments even if they seem unrelated to your oral health")
  
  output$solutions <- renderText({
    if (input$help > 0 && input$help < 7) {
      thingsToSayHere[input$help]    
    } else {""}
  })
  
  output$genderplot <- renderPlot({
      gender %>%
        filter(LocationDesc == input$LocationDesc1) %>%
        ggplot(aes(Break_Out, Data_Value)) + xlab("Gender") + ylab("Percent") + geom_bar(stat = "identity")})
  
  output$countrywidegender <- renderPlot({
      genderB %>%
      filter(LocationAbbr != "US") %>%
        ggplot(aes(Female, Male, label = LocationAbbr)) + geom_point(alpha = 0) + geom_text(aes(label = LocationAbbr), hjust=0.5, vjust=0.5, size = 3)})
  
  output$age5plot <- renderPlot({
    age5 %>%
        filter(LocationDesc == input$LocationDesc2) %>%
        ggplot(aes(Break_Out, Data_Value)) + xlab("Age Group") + ylab("Percent") + geom_bar(stat="identity")})
  
  output$countrywideage <- renderPlot({
    age5 %>%
      filter(Break_Out == input$age) %>%
      ggplot(aes(LocationAbbr, Data_Value)) + xlab("State") + ylab("Percent") + geom_bar(stat = "identity") + theme(axis.text.x = element_text(angle = 60, hjust = 1))})

  output$raceplot <- renderPlot({
     race %>%
        filter(LocationDesc == input$LocationDesc3) %>%
        ggplot(aes(Break_Out, Data_Value)) + xlab("Race") + ylab("Percent") + geom_bar(stat = "identity") + theme(axis.text.x = element_text(angle = 60, hjust = 1))})

  output$countrywiderace <- renderPlot({
    race2 %>%
      filter(Break_Out == input$race) %>%
      ggplot(aes(LocationAbbr, Data_Value)) + xlab("State") + ylab("Percent") + geom_bar(stat = "identity") + theme(axis.text.x = element_text(angle = 60, hjust = 1))})
  
  output$incomeplot <- renderPlot({
      income %>%
        filter(LocationDesc == input$LocationDesc4) %>%
        ggplot(aes(Break_Out, Data_Value)) + xlab("Income") + ylab("Percent") + geom_bar(stat = "identity") + theme(axis.text.x = element_text(angle = 60, hjust = 1))})
  
  output$countrywideincome <- renderPlot({
    income %>%
      filter(Break_Out == input$income) %>%
      ggplot(aes(LocationAbbr, Data_Value)) + xlab("State") + ylab("Percent") + geom_bar(stat = "identity") + theme(axis.text.x = element_text(angle = 60, hjust = 1))})
  
  output$educationplot <- renderPlot({
    education2 %>%
      filter(LocationDesc == input$LocationDesc6) %>%
      ggplot(aes(Break_Out, Data_Value)) + xlab("Education Level") + ylab("Percent") + geom_bar(stat = "identity") + theme(axis.text.x = element_text(angle = 60, hjust = 1))})
  
  output$countrywideeducation <- renderPlot({
    education2 %>%
      filter(Break_Out == input$education) %>%
      ggplot(aes(LocationAbbr, Data_Value)) + xlab("State") + ylab("Percent") + geom_bar(stat = "identity") + theme(axis.text.x = element_text(angle = 60, hjust = 1))})
 
  output$countryplot1 <- renderPlot({
    countryplot%>% 
      filter(LocationDesc == input$LocationDesc5) %>% 
      ggplot(aes(X2012, X2014, color = LocationDesc)) +xlab("2012") + ylab("2014") + geom_point() + guides(color=guide_legend(title = "State:"))})
  
  output$country<- renderPlot({
    countryplot%>%
      ggplot(aes(X2012,X2014, color=LocationDesc)) + xlab("2012_values") + ylab("2014_values") + geom_point() + theme(legend.position = "bottom") + theme(legend.text = element_text(size=9))})
  
  map <- readRDS(file = "heatmap.rds")
  
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
  
    output$map <- renderLeaflet({
        leaflet(states)  %>% setView(lng = -100, lat = 40, zoom = 4) %>%
        addTiles() %>%
        addPolygons(
          fillColor = ~pal(Data_Value), 
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
    })
    
    output$downloadTable <- downloadHandler( filename = "oralhealthdata.txt",
                                             content = function(file) {
                                               write.table(dental_data_RAW, file=file)
                                             })
                                             
}

