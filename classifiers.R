##### **************************************************
#     CLASSIFICATION ALGORYTHMS
#     MACHINE LEARNING IN PUBLIC HEALTH, SPRING '21
#     FINAL PROJECT
#     LAST EDIT: 2021-05-010 
##### **************************************************

#load libraries
library(MASS)
library(tidyverse)
library(e1071)
library(tree)
library(gbm)


#LOAD DATA
df.mob <- read_csv("https://raw.githubusercontent.com/mp5782/2338-Project/main/data/mobility_class.csv")
mob_smp <- floor(0.75 * nrow(df.mob))
df.case <- read_csv("https://raw.githubusercontent.com/mp5782/2338-Project/main/data/infection_class.csv")
case_smp <- floor(0.75 * nrow(df.case))

## mobility data split
set.seed(123)
train_ind1 <- sample(seq_len(nrow(df.mob)), size = mob_smp)
mobtrain <- df.mob[train_ind1, ]
mobtest <- df.mob[-train_ind1, ]
## case data split
set.seed(123)
train_ind2 <- sample(seq_len(nrow(df.case)), size = case_smp)
casetrain <- df.case[train_ind2, ]
casetest <- df.case[-train_ind2, ]


# Logistic Regression, Mobility
lr.mob <- glm(label_Mobility ~ confirmed_infections + rt + days0 + days1 + days2 +
                days3 + days4 + days5 + days6, family = binomial, data = mobtrain)
summary(lr.mob)

# test the mobility logistic regression
predicted_probs<-predict(lr.mob,mobtest,type="response")
predicted<-predicted_probs>0.5
predicted<-as.numeric(predicted)
confusion_matrix <- table(mobtest$label_Mobility, predicted, dnn = c("Actual", "Predicted"))
confusion_matrix

total<-length(mobtest$label_Mobility) #get the count of all
accuracy<- (confusion_matrix[1,1]+confusion_matrix[2,2])/total
accuracy*100

#**************************************************


# logistic regresssion, infections
lr.case <- glm(label_confirmed_infections ~ Mobility + rt + days0 + days1 + days2 +
                 days3 + days4 + days5 + days6, family = binomial, data = casetrain)
summary(lr.case)

# test the  infection logistic regression
predicted_probs<-predict(lr.case,casetest,type="response")
predicted<-predicted_probs>0.5
predicted<-as.numeric(predicted)
confusion_matrix <- table(casetest$label_confirmed_infections, predicted, dnn = c("Actual", "Predicted"))
confusion_matrix

total<-length(casetest$label_confirmed_infections) #get the count of all
accuracy<- (confusion_matrix[1,1]+confusion_matrix[2,2])/total
accuracy*100

#**************************************************
#LDA, mobility
lda.mob <-lda(label_Mobility ~ confirmed_infections + rt + days0 + days1 + days2 +
                days3 + days4 + days5 + days6,data=mobtrain)
#summary(lda.mob)
lda_predicted <- predict(lda.mob,mobtest)
lda_label =lda_predicted$class
table(mobtest$label_Mobility,lda_label,dnn = c("Actual", "Predicted"))

#test of mobility LDA
accuracy_lda_test <- mean(lda_label==mobtest$label_Mobility)
accuracy_lda_test*100
#**************************************************


#LDA, infections
lda.case <-lda(label_confirmed_infections ~ Mobility + rt + days0 + days1 + days2 +
                 days3 + days4 + days5 + days6,data=casetrain)

lda_predicted <- predict(lda.case,casetest)

lda_label =lda_predicted$class
table(casetest$label_confirmed_infections,lda_label,dnn = c("Actual", "Predicted"))

#test of infection  LDA
accuracy_lda_test <- mean(lda_label==casetest$label_confirmed_infections)
accuracy_lda_test*100
#**************************************************


#svm, mobility
svm_mob <-svm(label_Mobility ~ confirmed_infections + rt + days0 + days1 + days2 +
                 days3 + days4 + days5 + days6,data=mobtrain)
summary(svm_mob)
svm_predicted_probs <- predict(svm_mob,mobtest)
svm_predicted<-svm_predicted_probs>0.5
svm_predicted<-as.numeric(svm_predicted)
confusion_matrix <- table(mobtest$label_Mobility, svm_predicted, dnn = c("Actual", "Predicted"))
confusion_matrix

total<-length(mobtest$label_Mobility) #get the count of all
accuracy<- (confusion_matrix[1,1]+confusion_matrix[2,2])/total
accuracy*100

#**************************************************

#svm, confirmed infections
svm_case <-svm(label_confirmed_infections ~ Mobility + rt + days0 + days1 + days2 +
                 days3 + days4 + days5 + days6,data=casetrain)
summary(svm_case)
svm_predicted_probs <- predict(svm_case,casetest)
svm_predicted<-svm_predicted_probs>0.5
svm_predicted<-as.numeric(svm_predicted)
confusion_matrix <- table(casetest$label_confirmed_infections, svm_predicted, dnn = c("Actual", "Predicted"))
confusion_matrix

total<-length(casetest$label_confirmed_infections) #get the count of all
accuracy<- (confusion_matrix[1,1]+confusion_matrix[2,2])/total
accuracy*100

#**************************************************

#boosting, mobility
boost_model <- gbm(label_Mobility ~ confirmed_infections + rt + days0 + days1 + days2 +
                     days3 + days4 + days5 + days6,data=casetrain, distribution = "bernoulli", n.trees = 1000)
predicted_prob_boost <- predict(boost_model, newdata = casetest, n.trees = 1000)
predicted_label_boost <- ifelse(predicted_prob_boost > 0.5, 1, 0)
confusion_matrix <- table(casetest$label_Mobility, predicted_label_boost)
total<-length(casetest$label_Mobility) #get the count of all
accuracy<- (confusion_matrix[1,1]+confusion_matrix[2,2])/total
accuracy*100
#**************************************************

#boosting, infections
boost_model <- gbm(label_confirmed_infections ~ Mobility + rt + days0 + days1 + days2 +
                     days3 + days4 + days5 + days6,data=casetrain, distribution = "bernoulli", n.trees = 1000)
predicted_prob_boost <- predict(boost_model, newdata = casetest, n.trees = 1000)
predicted_label_boost <- ifelse(predicted_prob_boost > 0.5, 1, 0)
confusion_matrix <- table(casetest$label_confirmed_infections, predicted_label_boost)
total<-length(casetest$label_confirmed_infections) #get the count of all
accuracy<- (confusion_matrix[1,1]+confusion_matrix[2,2])/total
accuracy*100
