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
                mainPanel("Our page analyzes trends in oral health care across the nation. We look at different age groups, race, income levels, gender, and differences in education."))),
      
      tabItem(tabName = "age18",
              titlePanel("Adults aged 18+ who have visited a dentist in the past year"),
              mainPanel(
                tabsetPanel(
                  tabPanel("Gender",
                    box("Comparing gender within a state:",
                      inputPanel(
                        selectInput("LocationDesc1", label = "State", choices = unique(gender$LocationDesc)),
                        plotOutput("genderplot"))),
                    box("Countrywide comparison of gender data:",
                        plotOutput("statewidegender"))),
                  tabPanel("Age",
                    box("Comparing age within a state:",
                        inputPanel(
                          selectInput("LocationDesc2", label = "State", choices = unique(age5$LocationDesc)),
                          plotOutput("age5plot"))),
                    box("Countrywide comparison of age data:",
                        plotOutput("statewideage"))),
                  tabPanel("Race",
                    box("Comparing race within a state:",
                      inputPanel(
                        selectInput("LocationDesc3", label = "State", choices = unique(race$LocationDesc)),
                        plotOutput("raceplot"))),
                    box("Countrywide comparison of race data:",
                        plotOutput("statewideblack"))),
                  tabPanel("Income",
                    box("Comparing income within a state:",
                      inputPanel(
                        selectInput("LocationDesc4", label = "State", choices = unique(income$LocationDesc)),
                        plotOutput("incomeplot")))),
                  tabPanel("Education",
                      box("Comparing education levels within a state:",
                          inputPanel(
                            selectInput("LocationDesc6", label = "State", choice = unique(education2$LocationDesc)),
                            plotOutput("educationplot"))))))),
      
      tabItem(tabName = "datasource",
              titlePanel("Data Source")))))
