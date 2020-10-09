##########################################################
#   Create, Test and Save a Time Series Model    #
##########################################################


library(here)
library(tidymodels)
library(modeltime)
library(timetk)   
library(lubridate)
library(tidyverse)


#inputs, date range and time unit for aggeregation
forcast_period <- "6 months" # User input in months
time_unit <- "day" # User input
left <- "2003-01-06"
right <- "2005-05-31"
               
preprocess_data <-function() {
  
  sales_data_raw <- read_csv(here('00_data/raw/sales_data_sample.csv')) %>%    #read only the needed fields to make faster
    select(SALES, ORDERDATE) %>% 
    mutate(date = mdy_hm(ORDERDATE) %>% as_datetime()) %>% 
    filter(date %>% between(as_datetime(left),
                            as_datetime(right))) %>% 
    mutate(date = floor_date(date,  # Round dates to beginning of a period
                                  unit = time_unit)) %>% 
    group_by(date) %>%
    summarise(value = sum(SALES)) %>%
    ungroup()
  
  return(sales_data_raw)
}

data <- preprocess_data()


#plot time series
data %>%
  plot_time_series(date, value, .interactive = TRUE)


#load model

#get predictions
predictions <- read_rds(here("10_shinydashboard/model-prophet-boost.rds"))  %>% 
  modeltime_refit(data) %>%
  modeltime_forecast(h = time_unit, actual_data = sales_data_raw) 



predictions %>%
  plot_modeltime_forecast(.interactive = TRUE)



# Produce a prediction function that can use the model
get_forecast <- function(time_unit, left, right) {

  predictions <- read_rds(here("10_shinydashboard/model-prophet-boost.rds"))  %>% 
    modeltime_refit(data) %>%
    modeltime_forecast(h = forcast_period, actual_data = data) 
  
  predictions %>%
    plot_modeltime_forecast(.interactive = TRUE)
  
}

get_forecast(time_unit, left, right)
