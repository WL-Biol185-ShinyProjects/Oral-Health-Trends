library(shiny)
library(leaflet)
install.packages("shinydashboard")
library(shinydashboard)
library(ggplot2)

dashboardPage(
  
  dashboardHeader(title = "Oral Health Trends"),
  
  dashboardSidebar( 
    sidebarMenu(
      menuItem("Home", tabName = "Home", icon = icon("Home")),
      menuItem("Age 18+", tabName = "age18", icon = icon("Age 18+")),
      menuItem("Data Source", tabName = "datasource", icon = icon("Data Source")))),
  
  dashboardBody(
    tabItems(
      tabItem(tabName = "Home",
              fluidPage(
                titlePanel("Welcome to our page!"),
                mainPanel("info about our page and why its important"))),
      
      tabItem(tabName = "age18",
              titlePanel("Adults aged 18+ who have visited a dentist in the past year"),
              mainPanel(
                tabsetPanel(
                  tabPanel("Gender",
                    box("Comparing gender within a state:",
                      inputPanel(
                        selectInput("LocationDesc", label = "State", choices = unique(gender$LocationDesc)),
                        plotOutput("genderplot"))),
                    box("Countrywide comparison of gender data:",
                      plotOutput("statewidegender"))),
                  tabPanel("Age"),
                  tabPanel("Race"),
                  tabPanel("Income"),
                  tabPanel("Education")))),
      
      tabItem(tabName = "datasource",
              titlePanel("Data Source")))))
