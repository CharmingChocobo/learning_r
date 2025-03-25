library(shiny)


#####
# # 1.1.
# ui <- textInput(
#   'text',
#   '',
#   value = "Your name",
# )

#####
# # 1.2.
# ui <- sliderInput(
#   'slider',
#   'When should we deliver?',
#   min = as.Date("2019-08-09"),
#   max = as.Date("2019-08-16"),
#   value = as.Date("2019-08-10")
#   # timeFormat = "%F"
# )

#####
# # 1.3.

# ui <- sliderInput(
#   'slider',
#   '',
#   min = 0,
#   max = 100,
#   step = 5,
#   value = 0,
#   animate = TRUE,
# )

# animationOptions(
#   interval = 1,
#   loop = FALSE,
#   playButton = TRUE,
#   pauseButton = NULL
# )

#####
# # 1.4.
# ui <- selectInput(
#   "select",
#   "Select options below:",
#   choices = list(
#     "Pyrimidines" = list("T", "C"),
#     "Purines" = list("A", "G")
#   ),
# )

#####
# 2.1.
# [textOutput(), verbatimTextOutput()]
# a - verbatimTextOutput()
# b - textOutput()
# c - verbatimTextOutput()
# d - verbatimTextOutput()

#####
# # 2.2.
# ui <- plotOutput("quest", height = '300px', width = '700px')

#####
# # 2.3.
# ui <- fluidPage(
#   dataTableOutput("table")
# )

#####
# # 2.4.
# library(reactable)
# ui <- reactableOutput('table')

#####
# # 3.3.4 example
ui <- fluidPage(
  textInput("name", "What's your name?"),
  textOutput("greeting")
)


server <- function(input, output, session) {
  # # 2.2.
  # output$quest <- renderPlot(plot(1:5), res = 96, alt = "Scatterplot of 5 random numbers")

  # # 2.3.
  # output$table <- renderDataTable(mtcars, options = list(pageLength = 5, ordering= FALSE, filtering= FALSE, searching= FALSE))

  # # 2.4.
  # output$table <- renderReactable(reactable(mtcars))

  # # 3.3.5. example (string() is created after the line when it is called.)
  output$greeting <- renderText(string())
  string <- reactive(paste0("Hello ", input$name, "!"))

}
#####

shinyApp(ui, server)
