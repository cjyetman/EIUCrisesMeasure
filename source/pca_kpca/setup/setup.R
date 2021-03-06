# ---------------------------------------------------------------------------- #
# Set up for PCA and KPCA runs
# Christopher Gandrud
# MIT License
# ---------------------------------------------------------------------------- #

# !! Must set working directory to the location of the EIUCrisesMeasure repository

# Load packages
library(simpleSetup)

pkgs <- c('quanteda', 'kernlab', 'repmis', 'tidyverse', 'rio', 'lubridate',
          'countrycode', 'TTR', 'devtools', 'tm')
library_install(pkgs)

# Install quanteda from devtools::install_github('christophergandrud/quanteda')

# Load preprocessed data (see source/preprocess_eiu.R)
load('source/pca_kpca/preprocessed_data/eiu_texts_from_2003.rda')

# Extract identifying country names and document dates
country_date <- names(eiu_list)
country_date <- stringr::str_split(country_date, pattern = '_', n = 2,
                                   simplify = TRUE) %>% as.data.frame
names(country_date) <- c('iso3c', 'date')
country_date$country <- countrycode(country_date$iso3c, origin = 'iso3c',
                                    destination = 'country.name')
country_date <- country_date[, c('country', 'iso3c', 'date')]

# Source the function for conducting KPCA/refining/saving the results
source('source/pca_kpca/setup/kpca_eiu_function.R')
