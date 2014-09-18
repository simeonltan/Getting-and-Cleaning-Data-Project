Introduction
============

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

The following are the output of this project:
1) a tidy data set - "tidy.txt"
2) this Github repository with the script for performing the analysis called 'run_analysis.R'.
3) a code book that describes the variables, the data, and any transformations or work that was performed to clean up the data called CodeBook.md.
4) This README.md is also part of the output of the project. It explains how all of the scripts work and how they are connected.  


This is a guide to run_analysis.R
=================================

To run this R code, you will need to make sure that the Samsung data is unzipped and in the working directory.  
The Samsung data can be downloaded from 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
After unzipping the file, you will have a directory 'UCI HAR Dataset' with two subdirectories:
- test
- train

Use the following command in RStudio to run the code: source("run_analysis.R")

The following explains what run_analysis.R do:

1. Load "dplyr".  
If dplyr is not installed in your RStudio, you will need to install the dplyr package.  This can be done in the RStudio under Tools->Install Packages.
I used dplyr to make table manipulation easier as well as to practice dplyr data manipulations.

2. Preparation.
This read the required files to several data frames.
I also put in the names of the columns in the data frame.

3. Merges the training and the test sets to create one data set.

4. Extracts only the measurements on the mean and standard deviation for each measurement.

5. Uses descriptive activity names to name the activities in the data set.

6. Appropriately labels the data set with descriptive variable names.

7. From the data set in step 6, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
The tidy data set is called 'tidy.txt'.
