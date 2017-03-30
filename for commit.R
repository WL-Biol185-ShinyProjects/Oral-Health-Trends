output$educationplot <- renderPlot({
  education %>% 
    ggplot(aes(Break_Out, Data_Value)) + xlab("Education Level") + ylab("Percent") + geom_bar(stat = "identity")
})

box("Comparing education levels within a state:",
    inputPanel(
      selectInput("LocationDesc6", label = "State", choice = unique(education$LocationDesc)),
      plotOutput("educationplot")))),