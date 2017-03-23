library(shiny)

function(input, output) {
  
  output$genderplot <- renderPlot({
      gender %>%
        filter(LocationDesc == input$LocationDesc) %>%
        ggplot(aes(Break_Out, Data_Value)) + xlab("Gender") + ylab("Percent") + geom_bar(stat = "identity")})  

}
