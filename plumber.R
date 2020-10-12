model <- readRDS("cars-model.rds")

#* Plot a histogram of the gross horsepower
#* @serializer png
#* png
#* @get /plothp
function(){
  hist(mtcars$hp)
}

#* Plot a histogram of the manual transmission
#* @serializer png
#* png
#* @get /plotam
function(){
  hist(mtcars$am)
}

#* Plot a histogram of the weight (1000 lbs)
#* @serializer png
#* png
#* @get /plotwt
function(){
  hist(mtcars$wt)
  {
