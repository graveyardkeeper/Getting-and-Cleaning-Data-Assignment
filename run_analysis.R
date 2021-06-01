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
