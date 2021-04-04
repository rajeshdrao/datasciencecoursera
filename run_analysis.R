runanalysis<-function(){
  #load the required libraries
  library(dplyr)
  
  filename <- "UCI HAR Dataset.zip"
  
  # Checking if zip file is already downloaded.
  if (!file.exists(filename)){
    URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(URL, filename)
  }  
  
  # Checking if destination folder exists
  if (!file.exists("UCI HAR Dataset")) { 
    unzip(filename) 
  }

  ##load the downloaded files to data frames
  features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","measures"))
  activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("activityCode", "activity"))
  #load train datasets
  subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
  x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$measures)
  y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activityCode")
  #load test datasets
  subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
  x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$measures)
  y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activityCode")
  
  ### Final Steps
  #1) Merge the training and test data sets to create one data set
  X<-rbind(x_train, x_test)
  y<-rbind(y_train, y_test)
  subject <- rbind(subject_train, subject_test)
  
  merged <- cbind(subject, X,y)
  
  #2) Extract only the measurements on the mean and standard deviation for each measurement
  cleanData <- merged %>% select(subject,activityCode,contains("mean"),contains("std"))
  
  #3) Use descriptive activity names to name the activities in the data set
  #map the activity description to code
  cleanData$activityCode <-activities[cleanData$activityCode,2]
  
  #4) Lable the dataset with descriptove variable names.
  
  names(cleanData)[2] = "activityType"
  names(cleanData)<-gsub("^t", "Time", names(cleanData))
  names(cleanData)<-gsub("^f", "Frequency", names(cleanData))
  names(cleanData)<-gsub("-mean()", "Mean", names(cleanData), ignore.case = TRUE)
  names(cleanData)<-gsub("-std()", "StandardDeviation", names(cleanData), ignore.case = TRUE)
  names(cleanData)<-gsub("std", "StandardDeviation", names(cleanData), ignore.case = TRUE)
  names(cleanData)<-gsub("-freq()", "Frequency", names(cleanData), ignore.case = TRUE)
  names(cleanData)<-gsub("tBody", "TimeBody", names(cleanData))
  names(cleanData)<-gsub("Acc", "Accelerometer", names(cleanData))
  names(cleanData)<-gsub("Gyro", "Gyroscope", names(cleanData))
  names(cleanData)<-gsub("BodyBody", "Body", names(cleanData))
  names(cleanData)<-gsub("Mag", "Magnitude", names(cleanData))
  names(cleanData)<-gsub("angle", "Angle", names(cleanData))
  names(cleanData)<-gsub("gravity", "Gravity", names(cleanData))
  
  #5) From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
  TidyData <- cleanData %>%
    group_by(activityType,subject) %>%
    summarize_all(funs(mean))
  
  write.table(TidyData, "TidyData.txt", row.name=FALSE)
 
  View(TidyData) 
  
}