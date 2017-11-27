#Gerardo Hidalgo-Cuellar
#November25, 2017
#Titanic Project from Kaggle

#sets the working directory 
setwd("~/Dropbox/kaggle_titanic")

#importing data
train <- read.csv("~/Dropbox/kaggle_titanic/train.csv")
test <- read.csv("~/Dropbox/kaggle_titanic/test.csv")

#adding new columns to the test file with all 0's 
test$Survived <- 0

#changing all females to having lived
test$Survived[test$Sex == 'female'] <- 1
#changing females to those in 3rd class that payed >$20 died
test$Survived[test$Pclass == 3 & test$fare >= 20] <- 0


#saving a new data frame object with just passID and survival status then exporting it as a csv file
submit <- data.frame(PassengerID = test$PassengerId, Survived = test$Survived)
write.csv(submit, file = "females_3class_>20_dead.csv", row.names = FALSE)
