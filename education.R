library(ggplot2)
library(shiny)
library(dplyr)

education <- filter(dental_data_RAW, Break_Out_Category == "Education", Response == "Yes", Year == "2014")

ggplot(education, aes(Break_Out, Data_Value)) + xlab("Education Level") + ylab("Percent") + geom_bar(stat = "identity")

inputPanel(
  selectInput("LocationDesc", label = "State", choices = unique(education$LocationDesc)),
  plotOutput("educationplot"))

output$educationplot <- renderPlot({
  education %>%
    filter(LocationDesc == input$LocationDesc) %>%
    ggplot(aes(Break_Out, Data_Value)) + xlab("Education Level") + ylab("Percent") + geom_bar(stat = "identity")})

