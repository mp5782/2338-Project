##### **************************************************
#     CLASSIFICATION ALGORYTHMS
#     MACHINE LEARNING IN PUBLIC HEALTH, SPRING '21
#     FINAL PROJECT
#     LAST EDIT: 2021-05-07 - MP
##### **************************************************

#load libraries
library(tidyverse)
library(MASS)


#LOAD DATA
mob <- read_csv("https://raw.githubusercontent.com/mp5782/2338-Project/main/data/aggregate_mobility_05_04.csv") %>%
  select(c(state, date, days,
           Mobility,
          confirmed_infections,  case_growth,
          phase_indi))

hc.test <- hclust(dist(mob), method = "complete")
plot(hc.test)

# ~~~~~~ NB: these are different nrow() than the new mobility / case data:
# cuts <- read_csv("https://raw.githubusercontent.com/mp5782/2338-Project/main/data/agg_sep_indi_3_4_mobility.csv") %>%
# select(c(Phase_indi_1.0,
#          Phase_indi_2.0,
#          Phase_indi_3.0,
#          Phase_indi_4.0,
#          Phase_indi_5.0))