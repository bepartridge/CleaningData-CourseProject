##The entire dataset should have been unzipped in the working directory with the filepath "./UCI HAR Dataset/".

library(reshape2)

##First the script checks whether the data is in the expected file location, and confirms this in the console.
if(file.exists("UCI HAR Dataset")) {
      "Your data was located and will be tidied momentarily. Please wait."
      } else {
      "Your data could not be found. Please ensure your data has been unzipped in a folder called
      'UCI HAR Dataset' within your working directory."
}

##The script first reads in the test and training data.
trainingdata <- read.table("./UCI HAR Dataset/train/X_train.txt")
testdata <- read.table("./UCI HAR Dataset/test/X_test.txt")

##Both datasets are merged. [COURSERA OBJECTIVE 1]
alldata <- rbind(trainingdata, testdata)

##Read in variable names.
variablenames <- read.table("./UCI HAR Dataset/features.txt")

##Determine which variables represent means or standard deviations. Create vectors with these variables
##listed as indices and as names.
meanandstd_index <- grep("mean|std", variablenames$V2)
meanandstd_names <- grep("mean|std", variablenames$V2, value = TRUE)

##Extract only columns with means or standard deviations from full dataset. [COURSERA OBJECTIVE 2]
meanandstd_data <- alldata[,meanandstd_index]

##Identifiers for the subjects and activities are read in and added to the dataset.
training_subjects <- read.table("./UCI HAR Dataset/train/subject_train.txt")
test_subjects <- read.table("./UCI HAR Dataset/test/subject_test.txt")
all_subjects <- rbind(training_subjects, test_subjects)
training_activities <- read.table("./UCI HAR Dataset/train/y_train.txt")
test_activities <- read.table("./UCI HAR Dataset/test/y_test.txt")
all_activities <- rbind(training_activities, test_activities)
meanandstd_data <- cbind(all_subjects, all_activities, meanandstd_data)

##The activity labels are currently listed as numerals 1 through 6. These must be replaced with descriptive
##activity labels from the dataset. [COURSERA OBJECTIVE 3]
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
meanandstd_data <- merge(activity_labels, meanandstd_data, by.x = 1, by.y = 2)
meanandstd_data <- meanandstd_data[,-1]

##Apply descriptive variable names to data. [COURSERA OBJECTIVE 4]
names(meanandstd_data) <- c("activity", "subject", meanandstd_names)

##Melt the data to obtain a list in which each row is a single experimental observation.
melted_data <- melt(meanandstd_data, id = c("activity", "subject"))

##Cast the data to calculate the mean of each variable, by activity and subject.
means <- dcast(melted_data, activity + subject ~ variable, mean)

#The data set of means is output to a .txt file called 'means.txt'.
write.table(means, "./UCI HAR Dataset/means.txt")


