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
               mainPanel(h4("Your oral health can reveal a lot about the condition of your body as a whole.  
                   For example, when your mouth is healthy, chances are your overall health is good too, but if you have poor oral health, it may indicate that you also have other health problems.  
                   In fact, good oral hygiene can actually prevent diseases from occurring."),
                tabsetPanel(
                  
                  tabPanel("Health Complications",
                    fluidRow(
                      box("Research shows that more than 90% of all systemic diseases have oral manifestations.",
                          p(fluidPage(
                            actionButton("ohno", label = "Oh no!"),
                            verbatimTextOutput("problems")))))),
                  
                  tabPanel("Solutions",
                    fluidRow(
                      box("Seeing a dentist regularly helps maintain oral health while also allowing for your dentist to watch for developments that may point to other health issues.",
                          p(fluidPage(
                            actionButton("help", label = "Help!"),
                            verbatimTextOutput("solutions")))))))))),
      
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
                      box(title = "Comparing gender within a state:", status="success", solidHeader = TRUE, 
                        inputPanel(
                          selectInput("LocationDesc1", label = "State:", choices = unique(gender$LocationDesc)),  
                          plotOutput("genderplot"))),
                      box(title = "Countrywide comparison of gender data:", status="warning", solidHeader = TRUE,  
                          plotOutput("countrywidegender")))),
                  
                  tabPanel("Age",
                      box(title = "Comparing age within a state:", status="success", solidHeader = TRUE,
                        inputPanel(
                          selectInput("LocationDesc2", label = "State", choices = unique(age5$LocationDesc)),
                          plotOutput("age5plot"))),
                      box(title = "Countrywide comparison of age data:", status="warning", solidHeader = TRUE,
                          selectInput("age", label = "Age", choices = unique(age$Break_Out), selected = "disp"),
                          plotOutput("countrywideage"))),
                  
                  tabPanel("Race",
                      box(title = "Comparing race within a state:", status="success", solidHeader = TRUE,
                        inputPanel(
                          selectInput("LocationDesc3", label = "State", choices = unique(race$LocationDesc)),
                          plotOutput("raceplot"))),
                      box(title = "Countrywide comparison of race data:", status="warning", solidHeader = TRUE,
                          selectInput("race", label = "Race", choices = unique(race2$Break_Out), selected = "disp"),
                          plotOutput("countrywiderace"))),
                  
                  tabPanel("Income",
                      box(title = "Comparing income within a state:", status="success", solidHeader = TRUE,
                        inputPanel(
                          selectInput("LocationDesc4", label = "State", choices = unique(income$LocationDesc)),
                          plotOutput("incomeplot"))),
                      box(title = "Countrywide comparison of income data:", status = "warning", solidHeader = TRUE,
                          selectInput("income", label = "Income", choices = unique(income$Break_Out), selected = "disp"),
                          plotOutput("countrywideincome"))),
                
                  tabPanel("Education",
                      box(title = "Comparing education levels within a state:", status="success", solidHeader = TRUE,
                        inputPanel(
                          selectInput("LocationDesc6", label = "State", choice = unique(education2$LocationDesc)),
                          plotOutput("educationplot"))),
                      box(title = "Countrywide comparison of education data:", status = "warning", solidHeader = TRUE,
                          selectInput("education", label = "Education", choices = unique(education2$Break_Out), selected = "disp"),
                          plotOutput("countrywideeducation")))))),
              
      
      tabItem(tabName = "2012v2014",
              fluidPage(
                titlePanel("2012 v 2014"),
                mainPanel( 
                  tabsetPanel(
                    tabPanel("States Comparison 2012v2014",
                             box(title= "Countrywide comparison:", status="success", solidHeader = TRUE,
                                 plotOutput("country"))),
                    tabPanel("Look at State difference individually",
                             box(title= "Statewide comparison:", status="warning", solidHeader = TRUE,
                                 inputPanel(
                                   selectInput("LocationDesc5", label = "State", choices = unique(countryplot$LocationDesc)),
                                   plotOutput("countryplot1")))))))),
      
      tabItem(tabName = "datasource",
              titlePanel("Data Source"),
              mainPanel(
                tabsetPanel(
                    tabPanel("Data References",
                             box(a(href="https://www.deltadentalins.com/oral_health/dentists-detect.html", "Oral Health Information")),
                             box(downloadButton("downloadTable")))))))))

