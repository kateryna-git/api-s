FROM rstudio/plumber


## Install R Packages
RUN R -e "install.packages('tidyverse')"
RUN R -e "install.packages('lubridate')"
RUN R -e "install.packages('jsonlite')"

COPY cars-model.rds /cars-model.rds
COPY plumber.R /plumber.R

CMD ["/plumber.R"]
