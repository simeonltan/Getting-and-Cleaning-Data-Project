This is a guide to the run_analysis.R code.

To run this R code, you will need to make sure that the Samsung data is unzipped and in the working directory.  
The Samsung data can be downloaded from 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Use the following command in RStudio to run the code:
source("run_analysis.R")

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
