# Data-Science--getdata-011-Project
Week 3 - Getting and Cleaning Data Course:
Course Project Assignment

Data Set Information:
==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================
NOTE: Please look into the README file from the site -

A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
================================================================== 

As part of the project we should create one R script called run_analysis.R that does the following.
 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## Set the Working Directory to an appropriate directory where it will be easy to read the file downloaded and extracted.
setwd("C:/Users/gops/Documents/data") 

## Load the necessary packages

For Example:

library(plyr)
library(dplyr)
library(reshape2)

=========================================================================
SubjectTrainData- These are the people in the TrainData set.....Dimensions 1 column x 7352 rows
SubjectTestData -These are the people in the TestData set... ...Dimensions 1 column x 2947 rows

TotalSubjectTestPlusTrain.......................................Dimensions 1 column x 10299 rows
=========================================================================
TestData -......................................................Dimensions 561 columns x 2947 rows
TrainData -.....................................................Dimensions 561 columns x 7352 rows

TotalTestPlusTrain..............................................Dimensions 561 columns x 10299 rows
=========================================================================

===================================================================
SUBJECT DATA:
===================================================================
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
##1. SubjectTestData -These are the people in the TestData set...Dimensions 1 column x 2947 rows
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
SubjectTestData <- read.table("subject_test.txt")

> dim(SubjectTestData)
[1] 2947    1
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
##2. SubjectTrainData- These are the people in the TrainData set..Dimensions 1 column x 7352 rows
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
SubjectTrainData <- read.table("subject_train.txt")

> dim(SubjectTrainData)
[1] 7352    1
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
##3. TotalSubjectData................Dimensions 1 column x 10299 rows
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
TotalSubjectData <- rbind(SubjectTestData, SubjectTrainData)

> dim(TotalSubjectData)
[1] 10299     1

names(TotalSubjectData) <- c("Subject")

===================================================================
MEASURE DATA:
===================================================================
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
##1. X_testData -................... Dimensions 561 columns x 2947 rows
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
X_testData <- read.table("X_test.txt")

> dim(X_testData)
[1] 2947  561
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
##2. X_trainData -................... Dimensions 561 columns x 7352 rows
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
X_trainData <- read.table("X_train.txt")

> dim(X_trainData)
[1] 7352  561
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
##3. TotalData.........................Dimensions 561 columns x 10299 rows
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
TotalData <- rbind(X_testData, X_trainData)

> dim(TotalData)
[1] 10299   561

===================================================================
ACTIVITY DATA:
===================================================================
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
##1. y_testData -................... Dimensions 1 columns x 2947 rows
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
y_testData <- read.table("y_test.txt")

> dim(y_testData)
[1] 2947    1
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
##2. y_trainData -................... Dimensions 1 columns x 7352 rows
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
y_trainData <- read.table("y_train.txt")

> dim(y_trainData)
[1] 7352    1
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
##3. TotalData.........................Dimensions 1 columns x 10299 rows
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
ActivityData <- rbind(y_testData, y_trainData)

> dim(ActivityData)
[1] 10299     1

names(ActivityData) <- c("Activity")

===================================================================
FEATURES DATA:
===================================================================
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
##1. features-................... Dimensions 1 columns x 2947 rows
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
features <- read.table("features.txt")

> dim(features)
[1] 561   2

featureData <- features[,2, drop = TRUE]

> dim(featureData)
[1] 561   1
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
TIP :
Vectors and matrices can only be of a single type and cbind and rbind on vectors will give matrices. 
In these cases, the numeric values will be promoted to character values since that type will hold all the values.
or (using cbind, but making the first a data.frame so that it combines as data.frames do):
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

====================================================================
PUT ALL THE DATA TOGETHER AND TIDY THE DATA:
====================================================================
FinalData <- cbind(TotalSubjectData, ActivityData)

FinalData <- cbind.data.frame(FinalData, TotalData)

> dim(FinalData)
[1] 10299   563

##Eliminate the Duplicate Column names as they would create problem later during further Tidying

FinalData1 <- FinalData[ !duplicated(names(FinalData)) ]

##Group by Subject and Activity in order to achieve the maen and SD measures

extract_Data <- select(.data = FinalData1, Subject, Activity, matches("(mean|std)\\(.*\\)"))

__________________________________
__________________________________
#FinalData1 %>% group_by(Activity,Subject) %>% summarise_each(funs(mean))

#> dim(FinalData1)
#[1] 10299   479
__________________________________
__________________________________

extract_Data %>% group_by(Activity,Subject) %>% summarise_each(funs(mean))

> dim(extract_Data)
[1] 10299    68

##Write the file to the system 

write.table(extract_Data, file = "extract_Data.txt", col.names=FALSE)

Tidy DataSet : extract_Data
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEND-OF-FILEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF

### Set the Activity names for the Activity IDs
var4d <- c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")
for (i in 1:6){
        ind <- extract_Data$Activity %in% i
        
        extract_Data[ind, 2] <- var4d[i]
}

###Write the file to the system 

write.table(extract_Data, file = "extract_Data.txt", col.names=FALSE)


Final Data has Activity numbers -
Update Activity names in FinalData

FinalTidyData = (Volunteer, Activity, variable, mean)

extract_Data <- select(.data = FinalData1, Subject, Activity, matches("(mean|std)\\(.*\\)"))

FinalData %>% group_by(Activity,subject) %>% summarise_each(funs(mean))

extract_Data <- select(.data = FinalData1, Subject, Activity, matches("(mean|std)\\(.*\\)"))

Finding those entries that involve mean and std dev, and of those entries calculate the mean of each combination of subject/ activity/ and measurement.


4) Have you looked at this function: ?grep
    grep against a character vector returns the matching indices... if those indices are your column numbers... you could just plug the result into a dataframe's column selection index slot: df[,grep("foo",names(df))]

DT %>% group_by(activity,subject) %>% summarise_each(funs(mean))

DT %>% group_by(activity.name,subject) %>% summarise_each(funs(mean))



+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++




