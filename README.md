# Project_course3
Data Science Specialization. Final Project Course 3 - Getting and Cleanning Data

## PROJECT DELIVERABLES 
 1) a tidy data set as described below
 2) a link to a Github repository with your script for performing the analysis, and
 3) a code book that describes the variables, the data, and any transformations or
         work that you performed to clean up the data called CodeBook.md
 4) You should also include a README.md in the repo with your scripts.
         This repo explains how all of the scripts work and how they are connected.

 ## Create one R script called run_analysis.R that does the following:

 1) Merges the training and the test sets to create one data set.
 2) Extracts ONLY the measurements on the mean and standard deviation for each measurement.
 3) Uses descriptive activity names to name the activities in the data set
 4) Appropriately labels the data set with descriptive variable names.
 5) From the data set in step 4, creates a second, independent tidy data set with the average
     of each variable for each activity and each subject.

 ## DATA ACQUISITION DESCRIPTION  
 group of 30 volunteers
 age bracket of 1948 years
 Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
 captured 3axial linear acceleration and 3axial angular velocity at a constant rate of 50Hz
 2 data sets: 70% Volunteers for Training data, 30% for Test data (same type of data)

 ## Files description 
  * features_info.txt': Shows information about the variables used on the feature vector.

  * features.txt': List of all features.

  * activity_labels.txt': Links the class labels with their activity name.

  * train/X_train.txt': Training set.

  * train/y_train.txt': Training labels.

  * test/X_test.txt': Test set.

  * test/y_test.txt': Test labels.

  * train/subject_train.txt': Each row identifies the subject who performed
       the activity for each window sample. Its range is from 1 to 30.

 ## Answers
 Answers/New_tidy_data_grouped.csv: Tidy data grouped by Subject and Activity showing the Average vale of each variable
 Answers/merged_data.csv: File with Test and Trainning information together and with all the variables named. Y data is also inclued
