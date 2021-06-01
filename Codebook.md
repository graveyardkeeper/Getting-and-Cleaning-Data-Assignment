The run_analysis.R script performs the data preparation and then followed by the 5 steps required as described in the course project’s definition.

### Motivation
- First, download and unzip the data file.
- Second, define the path where unzip data has been stored.
- Third, read in datasets.
- Finally, merge datasets by using rbind() %>% extract only measurements on mean and std by using regular expression %>% use dplyr to  generate tidy data file.


#### 1. Create directory and download the dataset

- This script create directory to store `UCI HAR Dataset`.
`if` (!`file.exists`("data")){
        `dir.create`("data")
}

- This script download data for project.
`download.file`(url,`destfile` = "./data/dat.zip", `mode` = "wb")

- This script unzip downloaded zip file `unzip`(`zipfile` = "./data/dat.zip", `exdir` = "./data")

#### 2. Merge train and test datasets to get one dataset

- This scripts read in require data and store in variables.
`X_train` <- `read.table`(`file.path`(datapath, "train","X_train.txt"), `header`=`FALSE`)
`X_test` <- `read.table`(`file.path`(datapath, "test", "X_test.txt"), `header`=`FALSE`)

- This scripts merge datasets by using rbind function.
`X_total` <- `rbind`(X_train,   X_test )
`y_total` <- ``rbind`(y_train, y_test)
`sub_total` <- `rbind`(subject_train, subject_test ) 

#### 3. Extracts only the measurements on the mean and standard deviation for each measurement.

- This script extract only measurements on mean and standard deviation using regular expression. 
`mean_std` <- `features`[`grep`("mean\\(\\)|std\\(\\)", features[,2]),]
We can check the extracted data writing. 
`View(mean_std)`

#### 4. Uses descriptive activity names to name the activities in the data set
- This script will  name the column of merged y dataset.
`colnames`(y_total) <- "activity"

- Finally this script give the result as instruction asked. `y_total`$activitylabel <- factor(y_total$activity, `labels` = `as.character`(activity_labels[,2]))
`activitylabe`l <- y_total[, -1]

#### 5. Appropriately labels the data set with descriptive variable names.
- This script will label the datset with appropriate variable names         `colnames`(X_total) <- `features`[mean_std[,1],2]

####  6. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

- Following scripts will create the final Tidy Data. 
- name "subject"" to sub_total column.
`colnames`(sub_total) <- "subject"

- Merge datasets
total <- `cbind`(X_total, activitylabel, sub_total)

- group by activity label and subject %>% summarize by mean.
total_mean <- total `%>%`
        `group_by`(activitylabel, subject) `%>%`
        `summarize_each`((`funs`(mean)))
#### Final Step
- write Tidy Data and export tidydata.txt.
write.table(total_mean, file = "tidydata.txt", row.names = FALSE, col.names = TRUE)







