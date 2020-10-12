library(modeltime)
library(timetk)   
library(lubridate)
library(tidyverse)
library(jsonlite)



model <- readRDS("sales_data_sample.csv")

#* Plot a histogram of the gross horsepower
#* @serializer png
#* png
#* @get /plot
function(){
  plot <- raw_data %>%
    select(SALES, ORDERDATE) %>% 
    mutate(date = mdy_hm(ORDERDATE) %>% as_datetime()) %>%
    group_by(date) %>%
    summarise(value = sum(SALES)) %>%
    ungroup() %>%
    plot_time_series(date, value, .interactive = FALSE)
  
  return(plot)
}
