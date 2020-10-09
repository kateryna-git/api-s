FROM trestletech/plumber:latest


#RUN apt-get update --allow-releaseinfo-change -qq && apt-get install -y \
#  git-core \
#  libssl-dev \
#  default-jdk \
#  libcurl4-openssl-dev \
#  libxml2-dev \
 # libpq-dev -y

# Install R packages
RUN R -e "install.packages('jsonlite')"


#RUN R -e "install.packages('devtools')"
#RUN R -e 'devtools::install_github("fdrennan/plumberAPI")'

COPY cars-model.rds /cars-model.rds
COPY plumber.R /plumber.R
COPY main.R /main.R

CMD ["/main.R"]
