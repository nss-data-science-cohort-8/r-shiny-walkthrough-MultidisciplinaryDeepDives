#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Define UI for application that draws a histogram
fluidPage(
  
  # Application title
  titlePanel("Penguins Data"),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      
      selectInput("histvariable",
                  label = "Select a histogram variable:",
                  choices = numeric_variables),
      
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30),
      
      selectInput("island", 
                  label = h3("Select an Island"),  # h3 is level 3 header
                  choices = c("All", penguins |> distinct(island) |>  pull() |> sort()), 
                  selected = 1),
      width = 3
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      fluidRow(
        column(
          width = 6,
          plotOutput("distPlot", height = "300px")
        ),
        column(
          width = 6,
          plotOutput("speciescountPlot", height = "300px")
        )
      ),
      fluidRow(
        dataTableOutput("selecteddataTable")
      ),
      width = 9
    )
  )
)


