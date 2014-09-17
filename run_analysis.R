###############################################################################
## GETTING AND CLEANING DATA - COURSE PROJECT
## File Name : run_analysis.R (written on windows7)
## Writer : Simeon Tan
## Last Update : 13 Sept 2014
##
###############################################################################

library(dplyr)

###############################################################################
## Preparation
##
## Please make sure the Samsung data is unzipped and in the working directory
##
## Read files to data frame
##   - activity_labels_txt      ACTIVITY LABELS - 6x2
##   - features.txt             FEATURES        - 561x2
##
##   - subject_test.txt         TEST SUBJECT    - 2947x1
##   - X_test.txt               TEST SET        - 2947x561
##   - y_test.txt               TEST LABELS     - 2947x1
##
##   - subject_train.txt        TRAIN SUBJECT   - 7352x1
##   - X_train.txt              TRAIN SET       - 7352x561
##   - y_train.txt              TRAIN LABELS    - 7352x1
##
## Set names for the following:
##   - activity labels
##   - subject test
##   - X data
##   - y data
###############################################################################

activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
names(activityLabels) <- c("label", "activity")

features <- read.table("./UCI HAR Dataset/features.txt")

subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
df_subjectTest <- tbl_df(subjectTest)
names(df_subjectTest) <- "subject"

XTest <- read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE, sep="")
df_XTest <- tbl_df(XTest)
names(df_XTest) <- as.character(features[,2])

yTest <- read.table("./UCI HAR Dataset/test/y_test.txt")
df_yTest <- tbl_df(yTest)
names(df_yTest) <- "label"

subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
df_subjectTrain <- tbl_df(subjectTrain)
names(df_subjectTrain) <- "subject"

XTrain <- read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE, sep="")
df_XTrain <- tbl_df(XTrain)
names(df_XTrain) <- as.character(features[,2])

yTrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
df_yTrain <- tbl_df(yTrain)
names(df_yTrain) <- "label"


###############################################################################
## 1. Merges the training and the test sets to create one data set.
###############################################################################

df_Xdata   <- rbind(df_XTrain, df_XTest)                # 10299x561
df_subject <- rbind(df_subjectTrain, df_subjectTest)    # 10299x1
df_ydata   <- rbind(df_yTrain, df_yTest)                # 10299x1

oneData <- cbind(df_subject, df_ydata, df_Xdata)        # 10299x563


###############################################################################
## 2. Extracts only the measurements on the mean and standard deviation 
##    for each measurement.
##    
##    Filter column of features for required measurements
##      - mean and standard deviation
##      - adjust for 1st two columns - Subject, Label
##    Extract required measure from merged data
###############################################################################

colMeanStd <- grep("mean\\(", features[,2], ignore.case=TRUE)
colMeanStd <- c(colMeanStd, grep("std\\(", features[,2], ignore.case=TRUE))
colMeanStd <- colMeanStd+2                  # adjust for 2 additional columns
colMeanStd <- c(colMeanStd, 1, 2)           # add Subject and Label columns
colMeanStd <- sort(colMeanStd)                          # 68 element

oneData <- tbl_df(oneData[,colMeanStd])                 # 10299x68


###############################################################################
## 3. Uses descriptive activity names to name the activities in the data set.
###############################################################################

oneData <- mutate(oneData, tempactivity=activityLabels[label,2])
oneData[,2] <- select(oneData, tempactivity)
colnames(oneData) [2] <- "activity"

oneData <- select(oneData, -tempactivity)               # 10299x68


###############################################################################
## 4. Appropriately labels the data set with descriptive variable names.
###############################################################################

newnames <- names(oneData)
newnames <- gsub("-","",newnames)                   # remove '-' hyphen
newnames <- gsub("mean\\(\\)","Mean",newnames)      # change 'mean()' to 'Mean
newnames <- gsub("std\\(\\)","StdDev",newnames)     # change 'std()' to 'Std'
newnames <- gsub("BodyBody", "Body", newnames)      # change 'BodyBody' to 'Body'
newnames <- gsub("^t", "time", newnames)            # change 't' to time
newnames <- gsub("^f", "freq", newnames)            # change 'f' to freq

names(oneData) <- newnames

###############################################################################
## 5. From the data set in step 4, creates a second, independent tidy data 
##    set with the average of each variable for each activity and each subject.
###############################################################################

tidyData = aggregate(oneData, by=list(subject=oneData$subject, 
                                  activity=oneData$activity), mean)

tidy <- tbl_df(tidyData)
tidy <- select(tidy, -subject, -activity)   # tested and observed that it
                                            # deletes the redundant
                                            # subject, activity

write.table(tidy, file = "tidy.txt", row.name=FALSE)

## testread <- read.table("./tidy.txt", header=TRUE)
## dim(testread)
