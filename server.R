library(shiny)
library(ggplot2)

function(input, output) {
  
  output$genderplot <- renderPlot({
      gender %>%
        filter(LocationDesc == input$LocationDesc1) %>%
        ggplot(aes(Break_Out, Data_Value)) + xlab("Gender") + ylab("Percent") + geom_bar(stat = "identity")})
  
  output$statewidegender <- renderPlot({
      genderB %>%
        ggplot(aes(Female, Male, color = LocationAbbr)) + geom_point() + guides(color = guide_legend(title = "State:"))})
  
  output$age5plot <- renderPlot({
    age5 %>%
        filter(LocationDesc == input$LocationDesc2) %>%
        ggplot(aes(Break_Out, Data_Value)) + xlab("Age Group") + ylab("Percent") + geom_bar(stat="identity")})

  output$raceplot <- renderPlot({
     race %>%
        filter(LocationDesc == input$LocationDesc3) %>%
        ggplot(aes(Break_Out, Data_Value)) + xlab("Race") + ylab("Percent") + geom_bar(stat = "identity") + theme(axis.text.x = element_text(angle = 60, hjust = 1))})

  output$statewideblack <- renderPlot({
      raceB %>%
        ggplot(aes(LocationAbbr, Black)) + xlab("State") + ylab("Percent") + geom_bar(stat = "identity") + theme(axis.text.x = element_text(angle = 60, hjust = 1))})
  
  output$incomeplot <- renderPlot({
      income %>%
        filter(LocationDesc == input$LocationDesc4) %>%
        ggplot(aes(Break_Out, Data_Value)) + xlab("Income") + ylab("Percent") + geom_bar(stat = "identity") + theme(axis.text.x = element_text(angle = 60, hjust = 1))})
  
  output$educationplot <- renderPlot({
    education2 %>%
      filter(LocationDesc == input$LocationDesc6) %>%
      ggplot(aes(Break_Out, Data_Value)) + xlab("Education Level") + ylab("Percent") + geom_bar(stat = "identity") + theme(axis.text.x = element_text(angle = 60, hjust = 1))})
 
  output$countryplot1 <- renderPlot({
    countryplot%>% 
      filter(LocationDesc == input$LocationDesc5) %>% 
      ggplot(aes(X2012, X2014, color = LocationDesc)) +xlab("2012") + ylab("2014") + geom_point() + guides(color=guide_legend(title = "State:"))})
  
    output$map <- renderLeaflet({
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
    })
  }
