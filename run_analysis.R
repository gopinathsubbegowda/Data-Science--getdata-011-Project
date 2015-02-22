## Set the Working Directory to an appropriate directory.
## setwd("C:/Users/gops/Documents/data") 

## Load the necessary packages

library(plyr)
library(dplyr)
library(reshape2)

##1. SubjectTestData -These are the people in the TestData set...Dimensions 1 column x 2947 rows

SubjectTestData <- read.table("subject_test.txt")

##2. SubjectTrainData- These are the people in the TrainData set..Dimensions 1 column x 7352 rows

SubjectTrainData <- read.table("subject_train.txt")

##3. TotalSubjectData................Dimensions 1 column x 10299 rows

TotalSubjectData <- rbind(SubjectTestData, SubjectTrainData)

names(TotalSubjectData) <- c("Subject")

##1. X_testData -................... Dimensions 561 columns x 2947 rows

X_testData <- read.table("X_test.txt")

##2. X_trainData -................... Dimensions 561 columns x 7352 rows

X_trainData <- read.table("X_train.txt")

##3. TotalData.........................Dimensions 561 columns x 10299 rows

TotalData <- rbind(X_testData, X_trainData)

##1. y_testData -................... Dimensions 1 columns x 2947 rows

y_testData <- read.table("y_test.txt")

##2. y_trainData -................... Dimensions 1 columns x 7352 rows

y_trainData <- read.table("y_train.txt")

##3. TotalData.........................Dimensions 1 columns x 10299 rows

ActivityData <- rbind(y_testData, y_trainData)

names(ActivityData) <- c("Activity")

##1. features-................... Dimensions 1 columns x 2947 rows

features <- read.table("features.txt")

featureData <- features[,2, drop = TRUE]

## Put Together the final data

FinalData <- cbind(TotalSubjectData, ActivityData)

FinalData <- cbind.data.frame(FinalData, TotalData)

##Eliminate the Duplicate Column names as they would create problem later during further Tidying

FinalData1 <- FinalData[ !duplicated(names(FinalData)) ]

##Group by Subject and Activity in order to achieve the maen and SD measures

extract_Data <- select(.data = FinalData1, Subject, Activity, matches("(mean|std)\\(.*\\)"))

extract_Data %>% group_by(Activity,Subject) %>% summarise_each(funs(mean))

### Set the Activity names for the Activity IDs as we missed it in the initial stages

var4d <- c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")

for (i in 1:6){
        ind <- extract_Data$Activity %in% i
        
        extract_Data[ind, 2] <- var4d[i]
}

##Write the file to the system 

write.table(extract_Data, file = "extract_Data.txt", col.names=FALSE)


##FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEND-OF-FILEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF

