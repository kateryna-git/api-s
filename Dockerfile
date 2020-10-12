FROM rstudio/plumber


## Install R Packages
RUN install2.r --error --deps TRUE \
    jsonlite \
    tidyverse \
    plotly \
    lubridate

COPY cars-model.rds /cars-model.rds
COPY plumber.R /plumber.R

CMD ["/plumber.R"]
