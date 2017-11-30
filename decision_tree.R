#Gerardo Hidalgo-Cuellar
#November25, 2017
#Titanic Project from Kaggle, decision tree tutorial

#sets the working directory 
setwd("~/Dropbox/kaggle_titanic")

#import libraries
library(rattle)
library(rpart.plot)
library(RColorBrewer)
library(rpart)

#importing data
train <- read.csv("~/Dropbox/kaggle_titanic/train.csv")
test <- read.csv("~/Dropbox/kaggle_titanic/test.csv")

#setting up a fit using rpart
fit <- rpart(Survived ~ Pclass + Age + Sex + SibSp + Parch + Fare + Embarked,
             data = train,
             method = "class")

#showing data
#fancyRpartPlot(fit)

#writing data out to a csv file
Prediction <- predict(fit, test, type = "class")
submit <- data.frame(PassengerId = test$PassengerId, Survived = Prediction)
write.csv(submit, file = "firstdecisiontreesub.csv", row.names = FALSE)

