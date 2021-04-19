##### **************************************************
#     DATA GENERATION
#     MACHINE LEARNING IN PUBLIC HEALTH, SPRING '21
#     FINAL PROJECT
#     LAST EDIT: 2021-04-19
##### **************************************************
library(tidyverse)
setwd("A:/Dropbox/01 NYU/01 CLASSES/00 2021 SPRING/GPH-GU 2338 (ML)/PROJECT")

#NATIONAL INFO FROM BASELINE PREDICTIONS
ref.national <- read_csv("Reference_hospitalization_all_locs.csv") %>%
  filter(location_name == "India") %>%
# CONSTRAIN TO ACTUAL / OBSERVED DATA
  filter(mobility_data_type == "observed") %>%
  select(c(location_name,
           location_id,
           date,
           V1,
           mobility_data_type,
           mobility_composite, 
           confirmed_infections,
           confirmed_infections_p100k_rate))

#STATE DATA FROM BASELINE PREDICTIONS
ref.state <- read_csv("Reference_hospitalization_all_locs.csv") %>%
  filter(location_name == "Assam" |
           location_name == "Bangladesh" |
           location_name == "Bihar" |
           location_name == "Chhattisgarh" |
           location_name == "Goa" |
           location_name == "Gujarat" |
           location_name == "Karnataka" |
           location_name == "Kerala" |
           location_name == "Madhya Pradesh" |
           location_name == "Manipur" |
           location_name == "Odisha" |
           location_name == "Punjab" |
           location_name == "Tamil Nadu" |
           location_name == "Uttarakhand" |
           location_name == "Andhra Pradesh" |
           location_name == "Delhi" |
           location_name == "Himachal Pradesh" |
           location_name == "Jharkhand" |
           location_name == "Maharashtra" |
           location_name == "Rajasthan" |
           location_name == "Tripura" |
           location_name == "Uttar Pradesh" |
           location_name == "West Bengal") %>%
# CONSTRAIN TO ACTUAL / OBSERVED DATA
  filter(mobility_data_type == "observed") %>%
  select(c(location_name,
           location_id,
           date,
           V1,
           mobility_data_type,
           mobility_composite, 
           confirmed_infections,
           confirmed_infections_p100k_rate))


#ADDING DATES FROM JHU, github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data/csse_covid_19_daily_reports
## NB: variable `Country/Region` becomes Country_Region at 03-22-2020.csv
## PLACEHOLDER FOR NATIONAL DEATH DATA
ref.national$confirmed_deaths <- NA
## CREATE URLS PART 1
dates.1 <- seq(as.Date("2020-02-08"), as.Date("2020-03-21"), "days")
dates.1 <- format(dates.1, "%m-%d-%Y")
links.1 <- c("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/date.csv")
for (date in dates.1) {
  links.1[date] <- paste0("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/",
                 date, ".csv")
}
links.1 <- unname(links.1)
## CREATE URLS PART 2
dates.2 <- seq(as.Date("2020-03-22"), as.Date("2020-08-23"), "days")
dates.2 <- format(dates.2, "%m-%d-%Y")
links.2 <- c("base"="https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/date.csv")
for (date in dates.2) {
  links.2[date] <- paste0("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/",
                  date, ".csv")
}
links.2 <- unname(links.2)
#ADD FIRST GROUP OF NATIONAL DEATH DATA

#create vector of deaths?
for (url in links.1) {
deaths.date <- read_csv(url) %>%
  filter(`Country/Region` == "India")
deaths.1[which(links.1==url)] <- deaths.date$Deaths
}













### ********** SCRAP CODE **********


### FIND THE DATE WHERE SUBNATIONAL INDIAN DATA STARTS :()  
#  filter(Country_Region == "India")%>%
#  select(c(Province_State,
#           Country_Region,
#           Confirmed,
#           Deaths)) %>% 
#  group_by(Country_Region) %>% summarise(confirmed_deaths = sum(Deaths)) %>%
#  rename(location_name = Country_Region)
#ref.nat.obs$confirmed_deaths[date=="2020-02-08"] <- deaths.date[,1]



#SUMMARY STATS; POSSIBLY USEFUL FOR RESTRICTION DATES / BED COUNTS
#summ.national <- read_csv("Summary_stats_all_locs.csv") %>%
#  filter(location_name == "India")
#SUMMARY STATS, STATE LEVEL - RESTRICTIO NDATES / BED COUNTS?
#*******WHY IS PUNJAB IN summary stats TWICE ?!?!?!?!?!
#summ.state <- read_csv("Summary_stats_all_locs.csv") %>% 
#  filter(location_name == "Assam" |
#           location_name == "Bangladesh" |
#           location_name == "Bihar" |
#           location_name == "Chhattisgarh" |
#           location_name == "Goa" |
#           location_name == "Gujarat" |
#           location_name == "Karnataka" |
#           location_name == "Kerala" |
#           location_name == "Madhya Pradesh" |
#           location_name == "Manipur" |
#           location_name == "Odisha" |
#           location_name == "Punjab" |
#           location_name == "Tamil Nadu" |
#           location_name == "Uttarakhand" |
#           location_name == "Andhra Pradesh" |
#           location_name == "Delhi" |
#          location_name == "Himachal Pradesh" |
#           location_name == "Jharkhand" |
#           location_name == "Maharashtra" |
#           location_name == "Rajasthan" |
#           location_name == "Tripura" |
#           location_name == "Uttar Pradesh" |
#          location_name == "West Bengal")

# THESE NUMBERS MATCH, REDUNDANT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# NATIONAL INFO FROM WORST CASE PREDICTIONS
#worse.national <- read_csv("Worse_hospitalization_all_locs.csv") %>%
#  filter(location_name == "India") %>%
#  # CONSTRAIN TO ACTUAL / OBSERVED DATA
#  filter(mobility_data_type == "observed") %>%
#  select(c(location_name,
#           location_id,
#           date,
#           V1,
#           mobility_data_type,
#           mobility_composite, 
#           confirmed_infections,
#           confirmed_infections_p100k_rate)) %>%
#  # CONSTRAIN TO ACTUAL / OBSERVED DATA
#  filter(mobility_data_type == "observed") %>%
#  select(c(location_name,
#           location_id,
#           date,
#          V1,
#           mobility_data_type,
#           mobility_composite, 
#           confirmed_infections,
#           confirmed_infections_p100k_rate))

#STATE DATA FROM WORST CASE PREDICTIONS
#worse.state <- read_csv("Worse_hospitalization_all_locs.csv") %>%
#  filter(location_name == "Assam" |
#           location_name == "Bangladesh" |
#          location_name == "Bihar" |
#           location_name == "Chhattisgarh" |
#           location_name == "Goa" |
#           location_name == "Gujarat" |
#           location_name == "Karnataka" |
#           location_name == "Kerala" |
#           location_name == "Madhya Pradesh" |
#           location_name == "Manipur" |
#           location_name == "Odisha" |
#           location_name == "Punjab" |
#           location_name == "Tamil Nadu" |
#           location_name == "Uttarakhand" |
#           location_name == "Andhra Pradesh" |
#           location_name == "Delhi" |
#           location_name == "Himachal Pradesh" |
#           location_name == "Jharkhand" |
#           location_name == "Maharashtra" |
#           location_name == "Rajasthan" |
#           location_name == "Tripura" |
#           location_name == "Uttar Pradesh" |
#           location_name == "West Bengal") %>%
#  # CONSTRAIN TO ACTUAL / OBSERVED DATA
#  filter(mobility_data_type == "observed") %>%
#  select(c(location_name,
#           location_id,
#           date,
#           V1,
#           mobility_data_type,
#           mobility_composite, 
#           confirmed_infections,
#           confirmed_infections_p100k_rate))
