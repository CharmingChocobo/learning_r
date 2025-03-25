library(shiny)
library(bslib)
library(ggplot2)

#####
# # 1.
# ui <- fluidPage(

#     textInput("name", "What's your name?"),
#     textOutput("greeting"),
# )

# server <- function(input, output, session) {

#     output$greeting <- renderText({
#         paste0("Hello ", input$name)
#     })

# }

#####
# # 2. & 3.
# ui <- fluidPage(
#   sliderInput("x", label = "If x is", min = 1, max = 50, value = 30),
#   sliderInput("y", label = "and y is", min = 1, max = 50, value = 5),
#   "then, x times y is",
#   textOutput("product")
# )

# server <- function(input, output, session) {
#   output$product <- renderText({ 
#     input$x * input$y
#   })
# }

#####
# # 4.
# ui <- fluidPage(
#   sliderInput("x", "If x is", min = 1, max = 50, value = 30),
#   sliderInput("y", "and y is", min = 1, max = 50, value = 5),
#   "then, (x * y) is", textOutput("product"),
#   "and, (x * y) + 5 is", textOutput("product_plus5"),
#   "and (x * y) + 10 is", textOutput("product_plus10")
# )

# server <- function(input, output, session) {
#   prod <- reactive({
#     input$x * input$y
#   })


#   output$product <- renderText({ 
#     prod()
#   })
#   output$product_plus5 <- renderText({ 
#     prod() + 5
#   })
#   output$product_plus10 <- renderText({ 
#     prod() + 10
#   })
# }

#####
# 5.
datasets <- c("economics", "faithfuld", "seals")
ui <- fluidPage(
  selectInput("select", "Dataset", choices = datasets),
  verbatimTextOutput("summary"),
  plotOutput("plot") # <- wrong Output type 'was tableOutput'
)

server <- function(input, output, session) {
  dataset <- reactive({
    get(input$select, "package:ggplot2")
  })
  output$summary <- renderPrint({
    summary(dataset())
  })
  output$plot <- renderPlot({
    plot(dataset()) # <- forgotten '()'
  }, res = 96)
}


#####

shinyApp(ui, server)
