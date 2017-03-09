library(shiny)

# Define UI for application that draws a histogram
fluidPage(
  
  # Application title
  titlePanel("Old Faithful Geyser Data"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
<<<<<<< HEAD
)
<<<<<<< HEAD

#biology
=======
=======
)
>>>>>>> 737dd25804e37b29011813aa0336f4e541b54d6d
>>>>>>> 28b2b37a07f31141588cf754705e3bce1bb0911f
