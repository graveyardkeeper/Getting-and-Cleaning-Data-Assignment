The run_analysis.R script performs the data preparation and then followed by the 5 steps required as described in the course project’s definition.

### Motivation
- First, download and unzip the data file.
- Second, define the path where unzip data has been stored.
- Third, read in datasets.
- Finally, merge datasets by using rbind() %>% extract only measurements on mean and std by using regular expression %>% use dplyr to  generate tidy data file.


#### 1. Create the directory and download the dataset

if (!file.exists("data")){
        dir.create("data")
}










