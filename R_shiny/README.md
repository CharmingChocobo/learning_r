# Content
- learning_the_basics: https://shiny.posit.co/r/getstarted/shiny-basics/lesson1/
- mastering_shiny: https://mastering-shiny.org/
- template_app: Example of an app that is hosted by shinyapps.io 

# Good to know
- Data files can also be accessed by placing it on `bioinf.nl`. _(I guess it will still be included into the data bundle that shiny makes??)_
- Check out the reaction flow by placing `options(shiny.reactlog = TRUE)` in the app after the imports and pressing `CTRL + F3` in the browser after launching it.
- Do not create variables outside the server(). This will create an error when deploying dashboard to shinyapps.io.
- After testing your app locally, the app can be deployed by either clicking on 'Publish' in R Studio (giving you the ability to select which files to bundle) or by entering the following in the terminal `library(rsconnect)` `rsconnect::deployApp()` after checking if work directory is set in the app folder with `getwd()`. (Work dir can be changed with `setwd("work/directory/here")`) See documentation [here](https://docs.posit.co/shinyapps.io/guide/getting_started/#deploying-a-sample-application).

# Tip
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
