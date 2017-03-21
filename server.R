library(shiny)

function(input, output) {
  
  output$genderplot <- renderPlot({
      gender %>%
        filter(LocationDesc == input$LocationDesc) %>%
        ggplot(aes(Break_Out, Data_Value)) + geom_bar(stat = "identity")  

  })
}
