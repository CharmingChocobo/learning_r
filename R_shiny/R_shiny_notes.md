# R Shiny app reminders
- Check out the reaction flow by placing `options(shiny.reactlog = TRUE)` in the app and pressing `CTRL + F3` in the browser.
- Do not create variables outside the server(). This will create an error when deploying dashboard to shinyapps.io.
- Make general plot functions for only plotting. Small differences can still be changed outside its function.
```r
# In a function module
data_filter <- function(df, condition) {
    data_to_plot <- df |>
        filter(condition)
    # return
    data_to_plot
}

plotter <- function(data_to_plot, x, y) {
    p <- ggplot(df, aes(
        x = x,
        y = y
    )) +
    geom_line()

    # return
    p
}

# In the app
server <- function(input, output) {
    # To keep filtered data in buffer:
    filtered_data <- reactive(
        data_filter(df, condition)
    )

    output$plot <- renderPlot({
        plotter(
            data_to_plot = filtered_data,
            x = x_column,
            y = y_column
        ) + xlim(NA, 100)
    })
}
```