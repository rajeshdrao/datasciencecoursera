---
title: "Code Book"
author: "Rajesh Rao"
date: "04/04/2021"
output: html_document
---

The run_analysis.R does the data preparation followed by the 5 steps prescribed in the course project instructions.

# It is assumed that data from the zip folder is unzipped in the working directory.

1. Load input data from .txt files to tables
- features <- features.txt : 561 rows, 2 columns
  The List of all features taken from the accelerometer and gyroscope 3-axial raw signals    tAcc-XYZ and tGyro-XYZ.
- activities <- activity_labels.txt : 6 rows, 2 columns
  List of activities performed:Links the class labels with their activity name.
- subject_train <- test/subject_train.txt : 7352 rows, 1 column
  contains train data of 21/30 subjects being observed
- x_train <- test/X_train.txt : 7352 rows, 561 columns
  contains recorded features train data
- y_train <- test/y_train.txt : 7352 rows, 1 columns
  contains train data of activities’code labels
- subject_test <- test/subject_test.txt : 2947 rows, 1 column
  contains test data of 9/30 test subjects being observed
- x_test <- test/X_test.txt : 2947 rows, 561 columns
  contains recorded features test data
- y_test <- test/y_test.txt : 2947 rows, 1 columns
  contains test data of activities’code labels

2. Merge the training and the test sets to create one data set
- X (10299 rows, 561 columns) is created by merging x_train and x_test using rbind()         function.
- y (10299 rows, 1 column) is created by merging y_train and y_test using rbind() function
- subject (10299 rows, 1 column) is created by merging subject_train and subject_test using   rbind() function.
- merged (10299 rows, 563 column) is created by merging subject, Y and X using cbind()       function.

3. Extracts only the measurements on the mean and standard deviation for each measurement
- cleanData (10299 rows, 88 columns) is created by subsetting merged by selecting only       columns subject, code and the measurements having mean and std (standard deviation) in     the name of measurement.

4. Uses descriptive activity names to name the activities in the data set
- The numbers in activityCode column of the cleanData replaced with corresponding activity    description taken from second column of the activities table.

5. Appropriately labels the data set with descriptive variable names
- activityCode column in cleanData renamed into activityType
- Columns starting with character f replaced by Frequency
- Columns starting with character t replaced by Time
- mean in column name replaced by Mean
- std in column name replaced by StandardDeviation
- Acc in column name replaced by Accelerometer
- Gyro in column name replaced by Gyroscope
- BodyBody in column name replaced by Body
- Mag in column name replaced by Magnitude
- angle in column name replaced by Angle
- gravity in column name replaced by Gravity


6. From the data set in step 5, creates a second, independent tidy data set with the average of each variable for each activity and each subject
- TidyData (180 rows, 88 columns) is created by sumarizing cleanData by taking the means of each variable for each activity and each subject. This is done by grouping the cleanData on activityType and subject.
- Export TidyData into TidyData.txt file.
- The code also opens the TidyData for viewing using View().