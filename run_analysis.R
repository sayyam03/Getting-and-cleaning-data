rm(list=ls())

library(tidyverse)
library(reshape2)

filename <- "getdata_dataset.zip"

## Download and unzip the dataset if not present in current wd
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename, method="curl")
}
if (!file.exists("UCI HAR Dataset")) {
  unzip(filename)
}

# Loading activity labels and features
activity <- read.table("UCI HAR Dataset/activity_labels.txt")
x <- as.character(activity$V2)
features <- read.table("UCI HAR Dataset/features.txt")
y <- as.character(features$V2)

# Extract only the data on mean and standard deviation
reqf <- grep(".*mean.*|.*std.*", y)
reqf_n <- y[reqf]
reqf_n <- gsub('-mean', 'mean', reqf_n)
reqf_n <- gsub('-std', 'std', reqf_n)
reqf_n <- gsub('[-()]', '', reqf_n)


# Load the datasets
train <- read.table("UCI HAR Dataset/train/X_train.txt")[reqf]
trainA <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainS <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainS, trainA, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[reqf]
testA <- read.table("UCI HAR Dataset/test/Y_test.txt")
testS <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testS, testA, test)

# merge datasets and add labels
reqdata <- rbind(train, test)
colnames(reqdata) <- c("subject", "activity", reqf_n)

# turn activities & subjects into factors
reqdata$activity <- factor(reqdata$activity, levels = activity[,1], labels = x)
reqdata$subject <- as.factor(reqdata$subject)

allData <- melt(reqdata, id = c("subject", "activity"))
allData.mean <- dcast(allData, subject + activity ~ variable, mean)

##returning a txt file
write.table(allData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)

##removing all unnecessary files.
rm(activity,allData,features,test,testA,testS,train,trainA,trainS,filename,
   reqf, req_n,x,y,reqf_n)
