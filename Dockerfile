FROM trestletech/plumber

# Install R packages
RUN R -e "install.packages('jsonlite')"

COPY cars-model.rds /cars-model.rds
COPY plumber-api.R /plumber.R

CMD ["/main.R"]
