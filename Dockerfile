FROM rstudio/plumber

## Install R Packages
RUN R -e "install.packages('tidyverse')"
RUN R -e "install.packages('lubridate')"
RUN R -e "install.packages('jsonlite')"

COPY cars-model.rds /cars-model.rds
COPY plumber.R /plumber.R
COPY sales_data_sample.csv/sales_data_sample.csv

CMD ["/plumber.R"]
