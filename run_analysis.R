# run _analysis.R
# getting and cleaning data project assignment

library(reshape2)


# Haal de data op enpak de zip file Dataset.zip uit.
# Geen idee of er een package is voor het automatisch uitpakken.
# dus doe ik dit maar handmatig.
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Asssignment
# Merge the training and the test sets to create one data set.
# Extract only the measurements on the mean and standard deviation for each measurement. 
# Use descriptive activity names to name the activities in the data set
# Appropriately label the data set with descriptive activity names. 
# Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 



# step 1: Import data files

# imported with rstudio -> Tools -> Import dataset -> From Text File
features <- read.table("E:/UCI/features.txt", quote="\"", comment.char="")
activity_labels <- read.table("E:/UCI/activity_labels.txt", quote="\"", comment.char="")

X_test <- read.table("E:/UCI/test/X_test.txt", quote="\"", comment.char="")
subject_test <- read.table("E:/UCI/test/subject_test.txt", quote="\"", comment.char="")
Y_test <- read.table("E:/UCI/test/Y_test.txt", quote="\"", comment.char="")

X_train <- read.table("E:/UCI/train/X_train.txt", quote="\"", comment.char="")
Y_train <- read.table("E:/UCI/train/Y_train.txt", quote="\"", comment.char="")
subject_train <- read.table("E:/UCI/train/subject_train.txt", quote="\"", comment.char="")

# step 2: Find out What column names to use

colnames(activity_labels) <- c("activityID", "Activity")
colnames(X_train) <- features$V2
colnames(Y_train) <- "activityID"
colnames(subject_train) <- "subjectID" 
colnames(X_test) <- features$V2
colnames(Y_test) <- "activityID"
colnames(subject_test) <- "subjectID" 


# step 3: Merge the training and the test sets to create one data set.

trainingAll <- cbind(Y_train, subject_train, X_train)
testAll <- cbind(Y_test, subject_test, X_test)
dataAll <- rbind(trainingAll, testAll)
colAll <- names(dataAll)


# step 4: Extract only the measurements on the mean and standard deviation for each measurement. 

meansAll <- setdiff(grep("mean()",colAll) , grep("Freq()",colAll))
meansAll
standarddevsAll <- grep("std()",colAll) 

ColumnsSorted <- sort(c(meansAll, standarddevsAll ))


# step 5: Use descriptive activity names to name the activities in the data set

#df <- dataAll[, c("activityID", "subjectID",rd)]
df<- dataAll[, c(1, 2, ColumnsSorted)]
#str(dataAll)

# step 6: Appropriately label the data set with descriptive activity names. 

names(df)<-gsub("std()", "SD", names(df))
names(df)<-gsub("mean()", "MEAN", names(df))
names(df)<-gsub("^t", "time", names(df))
names(df)<-gsub("^f", "frequency", names(df))
names(df)<-gsub("Acc", "Accelerometer", names(df))
names(df)<-gsub("Gyro", "Gyroscope", names(df))
names(df)<-gsub("Mag", "Magnitude", names(df))
names(df)<-gsub("BodyBody", "Body", names(df))


# step 7: Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

dfmelted <- melt(df, id = c("activityID","subjectID"))

dfmean <- dcast(dfmelted, activityID + subjectID ~ variable, mean)

write.table(dfmean, "tidydataSamsung.txt", row.names = FALSE, sep = "\t")

# step 8: remove big objects
#rm(dataAll, df, dfmelted, dfmean, subject_test, subject_train, trainingAll, testAll, X_train, X_test, Y_train, Y_test)
