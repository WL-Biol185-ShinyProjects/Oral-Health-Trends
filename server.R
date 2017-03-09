library(shiny)
<<<<<<< HEAD
=======

<<<<<<< HEAD

states <- geojsonio::geojson_read("json/us-states.geojson", what = "sp")
class(states)
>>>>>>> 12bb8b0d6689d67b39afb789c1e386de069718fb
=======
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$distPlot <- renderPlot({
    
    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2] 
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
    
  })
  
})
>>>>>>> 5bc099f05a572a5cbb548c291ae4dd185cc29699
