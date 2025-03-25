ui <- function() {
  fluidPage(
    selectInput(
      "cat",
      "Category",
      choices = c(distinct(select(df, wheel_of_five)))
    ),
    plotOutput("food"),
    tableOutput("tab")
  )
}
