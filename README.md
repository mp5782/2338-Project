# 2338-Project
Project For Spring 2021 Machine Learning in Public Health

Mobility Data by IHME:
http://www.healthdata.org/covid/data-downloads

We use the data updated September 3, 2020:
https://ihmecovid19storage.blob.core.windows.net/archive/2020-09-03/ihme-covid19.zip

Cases + Death data by Johns Hopkins University:
https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data/csse_covid_19_daily_reports
We use data from 2020-02-08 to2020-08-23, matched to IHME dates.

The R Script `DGP.R` is our Data Generation Process. Note that we can't host the indicated IHME .csv file here so you'll need to download and unpack it from the .zip link above first to reproduce our work. Once you have the IHME .csv file the script's output will match the NationalRef.csv dataset hosted in the `data` folder of this repository.

The R Script `interrupted_time_series_analysis.R` is our Regression Discontinuity Analysis. The data for that *is* hosted on this repository, so it can be downloaded an run without modification.

The python notebook `prep_data_classifiers.ipynb` is used for generating the labels for the machine learning classifiers.

The R script `classifiers.R` contains the machine learning classifiers we employed, and uses data hosated in this repository.

**Results**: The `Results` folder includes the results of the interrupted time series analysis for both the outcomes at the subnational analysis.
