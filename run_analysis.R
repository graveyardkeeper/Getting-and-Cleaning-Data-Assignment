library(dplyr)
# Create a directory to store dataset
if (!file.exists("data")){
        dir.create("data")
}

# download link for dataset
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Download file
download.file(fileUrl,destfile = "./data/dat.zip", mode = "wb")

# Unzip zip file
unzip(zipfile = "./data/dat.zip", exdir = "./data")

# Define the path where unzip data has been stored
datapath <- file.path("./data", "UCI HAR Dataset")

# Create files 
files <- list.files(datapath, recursive = TRUE)

# Check files
files


# 1. Merge the training and the test sets to create one data set.

# Read in train data
X_train <- read.table(file.path(datapath, "train","X_train.txt"), header=FALSE)
y_train <- read.table(file.path(datapath, "train", "y_train.txt"), header = FALSE)
subject_train <- read.table(file.path(datapath, "train", "subject_train.txt"), header = FALSE)

# Read in test data
X_test <- read.table(file.path(datapath, "test", "X_test.txt"), header=FALSE)
y_test <- read.table(file.path(datapath, "test", 'y_test.txt'), header = FALSE)
subject_test <- read.table(file.path(datapath, "test", "subject_test.txt"), header = FALSE)

# Read in features data
features <- read.table(file.path(datapath, "features.txt"), header = FALSE)

# Read in activity lables data
activity_labels <- read.table(file.path(datapath, "activity_labels.txt"), header = FALSE)


# merge train,test,sub data
X_total <- rbind(X_train,   X_test )
y_total <- rbind(y_train, y_test)
sub_total <- rbind(subject_train, subject_test ) 

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
mean_std <- features[grep("mean\\(\\)|std\\(\\)", features[,2]),]
View(mean_std)

X_total <- X_total[, mean_std[,1]]

# 3. Uses descriptive activity names to name the activities in the data set

colnames(y_total) <- "activity"
View(y_total)

y_total$activitylabel <- factor(y_total$activity, labels = as.character(activity_labels[,2]))
activitylabel <- y_total[, -1]

# 4. Appropriately labels the data set with descriptive variable names.
colnames(X_total) <- features[mean_std[,1],2]


# 5. From the data set in step 4, creates a second, independent tidy data set with the average
# of each variable for each activity and each subject.

colnames(sub_total) <- "subject"
total <- cbind(X_total, activitylabel, sub_total)
total_mean <- total %>%
        group_by(activitylabel, subject) %>%
        summarize_each((funs(mean)))
write.table(total_mean, file = "tidydata.txt", row.names = FALSE, col.names = TRUE)



