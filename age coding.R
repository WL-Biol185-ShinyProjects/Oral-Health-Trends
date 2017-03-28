library(ggplot2)
library(shiny)
library(dplyr)

age5 <- filter(dental_data_RAW, Break_Out_Category == "Age", LocationDesc != "Guam", LocationDesc != "Puerto Rico", Response == "Yes", Year == "2014")

inputPanel(
  selectInput("LocationDesc", label = "State", choices = unique(age5$LocationDesc))
)

renderPlot({
  age5 %>%
    filter(LocationDesc == input$LocationDesc) %>%
    ggplot(aes(Break_Out, Data_Value)) + geom_bar(stat = "identity")
})

renderPlot({
  age5 %>%
    ggplot(aes(LocationAbbr, Data_Value)) + geom_bar(stat = "identity")
})

ggplot(age5, aes(LocationAbbr, Data_Value) + xlab("State") + ylab("Percent")) + geom_bar(stat = "identity")