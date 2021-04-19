##### **************************************************
#     DATA GENERATION
#     MACHINE LEARNING IN PUBLIC HEALTH, SPRING '21
#     FINAL PROJECT
#     LAST EDIT: 2021-04-18
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

# NATIONAL INFO FROM WORST CASE PREDICTIONS
worse.national <- read_csv("Worse_hospitalization_all_locs.csv") %>%
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
           confirmed_infections_p100k_rate)) %>%
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


#STATE DATA FROM WORST CASE PREDICTIONS
worse.state <- read_csv("Worse_hospitalization_all_locs.csv") %>%
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


#ADDING DATES FROM JHU: 
# https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data/csse_covid_19_daily_reports

ref.national$confirmed_deaths <- NA  ##PLACEHOLDER FOR NATIONAL DEATH DATA
deaths.date <- read_csv(
  "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/02-08-2020.csv") %>%
  filter(`Country/Region` == "India") %>%
  rename(location_name = `Country/Region`)
ref.national$confirmed_deaths[[1]] <- deaths.date$Deaths[[1]]










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
