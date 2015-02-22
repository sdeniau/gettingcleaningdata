## reading training data sets
  file<-"./UCI HAR Dataset/train/X_train.txt"
  X_train<-read.table(file)
  file<-"./UCI HAR Dataset/train/y_train.txt"
  y_train<-read.table(file)
  file<-"./UCI HAR Dataset/train/subject_train.txt"
  subject_train<-read.table(file)
## reading testing data sets
  file<-"./UCI HAR Dataset/test/X_test.txt"
  X_test<-read.table(file)
  file<-"./UCI HAR Dataset/test/y_test.txt"
  y_test<-read.table(file)
  file<-"./UCI HAR Dataset/test/subject_test.txt"
  subject_test<-read.table(file)
## reading features and activities labels
  file<-"./UCI HAR Dataset/features.txt"
  features<-read.table(file)
  file<-"./UCI HAR Dataset/activity_labels.txt"
  activity_labels<-read.table(file)
## merging test and train measurements files (keeping only mean() and std() measurements)
  X_total<-rbind(X_test,X_train)
  colnames(X_total)<-features$V2
  DataSet<-X_total[,which(grepl("std()",colnames(X_total),fixed=TRUE)|grepl("mean()",colnames(X_total),fixed=TRUE))]
## merging test and train subjects files
  subject_total<-rbind(subject_test,subject_train)
  colnames(subject_total)<-"Subjects"
## merging test and train activities files
  y_total<-rbind(y_test,y_train)
  Activities<-merge(y_total,activity_labels,by="V1")
  colnames(Activities)<-c("Code.Activity","Activity")
## creating tidy data set with subjects, activities labels and measurements
  DataSet<-cbind(subject_total,Activities$Activity,DataSet)
  colnames(DataSet)[2]<-"Activities"
## creating new tidy data set showing means for all measurements grouped by subject and activity
  NewTidyDataSet<-aggregate( DataSet[,3:68], DataSet[,1:2], FUN = mean )
## wrinting output txt file with last data set
  write.table(NewTidyDataSet,"Tidy Data Set - Course Project.txt", row.name=FALSE)
