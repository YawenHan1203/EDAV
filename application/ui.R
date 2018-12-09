library(shiny)
library(shinydashboard)
library(leaflet)

shinyUI(navbarPage(
  
  "Explore Trees in NYC",id="nav",
                   
  tabPanel("Trees Species Distribution",
           div(class="outer",
               tags$style(type = "text/css", "#map {height: calc(100vh - 80px) !important;}"),
               leafletOutput("map",width="100%",height = "100%"),
               absolutePanel(id="control1",fixed = T,draggable = T,class = "panel panel-default",top = 80,
                             left = 55, right = "auto", bottom = "auto",
                             width = 300, height = 200,
                             h5(" Trees Species Distribution on Borough"),
                             checkboxInput("Status","Alive"),
                             selectInput("Tree"," Choose Tree Species",Types, multiple = F,selected = "Norway maple")
 
                             ))
            
  ),
  tabPanel("Related Variables to Borough",
           # App title ----
           titlePanel("Interested Variables"),
           
           # Sidebar layout with input and output definitions ----
           sidebarLayout(
             
             # Sidebar panel for inputs ----
             sidebarPanel(
               
               # Input: Selector for variable to plot against mpg ----
               selectInput("variable", "Choose variables here:",
                           c("Tree species" = "Tree_species",
                             "Recorder types" = "Recorder_type"
                             ))
               
             ),
             
             # Main panel for displaying outputs ----
             mainPanel(
               
               # Output: Formatted text for caption ----
               h3(textOutput("caption")),
               
               # Output: Plot of the requested variable against mpg ----
               plotOutput("mpgPlot")
               
             )
           
           ))

))

