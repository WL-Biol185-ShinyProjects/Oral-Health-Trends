library(shiny)
library(ggplot2)

function(input, output) {
  
  output$genderplot <- renderPlot({
      gender %>%
        filter(LocationDesc == input$LocationDesc1) %>%
        ggplot(aes(Break_Out, Data_Value)) + xlab("Gender") + ylab("Percent") + geom_bar(stat = "identity")})
  
  output$statewidegender <- renderPlot({
      genderB %>%
        ggplot(aes(Female, Male, color = LocationAbbr)) + geom_point() + guides(color=guide_legend(title="State:"))})
  
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
  
  output$statewideage <- renderPlot({
    age5 %>%
      ggplot(aes(Break_Out, Data_Value, color = LocationAbbr)) + geom_point()})
  
  output$educationplot <- renderPlot({
    education %>% 
      ggplot(aes(Break_Out, Data_Value)) + xlab("Education Level") + ylab("Percent") + geom_bar(stat = "identity")
  })
  
  }
