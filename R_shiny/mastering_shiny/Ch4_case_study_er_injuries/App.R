
setwd("/homes/jbeenen/git-repo/mimic_demo/shiny/mastering_shiny/Ch4_case_study_er_injuries/")

library(shiny)
library(vroom)
library(tidyverse)
options(shiny.reactlog = TRUE)

injuries <- vroom::vroom("neiss/injuries.tsv.gz")
products <- vroom::vroom("neiss/products.tsv")
population <- vroom::vroom("neiss/population.tsv")

# Filter on prod_code 649 (=toilet)
selected <- injuries %>% filter(prod_code == 649)
nrow(selected)

# Basic summary
selected %>% count(location, wt = weight, sort = TRUE)
selected %>% count(body_part, wt = weight, sort = TRUE)
selected %>% count(diag, wt = weight, sort = TRUE)

# Plot (not normalised)
summary <- selected %>% 
  count(age, sex, wt = weight)

summary %>% 
  ggplot(aes(age, n, colour = sex)) + 
  geom_line() + 
  labs(y = "Estimated number of injuries")

# Normalised summary
summary <- selected %>% 
  count(age, sex, wt = weight) %>% 
  left_join(population, by = c("age", "sex")) %>% 
  mutate(rate = n / population * 1e4)

# Plot (normalised)
summary %>% 
  ggplot(aes(age, rate, colour = sex)) + 
  geom_line(na.rm = TRUE) + 
  labs(y = "Injuries per 10,000 people")

prod_codes <- setNames(products$prod_code, products$title)

#### Functions for app
count_top <- function(df, var, n = 5) {
  df %>%
    mutate({{ var }} := fct_lump(fct_infreq({{ var }}), n = n)) %>%
    # mutate({{ var }} := fct_infreq(fct_lump_lowfreq({{ var }}), n = n)) %>%
    group_by({{ var }}) %>%
    summarise(n = as.integer(sum(weight)))
}


#### Actual app

ui <- fluidPage(
  fluidRow(
    column(6,
           selectInput("code", "Product",
                       choices = setNames(products$prod_code, products$title),
                       width = "100%"
           )
    ),
    column(4, sliderInput("nrows", "Show rows", min = 1, max = 25, value = 6), ),
    column(2, selectInput("y", "Y axis", c("rate", "count")))
  ),
  fluidRow(
    column(4, tableOutput("diag")),
    column(4, tableOutput("body_part")),
    column(4, tableOutput("location"))
  ),
  fluidRow(
    column(12, plotOutput("age_sex"))
  ),
  fluidRow(
    column(12, h3("Story time!"))
  ),
  fluidRow(
    # column(2, actionButton('story', "Tell me a story")),
    column(1, actionButton('prev_story', "<")),
    column(10, textOutput("narrative")),
    column(1, actionButton('next_story', ">")),
  ),
)

server <- function(input, output, session) {
  ### Reactive functions
  selected <- reactive(injuries %>% filter(prod_code == input$code))
  
  # Find the maximum possible of rows.
  max_no_rows <- reactive(
    max(length(unique(selected()$diag)),
        length(unique(selected()$body_part)),
        length(unique(selected()$location)))
  )
  
  # Update the maximum value for the numericInput based on max_no_rows().
  observeEvent(input$code, {
    updateSliderInput(session, "nrows", max = max_no_rows()+1)
  })
  
  ### Outputs
  # Tables
  output$diag <- renderTable(count_top(selected(), diag, n = input$nrows-1), width = "100%")
  output$body_part <- renderTable(count_top(selected(), body_part, n = input$nrows-1), width = "100%")
  output$location <- renderTable(count_top(selected(), location, n = input$nrows-1), width = "100%")
  
  
  # Plot 1
  summary <- reactive({
    selected() %>%
      count(age, sex, wt = weight) %>%
      left_join(population, by = c("age", "sex")) %>%
      mutate(rate = n / population * 1e4)
  })
  
  # output$age_sex <- renderPlot({
  #   summary() %>%
  #     ggplot(aes(age, n, colour = sex)) +
  #     geom_line() +
  #     labs(y = "Estimated number of injuries")
  # }, res = 96)
  
  # Plot 2
  output$age_sex <- renderPlot({
    if (input$y == "count") {
      summary() %>%
        ggplot(aes(age, n, colour = sex)) +
        geom_line() +
        labs(y = "Estimated number of injuries")
    } else {
      summary() %>%
        ggplot(aes(age, rate, colour = sex)) +
        geom_line(na.rm = TRUE) +
        labs(y = "Injuries per 10,000 people")
    }
  }, res = 96)

  ### Show narrative
  # Store the maximum posible number of stories.
  max_no_stories <- reactive(length(selected()$narrative))

  # reactive used in current position (???)
  story <- reactiveVal(1)
  # reset story to one if in$code is changed
  observeEvent(input$code, {
    story(1)
  })

  observeEvent(input$next_story, {
    story((story() %% max_no_stories()) +1)
  })
  observeEvent(input$prev_story, {
    story(((story() - 2) %% max_no_stories()) + 1)
  })

  output$narrative <- renderText({selected()$narrative[story()]})
  
}



shinyApp(ui, server)
