
library(plumber)

pr <- plumb("sales-forcast/plumber.R")

pr$run(port=8000, host = "0.0.0.0")
