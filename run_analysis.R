#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement.
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names.
#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#Loads all the data files and labels into system
library(dplyr)
train_x<-read.table("UCI HAR Dataset\\train\\X_train.txt")
train_y<-read.table("UCI HAR Dataset\\train\\Y_train.txt")
test_x<-read.table("UCI HAR Dataset\\test\\x_test.txt")
test_y<-read.table("UCI HAR Dataset\\test\\y_test.txt")
subject_train<-read.table("UCI HAR Dataset\\train\\subject_train.txt")
subject_test<-read.table("UCI HAR Dataset\\test\\subject_test.txt")


#Initial merge of two datasets and ensurees no missing data
data2<-merge(train_x,test_x,all=TRUE)
data2<-data2[complete.cases(data2),]


#Store the variable labels
featurelist<-read.table("UCI HAR Dataset\\features.txt")
activitylabel<-read.table("UCI HAR Dataset\\activity_labels.txt")

#merges the activity lists of the two data sets
activity<-rbind(train_y,test_y)

#Sorts the dataset for mean and std in the variable names
sortfeatures<-grepl(".*[Mm][Ee][Aa][Nn].*|.*[Ss][Tt][Dd].*",featurelist[,2])
data2<-data2[,sortfeatures]

#Labels the dataset with correct variables based on the filter
names(data2)<-featurelist[sortfeatures,2]

#adds the activity data to the main dataset and changes the stored data to the descriptive activity name
data2<-mutate(data2,"activity"=activity)
data2$activity<-activitylabel[unlist(data2$activity),2]

#adds the subject data
data2<-mutate(data2,"subject"=rbind(subject_train,subject_test))

#creates a second dataframe that is grouped by activity and then subject
datasecond<-group_by(data2,activity, subject)

#summarizes that dataframe with the mean value
datasecond<-summarise_at(datasecond,c(1:86),mean,na.rm = TRUE)

#writes the second df into a file
write.table(datasecond,"tidydata.txt",row.names = FALSE)
