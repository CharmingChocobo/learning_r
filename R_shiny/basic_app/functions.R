
library(yaml)
library(tidyverse)

config <- yaml::yaml.load_file("config.yaml")

df <- read_csv(
  paste0(config["path_to_data"]) # config['var'] needs to be wrapped by paste0() ...
  )

plotter <- function(df) {
  p <- ggplot(df, aes(name)) +
    geom_bar()
  
  # return
  p
}
