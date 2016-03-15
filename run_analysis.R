library(plyr)
##DOWNLOAD FILE
download_data = function() {
     if (!file.exists("data")) {dir.create("data")}
     if (!file.exists("data/UCI HAR Dataset")) {
          fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
          zipfile="data/UCI_HAR_data.zip"
          download.file(fileURL, destfile=zipfile)
          unzip(zipfile, exdir="data")
     }
}

##READ/MERGE THE DATA
merge_datasets = function() {
     ##READ
     training_x <- read.table("data/UCI HAR Dataset/train/X_train.txt")
     training_y <- read.table("data/UCI HAR Dataset/train/y_train.txt")
     training_subject <- read.table("data/UCI HAR Dataset/train/subject_train.txt")
     test_x <- read.table("data/UCI HAR Dataset/test/X_test.txt")
     test_y <- read.table("data/UCI HAR Dataset/test/y_test.txt")
     test_subject <- read.table("data/UCI HAR Dataset/test/subject_test.txt")
     
     ##MERGE
     merged_x <- rbind(training_x, test_x)
     merged_y <- rbind(training_y, test_y)
     merged_subject <- rbind(training_subject, test_subject)
     list(x=merged_x, y=merged_y, subject=merged_subject)
}

##EXTRACT ONLY THE MEASUREMENTS ON THE MEAN AND STD DEVIATION FOR EACH MEASUREMENT
calculate_mean_and_std = function(df) {
     features <- read.table("data/UCI HAR Dataset/features.txt")
     mean_col <- sapply(features[,2], function(x) grepl("mean()", x, fixed=TRUE))
     std_col <- sapply(features[,2], function(x) grepl("std()", x, fixed=TRUE))
     extracted <- df[, (mean_col | std_col)]
     colnames(extracted) <- features[(mean_col | std_col), 2]
}

##USE DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE DATA SET
name_activities = function(df) {
     colnames(df) <- "activity"
     df$activity[df$activity == 1] = "WALKING"
     df$activity[df$activity == 2] = "WALKING_UPSTAIRS"
     df$activity[df$activity == 3] = "WALKING_DOWNSTAIRS"
     df$activity[df$activity == 4] = "SITTING"
     df$activity[df$activity == 5] = "STANDING"
     df$activity[df$activity == 6] = "LAYING"
}

##CREATE ONE DATA FRAME WITH X, Y, AND SUBJECTS TOGETHER
merged_xysubjects <- function(x, y, subjects) {
     cbind(x, y, subjects)
}

##CREATE TIDY DATA SET WITH AVG OF EACH VARIABLE FOR EACH ACTIVITY & SUBJECT
create_tidy_dataset = function(df) {
     tidy <- ddply(df, .(subject, activity), function(x) colMeans(x[,1:60]))
}

## step 0
download_data()

## step 1
merged <- merge_datasets()
View(merged)

# step 2
col_x <- calculate_mean_and_std(merged$x)

##step 3
col_y <- name_activities(merged$y)

colnames(merged$subject) <- c("subject")

combined <- merged_xysubjects(col_x, col_y, merged$subject)
head(combined, 1)

write.csv(tidy, "UCI_tidy.csv", row.names=FALSE)
