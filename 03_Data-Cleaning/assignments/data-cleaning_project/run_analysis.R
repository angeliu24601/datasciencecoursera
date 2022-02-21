# 0 Preparation steps
##The script requires packages "dplyr" and "tidyr"
##Download the datasets and unzip them into the specified sub-folder in the WD
URL<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
temp <- tempfile()
download.file(URL,temp, method = "curl")
unzip (temp,exdir = "./")
rm(URL,temp)

##Load the datasets into R and label the columns accordingly
features <- read.table("./UCI HAR Dataset/features.txt")
activity.labels <- read.table("./UCI HAR Dataset/activity_labels.txt",
                              col.names = c("activity.code","activity.name"))
## training data
x.train <- read.table("./UCI HAR Dataset/train/X_train.txt",
                      col.names = features[,2])
y.train <- read.table("./UCI HAR Dataset/train/y_train.txt",
                      col.names = "activity.code")
subject.train <- read.table("./UCI HAR Dataset/train/subject_train.txt",
                            col.names = "subject")
## test data
x.test <- read.table("./UCI HAR Dataset/test/X_test.txt",
                     col.names = features[,2])
y.test <- read.table("./UCI HAR Dataset/test/y_test.txt",
                     col.names = "activity.code")
subject.test <- read.table("./UCI HAR Dataset/test/subject_test.txt",
                           col.names = "subject")

# 1 Merge the training and the test sets
##Merge the datasets of "train" into a single table
train <- cbind(subject.train,y.train,x.train)

##Merge the datasets of "test" into a single table
test <- cbind(subject.test,y.test,x.test)

##Merge the training and test sets and clear redundant tables
dataset <- rbind(train,test)
rm(train,test,x.test,y.test,x.train,y.train,subject.test,subject.train)

# 2 Extract the measurements on the mean & standard deviation
library(dplyr)
data.selected <- select(dataset,grep("*[Mm]ean*|*std*",features$V2))

# 3 Use descriptive activity names to name the activities in the data set
data.selected <- data.selected %>% 
  merge(activity.labels, by = c("activity.code")) %>%
  select(subject, activity.name, 3:86)

# 4 Appropriately label the data set with descriptive variable names
## Already carried out when importing the data sets.
## The dataframe "data.selected" has descriptive column names

# 5 Create a second, independent tidy data set with the average of each variable
# for each activity and each subject.

##Gather the columns of the measurements into a single column
library(tidyr)
data.tidy <- gather(data.selected, measurements, value, 3:86)

##Group the tidy data set by measurements, subject, and activity
##and get the average for the grouped data
average <- data.tidy %>% 
  group_by(measurements, activity.name, subject) %>%
  summarize(mean(value)) %>% 
  arrange(measurements, activity.name, subject) %>%
  rename(mean.value = `mean(value)`)
  

##Write the data as text file
write.table(average, file = "./data-cleaning_course-project.txt", 
            row.name = FALSE)
