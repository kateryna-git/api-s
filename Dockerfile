FROM rstudio/plumber


## Install R Packages
RUN R -e "install.packages('tidyverse')"
RUN R -e "install.packages('lubridate')"

COPY cars-model.rds /cars-model.rds
COPY plumber.R /plumber.R

CMD ["/plumber.R"]
