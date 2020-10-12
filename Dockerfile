FROM rstudio/plumber


#RUN apt-get update --allow-releaseinfo-change -qq && apt-get install -y \
#  git-core \
#  libssl-dev \
#  default-jdk \
#  libcurl4-openssl-dev \
#  libxml2-dev \
 # libpq-dev -y

# Install R packages
RUN R -e "install.packages('lubridate')"
RUN R -e "install.packages('tidyverse')"
RUN R -e "install.packages('modeltime')"
RUN R -e "install.packages('timetk')"

#RUN R -e "install.packages('devtools')"
#RUN R -e 'devtools::install_github("fdrennan/plumberAPI")'

COPY sales_data_sample.csv /sales_data_sample.csv
COPY plumber.R /plumber.R


#ENTRYPOINT ["R", "-e", "pr <- plumber::plumb(commandArgs()[4]); pr$run(host='0.0.0.0', port=8000)"]
CMD ["/plumber.R"]
