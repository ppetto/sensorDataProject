## read three test files into dataframes

subjectTest1 <- read.table("./UCI HAR Dataset/test/subject_test.txt")
Xtest1 <- read.table("./UCI HAR Dataset/test/X_test.txt")
Ytest1 <- read.table("./UCI HAR Dataset/test/Y_test.txt")

## read three training files into dataframes

subjectTest2 <- read.table("./UCI HAR Dataset/train/subject_train.txt")
Xtest2 <- read.table("./UCI HAR Dataset/train/X_train.txt")
Ytest2 <- read.table("./UCI HAR Dataset/train/Y_train.txt")

## merge test and training dataframes into three comprehensive dataframes

subjectTest <- rbind(subjectTest1, subjectTest2)
Xtest <- rbind(Xtest1, Xtest2)
Ytest <- rbind(Ytest1, Ytest2)

## provide meaningful names for each data column

names(subjectTest)[1] <- "subject"
measurement_name <- read.table("./UCI HAR Dataset/features.txt")
names(Xtest)[1:561] <- as.character(measurement_name$V2)
names(Ytest)[1] <- "test"

## merge three files into one master dataframe

sensorData <- cbind(subjectTest, Ytest, Xtest)

## create smaller dataframe containing only subject, test,
## and measurements of means and standard deviations

extractedData <- sensorData[c(1, 2, grep("mean|std", names(sensorData)))]

## loop through extractedData dataframe replace each set of individual observations
## with an average -- for each activity-subject pair

tidyData <- data.frame(matrix(NA, nrow=0, ncol=81))
names(tidyData)[1:81] <- names(extractedData)


for (sIndex in 1:30) {
      for (tIndex in 1:6) {
            tidyData <- rbind(tidyData, colMeans(subset(extractedData, subject == sIndex & test == tIndex)))
      }
}