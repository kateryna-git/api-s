# plumber.R

library(tidyverse)
library(lubridate)
library(jsonlite)

model <- readRDS("cars-model.rds")
raw_data <- read_csv("sales_data_sample.csv") 

#* Plot a histogram of the gross horsepower
#* @png
#* @get /plothp
function(){
  hist(mtcars$hp)
}

#* Plot a histogram of the manual transmission
#* @png
#* @get /plotam
function(){
  hist(mtcars$am)
}

#* Plot a histogram of the weight (1000 lbs)
#* @png
#* @get /plotwt
function(){
  hist(mtcars$wt)
}

#* Returns the probability whether the car has a manual transmission
#* @param hp Gross horsepower
#* @param wt Weight (1000 lbs)
#* @post /manualtransmission
function(hp, wt){
  newdata <- data.frame(hp = as.numeric(hp), wt = as.numeric(wt))
  predict(model, newdata, type = "response")
}




#* Returns filtered data
#* @param forecast_period Forcast period in months
#* @param time_unit Unit to aggregate by (month, day, week, year)
#* @param left date range lower margin
#* @param right date range upper margin 
#* @serializer json
#* @post /raw_data


preprocess_data <-function(forecast_period = "6 months", time_unit = "day", left = "2003-01-06", right = "2005-05-31") {
  
  df <- raw_data %>%    
    select(SALES, ORDERDATE) %>% 
    mutate(date = mdy_hm(ORDERDATE) %>% as_datetime()) %>% 
    filter(date %>% between(as_datetime(left),
                            as_datetime(right))) %>% 
    mutate(date = floor_date(date,  # Round dates to beginning of a period
                             unit = time_unit)) %>% 
    group_by(date) %>%
    summarise(value = sum(SALES)) %>%
    ungroup()
  
  return(df)
}
