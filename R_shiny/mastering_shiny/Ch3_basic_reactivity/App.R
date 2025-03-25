library(shiny)

# 3.3.6.
ui <- fluidPage(
  textInput("name", "What's your name?"),
  textOutput("greeting")
)

# # 3.3.6.
# # Did not include 'input$'
# server1 <- function(input, output, server) {
#   output$greeting <- renderText(paste0("Hello ", input$name))
# }
# shinyApp(ui, server1)

# # Having input$name outside renderText() is a problem
# server2 <- function(input, output, server) {
# #   greeting <- paste0("Hello ", input$name)
#   output$greeting <- renderText(paste0("Hello ", input$name))
# }
# shinyApp(ui, server2)

# # Typo in greeting, missed 'renderText'
# server3 <- function(input, output, server) {
#   output$greeting <- renderText(paste("Hello", input$name))
# }
# shinyApp(ui, server3)

####################################################################

# # # 3.4.2. EXAMPLE
# library(ggplot2)
# 
# freqpoly <- function(x1, x2, binwidth = 0.1, xlim = c(-3, 3)) {
#   df <- data.frame(
#     x = c(x1, x2),
#     g = c(rep("x1", length(x1)), rep("x2", length(x2)))
#   )
#   
#   ggplot(df, aes(x, colour = g)) +
#     geom_freqpoly(binwidth = binwidth, size = 1) +
#     coord_cartesian(xlim = xlim)
# }
# 
# t_test <- function(x1, x2) {
#   test <- t.test(x1, x2)
#   
#   # use sprintf() to format t.test() results compactly
#   sprintf(
#     "p value: %0.3f\n[%0.2f, %0.2f]",
#     test$p.value, test$conf.int[1], test$conf.int[2]
#   )
# }
# 
# 
# ui <- fluidPage(
#   fluidRow(
#     column(4,
#            "Distribution 1",
#            numericInput("n1", label = "n", value = 1000, min = 1),
#            numericInput("mean1", label = "µ", value = 0, step = 0.1),
#            numericInput("sd1", label = "σ", value = 0.5, min = 0.1, step = 0.1)
#     ),
#     column(4,
#            "Distribution 2",
#            numericInput("n2", label = "n", value = 1000, min = 1),
#            numericInput("mean2", label = "µ", value = 0, step = 0.1),
#            numericInput("sd2", label = "σ", value = 0.5, min = 0.1, step = 0.1)
#     ),
#     column(4,
#            "Frequency polygon",
#            numericInput("binwidth", label = "Bin width", value = 0.1, step = 0.1),
#            sliderInput("range", label = "range", value = c(-3, 3), min = -5, max = 5)
#     )
#   ),
#   fluidRow(
#     column(9, plotOutput("hist")),
#     column(3, verbatimTextOutput("ttest"))
#   )
# )
# 
# server <- function(input, output, session) {
#   output$hist <- renderPlot({
#     x1 <- rnorm(input$n1, input$mean1, input$sd1)
#     x2 <- rnorm(input$n2, input$mean2, input$sd2)
#     
#     freqpoly(x1, x2, binwidth = input$binwidth, xlim = input$range)
#   }, res = 96)
#   
#   output$ttest <- renderText({
#     x1 <- rnorm(input$n1, input$mean1, input$sd1)
#     x2 <- rnorm(input$n2, input$mean2, input$sd2)
#     
#     t_test(x1, x2)
#   })
# }
# 
# shinyApp(ui, server)

####################################################################

# # # 3.5.1. & 2. EXAMPLE
# 
# freqpoly <- function(x1, x2, binwidth = 0.1, xlim = c(-3, 3)) {
#   df <- data.frame(
#     x = c(x1, x2),
#     g = c(rep("x1", length(x1)), rep("x2", length(x2)))
#   )
# 
#   ggplot(df, aes(x, colour = g)) +
#     geom_freqpoly(binwidth = binwidth, size = 1) +
#     coord_cartesian(xlim = xlim)
# }
# 
# ui <- fluidPage(
#   fluidRow(
#     column(3,
#            numericInput("lambda1", label = "lambda1", value = 3),
#            numericInput("lambda2", label = "lambda2", value = 5),
#            numericInput("n", label = "n", value = 1e4, min = 0),
#            actionButton("simulate", "Simulate!") # <- OnClick
#     ),
#     column(9, plotOutput("hist"))
#   )
# )
# 
# 
# server <- function(input, output, session) {
#   # timer <- reactiveTimer(500) # <- reactiveTimer
#   
#   x1 <- reactive({
#     # timer() # <- reactiveTimer
#     input$simulate # <- OnClick v1
#     rpois(input$n, input$lambda1)
#   })
#   x2 <- reactive({
#     # timer() # <- reactiveTimer
#     input$simulate # <- OnClick v1
#     rpois(input$n, input$lambda2)
#   })
#   
#   x1 <- eventReactive(input$simulate, { # <- OnClick v2
#     rpois(input$n, input$lambda1)
#   })
#   x2 <- eventReactive(input$simulate, { # <- OnClick v2
#     rpois(input$n, input$lambda2)
#   })
#   
#   output$hist <- renderPlot({
#     freqpoly(x1(), x2(), binwidth = 1, xlim = c(0, 40))
#   }, res = 96)
# }
# 
# shinyApp(ui, server)

####################################################################

# # 3.6. EXAMPLE (observeEvent())

ui <- fluidPage(
  textInput("name", "What's your name?"),
  textOutput("greeting")
)

server <- function(input, output, session) {
  string <- reactive(paste0("Hello ", input$name, "!"))
  
  output$greeting <- renderText(string())
  observeEvent(input$name, {
    message("Greeting performed")
  })
}

shinyApp(ui, server)

