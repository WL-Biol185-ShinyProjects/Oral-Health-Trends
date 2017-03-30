library(ggplot2)
library(shiny)
library(dplyr)

education2 <- filter(dental_data_RAW, Break_Out_Category == "Education", Indicator == "Adults aged 18+ who have visited a dentist or dental clinic in the past year", Response == "Yes", Year == "2014")

ggplot(education, aes(Break_Out, Data_Value)) + xlab("Education Level") + ylab("Percent") + geom_bar(stat = "identity")

inputPanel(
  selectInput("LocationDesc", label = "State", choices = unique(education2$LocationDesc)),
  plotOutput("educationplot"))

output$educationplot <- renderPlot({
  education2 %>%
    filter(LocationDesc == input$LocationDesc) %>%
    ggplot(aes(Break_Out, Data_Value)) + xlab("Education Level") + ylab("Percent") + geom_bar(stat = "identity")})

