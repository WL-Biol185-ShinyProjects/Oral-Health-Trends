library(shiny)
library(ggplot2)

function(input, output) {
  
  output$genderplot <- renderPlot({
      gender %>%
        filter(LocationDesc == input$LocationDesc) %>%
        ggplot(aes(Break_Out, Data_Value)) + xlab("Gender") + ylab("Percent") + geom_bar(stat = "identity")})
  
  output$statewidegender <- renderPlot({
      genderB %>%
        ggplot(aes(Female, Male, color = LocationAbbr)) + geom_point()})

}
