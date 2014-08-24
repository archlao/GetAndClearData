# This script will work only if the contents of Samsung Data were extract to your Working Directory in a folder called Samsung.

# 1    Merges the training and the test sets to create one data set.
Varnames <-read.table("./Samsung/features.txt",header=FALSE)

# Load Test Files

testX <-read.table("./Samsung/test/X_test.txt",header=FALSE)
testY <-read.table("./Samsung/test/Y_test.txt",header=FALSE)
testSub <-read.table("./Samsung/test/subject_test.txt",header=FALSE)


# 4    Appropriately labels the data set with descriptive variable names. 
# Assign Names to Columns Test
colnames(testX)<-Varnames[,2]
colnames(testSub)<-"Subject"
colnames(testY)<-"Activity"
Testdf<-data.frame(testSub,testX,testY)

# Load Train Files
trainX <-read.table("./Samsung/train/X_train.txt",header=FALSE)
trainY <-read.table("./Samsung/train/Y_train.txt",header=FALSE)
trainSub <-read.table("./Samsung/train/subject_train.txt",header=FALSE)


# 4    Appropriately labels the data set with descriptive variable names. 
# put Subjects ID´s to rows

colnames(trainX)<-Varnames[,2]
colnames(trainSub)<-"Subject"
colnames(trainY)<-"Activity"
Traindf<-data.frame(trainSub,trainX,trainY)

#merge data frames
Totaldf<-merge(Traindf,Testdf,x.by="Subject",y.by="Subject",all=TRUE)


# 2    Extracts only the measurements on the mean and standard deviation for each measurement. 

# columns with mean
meanlist <- grep("mean()",colnames(Totaldf))

# columns with standard deviation
stdlist <- grep("std()",colnames(Totaldf))

# add on the list subject and Activity colums
varlist <-c(1,meanlist,stdlist,563)

# order columns list
varlist <- varlist[order(varlist)]

# create data frame with only mean and standard deviation measurements
DataSel <- Totaldf[,varlist]

# 3    Uses descriptive activity names to name the activities in the data set
activlabel <-read.table("./Samsung/activity_labels.txt",header=FALSE)
colnames(activlabel)<-c("Activity","Desc")

activlabel$Activity <- as.numeric(activlabel$Activity)
DataSel$Activity <- as.numeric(DataSel$Activity)
DataSelLabel <-merge(x=DataSel,y=activlabel,by="Activity")

# 5    Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
# lists var with meanFreq to take off after
outFreq <- grep("meanFreq",colnames(DataSelLabel))

DataSelLabel.means <- aggregate(DataSelLabel[c(-1,-2,-82,-outFreq)],by = DataSelLabel[c("Subject","Activity","Desc")], FUN=mean)

# 6    Save final file
write.table(DataSelLabel.means, file = "SensorMeans.txt", sep = ",",row.name=FALSE)
