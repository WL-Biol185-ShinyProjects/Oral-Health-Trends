library(shiny)
library(leaflet)
install.packages("shinydashboard")
library(shinydashboard)
library(ggplot2)

dashboardPage(
  
  dashboardHeader(title = "Oral Health Trends"),
  
  dashboardSidebar( 
    sidebarMenu(
      menuItem("Introduction to Oral Health", tabName = "intro", icon = icon("Introduction to Oral Health")),
      menuItem("Overview", tabName = "overview", icon = icon("Overview")),
      menuItem("Age 18+", tabName = "age18", icon = icon("Age 18+")),
      menuItem("2012 v 2014", tabName = "2012v2014", icon = icon("2012 v 2014")),
      menuItem("Data Source", tabName = "datasource", icon = icon("Data Source")))),
  
  dashboardBody(
    tabItems(
      
      tabItem(tabName = "intro",
              fluidPage(
               titlePanel("A healthy smile means a healthy you!"),
                 h4("The importance of oral health"),
                 p("Your oral health can reveal a lot about the condition of your body as a whole. 
                   For example, when your mouth is healthy, chances are your overall health is good, too. 
                   However, if you have poor oral health, it may indicate that you have other health problems as well. 
                   Additionally, good oral health can actually prevent certain diseases from occurring."))),
      
      tabItem(tabName = "overview",
              fluidPage(
                titlePanel("Overview"),
                  h4("This application analyzes trends in oral health care across the nation from 2014. We look at different age groups, race, income levels, gender, and differences in education."),
                  p("Below is a map of the United States showing the percentage of adults over the age of 18 who have gone to the dentist in the past year:")),
              leafletOutput("map"), p(), actionButton("recalc", "")),
      
      tabItem(tabName = "age18",
              titlePanel("Adults aged 18+ who have visited a dentist in the past year"),
              mainPanel(
                tabsetPanel(
                  
                  tabPanel("Gender",
                    fluidRow(
                      box(title = "Comparing gender within a state:",
                        inputPanel(
                          selectInput("LocationDesc1", label = "State:", choices = unique(gender$LocationDesc)),  
                          plotOutput("genderplot"))),
                      box(title = "Countrywide comparison of gender data:",
                          plotOutput("statewidegender", width = 400, height = 400)))),
                  
                  tabPanel("Age",
                      box(title = "Comparing age within a state:",
                        inputPanel(
                          selectInput("LocationDesc2", label = "State", choices = unique(age5$LocationDesc)),
                          plotOutput("age5plot"))),
                      box(title = "Countrywide comparison of age data:",
                          plotOutput("statewideage"))),
                  
                  tabPanel("Race",
                      box(title = "Comparing race within a state:",
                        inputPanel(
                          selectInput("LocationDesc3", label = "State", choices = unique(race$LocationDesc)),
                          plotOutput("raceplot"))),
                      box(title = "Countrywide comparison of race data:",
                          plotOutput("statewideblack"))),
                  
                  tabPanel("Income",
                      box(title = "Comparing income within a state:",
                        inputPanel(
                          selectInput("LocationDesc4", label = "State", choices = unique(income$LocationDesc)),
                          plotOutput("incomeplot")))),
                  
                  tabPanel("Education",
                      box(title = "Comparing education levels within a state:",
                        inputPanel(
                          selectInput("LocationDesc6", label = "State", choice = unique(education2$LocationDesc)),
                          plotOutput("educationplot"))))))),
      
      tabItem(tabName = "2012v2014",
              fluidPage(
                titlePanel("2012 v 2014"),
                mainPanel( 
                  tabsetPanel(
                    tabPanel("States Comparison 2012v2014",
                             box("Countrywide comparison of 2012v2014 data:",
                                 plotOutput("country"))),
                    tabPanel("Look at State difference individually",
                             box("Looking at the difference between 2012 and 201<a>4 values by state:",
                                 inputPanel(
                                   selectInput("LocationDesc5", label = "State", choices = unique(countryplot$LocationDesc)),
                                   plotOutput("countryplot1")))))))),
      
      tabItem(tabName = "datasource",
              titlePanel("Data Source")))))


#a(href = ";link, "Text to link")