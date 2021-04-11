library(tidyverse)
setwd("A:/Dropbox/01 NYU/01 CLASSES/00 2021 SPRING/GPH-GU 2338 (ML)/PROJECT")
SumStats <- read_csv("Summary_stats_all_locs.csv")
reference <- read_csv("Reference_hospitalization_all_locs.csv")
WorseCase <- read_csv("Worse_hospitalization_all_locs.csv")

#national info
stats.national <- SumStats %>% filter(location_name == "India")
ref.national <- reference  %>% filter(location_name == "India")
worse.national <- WorseCase %>% filter(location_name == "India")

#state info      ### WHY IS PUNJAB IN summary stats TWICE ?!?!?!?!?!
stats.state <- SumStats %>% filter(location_name == "Assam" |
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
                                        location_name == "West Bengal")

ref.state <- reference %>% filter(location_name == "Assam" |
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
                                     location_name == "West Bengal")

worse.state <- reference %>% filter(location_name == "Assam" |
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
                                    location_name == "West Bengal")
