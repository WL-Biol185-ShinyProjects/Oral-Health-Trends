library(ggplot2)
library(shiny)
library(dplyr)

age5 <- filter(dental_data_RAW, Break_Out_Category == "Age", LocationDesc != "Guam", LocationDesc != "Puerto Rico", Response == "Yes", Year == "2014")

ggplot(age5, aes(Break_Out, Data_Value)) + xlab("Age Group") + ylab("Percent") + geom_bar(stat = "identity")

inputPanel(
  selectInput("LocationDesc", label = "State", choices = unique(age5$LocationDesc)),
  plotOutput("age5plot"))

output$age5plot <- renderPlot({
  age5 %>%
    filter(LocationDesc == input$LocationDesc) %>%
    ggplot(aes(Break_Out, Data_Value)) + xlab("Age") + ylab("Percent") + geom_bar(stat = "identity")})

ui <- fluidPage(
  selectInput("age", label = "Age", choices = unique(age$Break_Out), selected = "disp"),
  plotOutput("statewideage")
)


  
  output$statewideage <- renderPlot({
    age5 %>%
      filter(Break_Out == input$age) %>%
      ggplot(aes(LocationAbbr, Data_Value)) + xlab("State") + ylab("Percent") + geom_bar(stat = "identity") + theme(axis.text.x = element_text(angle = 60, hjust = 1))
  })
}
shinyApp(ui = ui, server = server)