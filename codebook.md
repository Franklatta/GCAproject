---
title: "codebook.md"
output: html_document
---

# Getting and Cleaning Data Project

### Description
Information about the variables, data and transformations used in the course project for the Johns Hopkins Getting and Cleaning Data course.

### Source Data
The full description of the dataset used in this project can be found at The [UCI Machine Learning Repository](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

These files of the dataset are needed in this project
* features.txt

* activity_labels.txt
* subject_train.txt
* x_train.txt
* y_train.txt
* subject_test.txt
* x_test.txt
* y_test.txt


### Procedure 
Import the the files with rstudio -> Tools -> Import dataset -> From Text File
Run the script run_analysis.R. The script does the followings steps

1. After importing the files assign column names and merge to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement. 
3. use descriptive activity names to name the activities in the data set
4. Creates a second tidy data set with the mean of each variable for each activity and each subject. 
  