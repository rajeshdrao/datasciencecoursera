Peer-graded Assignment: Getting and Cleaning Data Course Project

This file descirbes how the script works for the analysis on Human Activity recognition dataset.

Dataset:
Human Activity Recognition Using Smartphones
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 


Files:
CodeBook.md is a code book the describes all the variables and summaries calculated, along with units, and any other relevant information.

- run_analysis.R does the data preparation followed by the 5 steps prescribed in the course project instructions.

1.Merges the training and the test sets to create one data set.
2.Extracts only the measurements on the mean and standard deviation for each measurement. 
3.Uses descriptive activity names to name the activities in the data set
4.Appropriately labels the data set with descriptive variable names. 
5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

TidyData.txt is the clean data exported after peroforming all the steps described above.