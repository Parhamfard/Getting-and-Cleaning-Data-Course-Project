#Download data and set the path

Warning message:
  R graphics engine version 14 is not supported by this version of RStudio. The Plots tab will be disabled until a newer version of RStudio is installed. 

setwd("~/UCI HAR Dataset")
 
#Read train and test dataframes

Activity.Test  <- read.table(file.path("~/UCI HAR Dataset", "test" , "Y_test.txt" ),header = FALSE)

Activity.Train <- read.table(file.path("~/UCI HAR Dataset", "train", "Y_train.txt"),header = FALSE)

Subject.Train <- read.table(file.path("~/UCI HAR Dataset", "train", "subject_train.txt"),header = FALSE)

Subject.Test  <- read.table(file.path("~/UCI HAR Dataset", "test" , "subject_test.txt"),header = FALSE)

Features.Test  <- read.table(file.path("~/UCI HAR Dataset", "test" , "X_test.txt" ),header = FALSE)

Features.Train <- read.table(file.path("~/UCI HAR Dataset", "train", "X_train.txt"),header = FALSE)
          
            
#Combine Train and Test datasets
             
data.Subject <- rbind(Subject.Train, Subject.Test)
    
data.Activity<- rbind(Activity.Train, Activity.Test)
                
data.Features<- rbind(Features.Train, Features.Test)
                  
# Set new names to variables
                    
names(data.Subject)<-c("subject")

names(data.Activity)<- c("activity")
                    
Features.Names <- read.table(file.path("~/UCI HAR Dataset", "features.txt"),head=FALSE)
                        
names(data.Features)<- Features.Names$V2
                          
data.Combine <- cbind(data.Subject, data.Activity)
                            
# Create new data farme 
                              
Data <- cbind(data.Features, data.Combine)
                               
New.Features.Names<-Features.Names$V2[grep("mean\\(\\)|std\\(\\)", Features.Names$V2)]
                                 
New.Names<-c(as.character(New.Features.Names), "subject", "activity" )
                                  
Data<-subset(Data,select=New.Names)

 # Look @ data frame

str(Data)

# Read from “activity_labels.txt”

activity.Labels <- read.table(file.path("~/UCI HAR Dataset", "activity_labels.txt"),header = FALSE)

# Look @ head Data
  
head(Data$activity,30)
[1] 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 4 4 4

  
#Alocate descriptive name

#prefix t is replaced by time
#Acc is replaced by Accelerometer
#Gyro is replaced by Gyroscope
#prefix f is replaced by frequency
#Mag is replaced by Magnitude
#BodyBody is replaced by Body
  
names(Data)<-gsub("^t", "time", names(Data))

names(Data)<-gsub("^f", "frequency", names(Data))

names(Data)<-gsub("Acc", "Accelerometer", names(Data))

names(Data)<-gsub("Gyro", "Gyroscope", names(Data))

names(Data)<-gsub("Mag", "Magnitude", names(Data))

names(Data)<-gsub("BodyBody", "Body", names(Data))

# lOOK @ the names
  
names(Data)

#Import library

library(dplyr)

# Create final tidy data frame

Final.Data<-aggregate(. ~subject + activity, Data, mean)

Final.Data<-Final.Data[order(Final.Data$subject,Final.Data$activity),]

write.table(Final.Data, file = "tidydata.txt",row.name=FALSE)
 
#Look @ Final data
  
head(Final.Data)
                                      
