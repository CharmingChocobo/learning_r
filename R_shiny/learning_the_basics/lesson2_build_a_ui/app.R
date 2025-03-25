# library(shiny)
# # library(reticulate)

# # use_virtualenv("/homes/jbeenen/venv/MIMIC_IV")


# # py_run_file("test_r/hello.py")

# # Define UI for app that draws a histogram ----
# ui <- fluidPage(

#   # App title ----
#   titlePanel("Hello World!"),
#   # titlePanel("Hello World!"),
#   titlePanel(''),

#   # Sidebar layout with input and output definitions ----
#   sidebarLayout(

#     # Sidebar panel for inputs ----
#     sidebarPanel(

#       # Input: Slider for the number of bins ----
#       sliderInput(inputId = "bins",
#                   label = "Number of bins:",
#                   min = 5,
#                   max = 50,
#                   value = 30)

#     ),

#     # Main panel for displaying outputs ----
#     mainPanel(

#       # Output: Histogram ----
#       plotOutput(outputId = "distPlot")

#     )
#   )
# )

# # Define server logic required to draw a histogram ----
# server <- function(input, output) {

#   # Histogram of the Old Faithful Geyser Data ----
#   # with requested number of bins
#   # This expression that generates a histogram is wrapped in a call
#   # to renderPlot to indicate that:
#   #
#   # 1. It is "reactive" and therefore should be automatically
#   #    re-executed when inputs (input$bins) change
#   # 2. Its output type is a plot
#   output$distPlot <- renderPlot({

#     x    <- faithful$waiting
#     bins <- seq(min(x), max(x), length.out = input$bins + 1)

#     hist(x, breaks = bins, col = "#75AADB", border = "orange",
#          xlab = "Waiting time to next eruption (in mins)",
#          main = "Histogram of waiting times")

#     })

# }

# # Create Shiny app ----
# shinyApp(ui = ui, server = server)

#####

library(shiny)
library(bslib)

# Define UI ----
ui <- page_sidebar(
  title = "My Shiny App",
  sidebar = sidebar(
    p('Shiny is available on CRAN, so you can install it in the usual way from your R console:'),
    code('install.packages("shiny")'),
  ),
  card(
    card_header('Introducing Shiny'),
    card_body('Shiny is a package from Posit that makes it incredibly easy to build interactive web applications with R. For an introducitno and live examples, visit the Shiny homepage (https://shiny.posit.co).'),
    card_image(
      # 'www/shiny.svg', height = "300px"
      file = "shiny-hex.png",
      alt = "Shiny's hex sticker",
      href = "https://github.com/rstudio/shiny"
    ),
    card_footer("Shiny is a product of Posit.")
  )
)

# Define server logic ----
server <- function(input, output) {
}

# Run the app ----
shinyApp(ui = ui, server = server)