## Getting and Cleaning Data Course Project
##
## Assignment:
##
##   You should create one R script called run_analysis.R that does the following:
## 1.Merges the training and the test sets to create one data set.
## 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3.Uses descriptive activity names to name the activities in the data set
## 4.Appropriately labels the data set with descriptive variable names. 
## 5.From the data set in step 4, creates a second, independent tidy data set with the average 
##  of each variable for each activity and each subject.
## 
#
# General info. 
#
# Source raw data.
# 
# Unzipped data set location is in RStudio working directory: UCI_HAR_Dataset\.
# Main data are in plain text files test\X_test.txt and train\X_train.txt.
# Activity and subject independent variables are in separate text files 
#  *\y_*.txt and *\subject_*.txt correspondingly.
# Variable names in raw form are in features.txt.
# Activity names are in activity_labels.txt. 
#
# All other files are documentation and also low-level raw data in *\Inertial Signals\ folders 
# which weren't processed in the frame of this assignment.
#
# Tools used.
#
# Mostly R standard possibilities were used.
# Also dplyr package was used at the last part of this script to make a final touch on tidy data.
#

# 1.Merges the training and the test sets to create one data set.

# 1.1. Merge activities
y_test <- read.table("UCI_HAR_Dataset\\test\\y_test.txt")
y_train <- read.table("UCI_HAR_Dataset\\train\\y_train.txt")
y <- rbind(y_test, y_train)

# 1.2. Merge subjects
subject_test <- read.table("UCI_HAR_Dataset\\test\\subject_test.txt")
subject_train <- read.table("UCI_HAR_Dataset\\train\\subject_train.txt")
subject <- rbind(subject_test, subject_train)

# 1.3. Merge main data
X_test <- read.table("UCI_HAR_Dataset\\test\\X_test.txt")
X_train <- read.table("UCI_HAR_Dataset\\train\\X_train.txt")
X <- rbind(X_test, X_train)

# 4.Appropriately labels the data set with descriptive variable names. 
# This step was made before step 2 because it makes it easier to do next step.
features <- read.table("UCI_HAR_Dataset\\features.txt")
fnames <- features[,2]
fnames <- make.names(names=fnames, unique=TRUE, allow_=TRUE) # this line convert names in R format
names(X) <- fnames

# 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
# dplyr package is used from this step
library(dplyr)

X <- select(X, matches("mean|std", ignore.case = TRUE))

# 3.Uses descriptive activity names to name the activities in the data set
#  Also activity and subject columns added at this step below.
activity_labels <- read.table("UCI_HAR_Dataset\\activity_labels.txt")[,2] # activity names preparation

X <- mutate(X, activity=sapply(y[,1], function(i){activity_labels[i]}), subject=subject[,1])

## 5.From the data set in step 4, creates a second, independent tidy data set with the average 
##  of each variable for each activity and each subject.
tidy_data<-aggregate(X, list(Activity=X$activity, Subject=X$subject), mean)

tidy_data<-select(tidy_data, -activity, -subject) # this line removes duplicated columns which don't need anymore

write.table(tidy_data,"tidy_data.txt",row.name=FALSE)

# The END.
