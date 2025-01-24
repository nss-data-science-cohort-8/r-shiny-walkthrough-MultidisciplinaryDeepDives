#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Define server logic required to draw a histogram
function(input, output, session) {
  
  plot_data <- reactive({
    
    plot_data <- penguins
    
    if (input$island != "All"){
      plot_data <- plot_data |> 
        filter(island == input$island)
    }
    
    return(plot_data)    
  })
  
  
  output$distPlot <- renderPlot({
    
    title <- glue("Distribution of {prepare_title(input$histvariable)}")
    
    if (input$island != "All"){
      title <- glue("Distribution of {prepare_title(input$histvariable)} for {input$island} Island")
    }
    
    plot_data() |> 
      ggplot(aes(x=.data[[input$histvariable]])) +
      geom_histogram(bins = input$bins) +
      labs(
        title = title,
        x = prepare_x_label(input$histvariable)
      )
    
  })
  
   
  
  
  output$speciescountPlot <- renderPlot({
    
    title <- "Species Count"
    
    if (input$island != "All"){
      title <- glue("Species Count for {input$island} Island")
    }
    
    plot_data() |> 
      count(species) |> 
      ggplot(aes(x=species, y=n)) +
      geom_col() +
      labs(
        title = title,
        y = 'count'
      )
    
  })
  
  output$selecteddataTable <- renderDataTable(plot_data())
  
}





