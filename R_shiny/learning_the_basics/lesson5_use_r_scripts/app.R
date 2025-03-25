# library(maps)
# library(mapproj)

# source("test_r/census-app/helpers.R")
# counties <- readRDS("test_r/census-app/data/counties.rds")
# percent_map(counties$white, "darkgreen", "% White")

#####

# Load packages ----
library(shiny)
library(bslib)
library(maps)
library(mapproj)

# source("helpers.R")
# counties <- readRDS("data/counties.rds")

print(getwd())
source("helpers.R")
counties <- readRDS("data/counties.rds")


# User interface ----
ui <- page_sidebar(
  title = "censusVis",

  sidebar = sidebar(
    helpText(
      "Create demographic maps with information from the 2010 US Census."
    ),
    selectInput(
      "var",
      label = "Choose a variable to display",
      choices =
        c(
          "Percent White",
          "Percent Black",
          "Percent Hispanic",
          "Percent Asian"
        ),
      selected = "Percent White"
    ),
    sliderInput(
      "range",
      label = "Range of interest:",
      min = 0, 
      max = 100, 
      value = c(0, 100)
    )
  ),

  card(plotOutput("map"))
)

# Server logic ----
server <- function(input, output) {
  output$map <- renderPlot({
    data <- switch(input$var,
                "Percent White" = counties$white,
                "Percent Black" = counties$black,
                "Percent Hispanic" = counties$hispanic,
                "Percent Asian" = counties$asian)
    # min_max_range <- input$range

    percent_map(data, 
                "darkgreen", 
                paste("(%)", input$var), 
                min= input$range[1], 
                max= input$range[2]
    )
  })
}

# Run app ----
shinyApp(ui, server)