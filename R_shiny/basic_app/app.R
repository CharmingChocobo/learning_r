library(shiny)

source("functions.R")
source("ui.R")

options(shiny.reactlog = TRUE)

# NOTE: Here are no variables definitions allowed. `shinyapss.io` will not accept it.

# APP
server <- function(input, output) {
  
  df_selection <- reactive({
      selection <- df |>
        filter(wheel_of_five == input$cat)
      
      # return
      selection
  })
  
  output$food <- renderPlot({
    plotter(df_selection())
  })
  
  output$tab <- renderTable(
    df_selection()
  )
}

shinyApp(ui(), server)
