library(shiny)
library(leaflet)
library(shinydashboard)
library(ggplot2)
library(dplyr)
library(tidyverse)

gender <- read.csv("gender.csv")
genderB <- read.csv("genderB.csv")
age5 <- read.csv("age5.csv")
age <- read.csv("age.csv")
race <- read.csv("race.csv")
race2 <- read.csv("race2.csv")
income <- read.csv("income.csv")
education <- read.csv("education.csv")
countryplot <- read.csv("countryplot.csv")
map <- readRDS("heatmap.rds")

dashboardPage(
  
  dashboardHeader(title = "Oral Health Trends"),
  
  dashboardSidebar( 
    sidebarMenu(
      menuItem("Introduction to Oral Health", tabName = "intro", icon = icon("Introduction to Oral Health")),
      menuItem("Overview", tabName = "overview", icon = icon("Overview")),
      menuItem("Categories", tabName = "categories", icon = icon("Categories")),
      menuItem("2012 v 2014", tabName = "2012v2014", icon = icon("2012 v 2014")),
      menuItem("Data Source", tabName = "datasource", icon = icon("Data Source")))),
  
  dashboardBody(
    tabItems(
      
      tabItem(tabName = "intro",
              fluidPage(
               titlePanel("A healthy smile means a healthy you!"),
               mainPanel(h4("Your oral health can reveal a lot about the condition of your body as a whole.  
                   For example, when your mouth is healthy, chances are your overall health is good too. 
                   However, if you have poor oral health, it may indicate that you also have other health problems.  
                   In fact, good oral hygiene can actually prevent diseases from occurring."),
                tabsetPanel(
                  
                  tabPanel("Health Complications",
                    fluidRow(
                      box("Research shows that more than 90% of all systemic diseases have oral manifestations.", width=10,
                          p(),
                          p("Click below to see a few examples."),
                          p(fluidPage(
                            actionButton("ohno", label = "Oh no!"),
                            verbatimTextOutput("problems")))))),
                  
                  tabPanel("Solutions",
                    fluidRow(
                      box("Seeing a dentist regularly helps maintain oral health while also allowing for your dentist to watch for developments that may point to other health issues.", width=12, 
                          p(),
                          p("Click below to see tips on maintaining good oral hygiene."),
                          p(fluidPage(
                            actionButton("help", label = "Help!"),
                            verbatimTextOutput("solutions")))))))))),
      
      tabItem(tabName = "overview",
              fluidPage(
                titlePanel("Overview"),
                  h4("Below is a map of the United States showing the percent of adults over the age of 18 in each state who visited a dentist in 2014:")),
              leafletOutput("map"), p(), actionButton("recalc", "")),
      
      tabItem(tabName = "categories",
              titlePanel("Trends in oral health care across the nation in 2014"),
              mainPanel(h4("Analysis of adults aged 18+ that visited a dentist, split up by different genders, age groups, races, income levels, and education levels."),
                tabsetPanel(
                  
                  tabPanel("Gender",
                    fluidRow(
                      box(title = "Within a state:", width = 4, status="success", solidHeader = TRUE, 
                        inputPanel(
                          selectInput("LocationDesc1", label = "State:", choices = unique(gender$LocationDesc)),  
                          plotOutput("genderplot"))),
                      box(title = "Across the nation:", width = 8, status="warning", solidHeader = TRUE,  
                          plotOutput("countrywidegender")))),
                  
                  tabPanel("Age",
                    fluidRow(
                      box(title = "Within a state:", width = 4, status="success", solidHeader = TRUE,
                        inputPanel(
                          selectInput("LocationDesc2", label = "State:", choices = unique(age5$LocationDesc)),
                          plotOutput("age5plot"))),
                      box(title = "Across the nation:", width = 8, status="warning", solidHeader = TRUE,
                          selectInput("age", label = "Age Group:", choices = unique(age$Break_Out), selected = "disp"),
                          plotOutput("countrywideage")))),
                  
                  tabPanel("Race",
                    fluidRow(
                      box(title = "Within a state:", width = 4, status="success", solidHeader = TRUE,
                        inputPanel(
                          selectInput("LocationDesc3", label = "State:", choices = unique(race$LocationDesc)),
                          plotOutput("raceplot"))),
                      box(title = "Across the nation:", width = 8, status="warning", solidHeader = TRUE,
                          selectInput("race", label = "Race:", choices = unique(race2$Break_Out), selected = "disp"),
                          plotOutput("countrywiderace")))),
                  
                  tabPanel("Income",
                    fluidRow(
                      box(title = "Within a state:", width = 4, status="success", solidHeader = TRUE,
                        inputPanel(
                          selectInput("LocationDesc4", label = "State:", choices = unique(income$LocationDesc)),
                          plotOutput("incomeplot"))),
                      box(title = "Across the nation:", width = 8, status = "warning", solidHeader = TRUE,
                          selectInput("income", label = "Income Level:", choices = unique(income$Break_Out), selected = "disp"),
                          plotOutput("countrywideincome")))),
                
                  tabPanel("Education",
                    fluidRow(
                      box(title = "Within a state:", width = 4, status="success", solidHeader = TRUE,
                        inputPanel(
                          selectInput("LocationDesc6", label = "State:", choice = unique(education$LocationDesc)),
                          plotOutput("educationplot"))),
                      box(title = "Across the nation:", width = 8, status = "warning", solidHeader = TRUE,
                          selectInput("education", label = "Education Level:", choices = unique(education$Break_Out), selected = "disp"),
                          plotOutput("countrywideeducation"))))))),
              
      
      tabItem(tabName = "2012v2014",
              fluidPage(
                titlePanel("2012 v 2014"),
                mainPanel( 
                  tabsetPanel(
                    tabPanel("State Comparison of 2012 and 2014",
                             box(title= "Countrywide comparison:", width=10, status="success", solidHeader = TRUE,
                                 plotOutput("country", width=500, height = 600))),
                    tabPanel("Individual State Data",
                             box(title= "Statewide values:", width = 8, status="warning", solidHeader = TRUE,
                                 inputPanel(
                                   selectInput("LocationDesc5", label = "State", choices = unique(countryplot$LocationDesc)),
                                   plotOutput("countryplot1", width = 400, height= 500)))))))),
      
      tabItem(tabName = "datasource",
              titlePanel("Data Source"),
              mainPanel(
                tabsetPanel(
                    tabPanel("Data References",
                             box(a(href="https://www.deltadentalins.com/oral_health/dentists-detect.html", "Oral Health Information")),
                             box(downloadButton("downloadTable")))))))))

