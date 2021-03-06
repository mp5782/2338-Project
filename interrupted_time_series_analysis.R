#load libraries
library(lme4)
library(lattice)
library(fastDummies)
library(tidyverse)

#perform analysis for confirmed infections
data_1 <- read.csv("./data/aggregate_case_05_04.csv")
data_1 <- unique(data_1)

#create indicators for different phases of the intervention
data_1 <- dummy_cols(data_1, select_columns = c('phase_indi'))
#rename the phase which had no intervention as nointer_indi, it is coded as phase_indi = -1
data_1 <- rename(data_1,c('nointer_indi'='phase_indi_-1'))

#subset data to not include India
data_2 <- subset(data_1,state!='India')

#the model uses the phase indicators which we created indicators for above and the days
#since the last intervention denoted by daysx
lmer_confirmed_infections<- lmer(confirmed_infections~ nointer_indi
                                                      +phase_indi_0 
                                                      +phase_indi_1 
                                                      +phase_indi_2
                                                      +phase_indi_3
                                                      +phase_indi_4 
                                                      +phase_indi_5 
                                                      +days
                                                      +days1 
                                                      +days2 
                                                      +days3 
                                                      +days4
                                                      +days5 
                                                      +days6 
                                                      +(1| state), 
                                                      data = data_2)
#get model details
summary(lmer_confirmed_infections)

#Create a dataframe to extract state specific data
data <- NULL
data$case_growth <- data_1$confirmed_infections
data$state <- as.factor(data_1$state)
data$days <- data_1$days
data <- data.frame(data)
states = unique(data$state)

#iterate for all states
for (s in states){
#subset data for the specific state
d <- subset(data_1,state%in%c(s))
#replace nan
d[is.na(d)] <- 0
#we save the plots at the following location
#pdf(paste("./Results/confirmed_infections_",s,".pdf"))

#plot the original data
plot( d$days, d$confirmed_infections,
        bty="n", pch=19, col="gray",
        xlab = "Date", 
        ylab = "Confirmed Infections",main=s,xaxt='n'
      )
  abline( v=19, col="firebrick", lty=2 )
  text( 24, 40000, "Phase 1 lockdown", col="firebrick", cex=0.7, pos=4,srt=90 )

  abline( v=40, col="firebrick", lty=2 )
   text( 42, 45000, "Phase 2 lockdown", col="firebrick", cex=0.7, pos=4,srt=90 )

  abline( v=59, col="firebrick", lty=2 )
  text( 61, 50000, "Phase 3 lockdown", col="firebrick", cex=0.7, pos=4 ,srt=90)

  abline( v=73, col="firebrick", lty=2 )
  text( 75, 55000, "Phase 4 lockdown", col="firebrick", cex=0.7, pos=4 ,srt=90)

  abline( v=87, col='firebrick', lty=2)
  text( 89, 60000, "Unlock 1", col="firebrick", cex=0.7, pos=4 ,srt=90)

  abline( v=117, col='firebrick', lty=2)
  text( 119, 60000, "Unlock 2", col="firebrick", cex=0.7, pos=4 ,srt=90)

  abline( v=148, col='firebrick', lty=2)

#non-mixed model for state
ts <- lm(confirmed_infections ~ nointer_indi+phase_indi_0 + phase_indi_1 +phase_indi_2+phase_indi_3 +phase_indi_4 + phase_indi_5 +days+
                           + days1 + days2 + days3 +days4 + days5 + days6 , data=d)

ts_plain <- lm(confirmed_infections ~  days , data=d)
#plot the fitted values
lines( d$days, ts$fitted.values, col="red", lwd=2 )
lines(d$days, ts_plain$fitted.values,lwd=2)
#add date as label on x-axis instead of days
axis(1, at=d$days,labels=d$date, col.axis="red", las=2,cex.axis = 0.5)
#dev.off()
}

#perform analysis for mobility
data_1 <- read.csv("./data/aggregate_mobility_05_04.csv")
data_1 <- unique(data_1)
data_1 <- dummy_cols(data_1, select_columns = c('phase_indi'))
data_1 <- rename(data_1,c('nointer_indi'='phase_indi_-1'))


data_2 <- subset(data_1,state!='India')

lmer_mobility <- lmer(Mobility ~ nointer_indi
                                +phase_indi_0 
                                +phase_indi_1 
                                +phase_indi_2
                                +phase_indi_3 
                                +phase_indi_4 
                                +phase_indi_5 
                                +days
                                +days1 
                                +days2 
                                +days3 
                                +days4 
                                +days5 
                                +days6 
                                +(1| state) 
                                ,data = data_2)
summary(lmer_mobility)
data <- NULL
data$case_growth <- data_1$Mobility
data$state <- as.factor(data_1$state)
data$days <- data_1$days
data <- data.frame(data)
states = unique(data$state)


for (s in states){
d <- subset(data_1,state%in%c(s))

d[is.na(d)] <- 0
pdf(paste("./Results/mobility_",s,".pdf"))
plot( d$days, d$Mobility,
        bty="n", pch=19, col="gray",
        xlab = "Date", 
        ylab = "Mobility",main=s,xaxt='n'
      )
  abline( v=12, col="firebrick", lty=2 )
  text( 24, 40000, "Phase 1 lockdown", col="firebrick", cex=0.7, pos=4 )

  abline( v=33, col="firebrick", lty=2 )
    text( 42, 45000, "Phase 2 lockdown", col="firebrick", cex=0.7, pos=4 )

  abline( v=52, col="firebrick", lty=2 )
  text( 61, 50000, "Phase 3 lockdown", col="firebrick", cex=0.7, pos=4 )

  abline( v=66, col="firebrick", lty=2 )
  text( 75, 55000, "Phase 4 lockdown", col="firebrick", cex=0.7, pos=4 )

  abline( v=80, col='firebrick', lty=2)
  text( 89, 60000, "Unlock 1", col="firebrick", cex=0.7, pos=4 )

  abline( v=110, col='firebrick', lty=2)
  text( 119, 60000, "Unlock 2", col="firebrick", cex=0.7, pos=4 )

  abline( v=141, col='firebrick', lty=2)

ts_mobility <- lm(Mobility~ nointer_indi+phase_indi_0 + phase_indi_1 +phase_indi_2+phase_indi_3 +phase_indi_4 + phase_indi_5 +days + days1 + days2 + days3 +days4 + days5 + days6 , data=d)

lines( d$days, ts_mobility$fitted.values, col="red", lwd=2 )
axis(1, at=d$days,labels=d$date, col.axis="red", las=2,cex.axis = 0.5)
dev.off()
}