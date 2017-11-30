#Gerardo Hidalgo-Cuellar
#November 29, 2017
#Titanic Project from Kaggle, feature engineering tutorial

#sets the working directory 
setwd("~/Dropbox/kaggle_titanic")

#importing data
train <- read.csv("~/Dropbox/kaggle_titanic/train.csv")
test <- read.csv("~/Dropbox/kaggle_titanic/test.csv")

#making a new dataframe combining the test and training data
test$Survived <- NA
combi <- rbind(train, test)
combi$Name <- as.character(combi$Name) #converting names from catagory to strings

#taking the title from the name function and creating a new column
combi$Title <- sapply(combi$Name, FUN=function(x) {strsplit(x, split='[,.]')[[1]][2]})
combi$Title <- sub(' ', '', combi$Title)

#combining some different titles that arent very signif.
combi$Title[combi$Title %in% c('Mme', 'Mlle')] <- 'Mlle'
combi$Title[combi$Title %in% c('Capt', 'Don', 'Major', 'Sir')] <- 'Sir'
combi$Title[combi$Title %in% c('Dona', 'Jonkheer', 'Lady', 'the Countess')] <- 'Lady'

#changing the title catagory back into factor instead of strings
combi$Title <- factor(combi$Title)

#making a family size column
combi$FamilySize <- combi$SibSp + combi$Parch + 1

#making a surname column by stripping the name column
combi$Surname <- sapply(combi$Name, FUN=function(x) {strsplit(x, split='[,.]')[[1]][1]})

#making a familyID column which gives family size next to surname, then specify small families
combi$FamilyID <- paste(as.character(combi$FamilySize), combi$Surname, sep="")
combi$FamilyID[combi$FamilySize <= 2] <- 'Small'

#repairing family size (bc of different last names)
famIDs <- data.frame(table(combi$FamilyID)) #temp table  with family size
famIDs <- famIDs[famIDs$Freq <= 2,] #subsetting those with fam sizes <= 2
combi$FamilyID[combi$FamilyID %in% famIDs$Var1] <- 'Small' #resetting those families in combi$famliyID using the temp table we made
combi$FamilyID <- factor(combi$FamilyID) #turning familyID into factor




