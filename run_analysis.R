library(reshape2)
library(data.table)
library(dplyr)
rm(list = ls())

# First steps is to load the different documents
#Routes definition --> NOTE: For validation, please use this ROUTES for storing the files
activity_labels_route <- "./data/project_course3/UCI_HAR_Dataset/activity_labels.txt"
features_route <- "./data/project_course3/UCI_HAR_Dataset/features.txt"
test_X_route <- "./data/project_course3/UCI_HAR_Dataset/test/X_test.txt"
test_Y_route <- "./data/project_course3/UCI_HAR_Dataset/test/y_test.txt"
train_X_route <- "./data/project_course3/UCI_HAR_Dataset/train/X_train.txt"
train_Y_route <- "./data/project_course3/UCI_HAR_Dataset/train/y_train.txt"
subject_test_route <- "./data/project_course3/UCI_HAR_Dataset/test/subject_test.txt"
subject_train_route <- "./data/project_course3/UCI_HAR_Dataset/train/subject_train.txt"

activity_label <- read.table(activity_labels_route)
features <- read.table(features_route)
X_test <- read.table(test_X_route)
y_test <- read.table(test_Y_route)
X_train <- read.table(train_X_route)
y_train <- read.table(train_Y_route)
subject_test <- read.table(subject_test_route)
subject_train <- read.table(subject_train_route)


activity_label <- select(activity_label, V2) # Second column has the activity information

# Data Highlights:
# There are 561 Features, which match with the amount of variables existing in the TEST and the Training.
#Therefore, the FEATURES correspond to the TEST and TRAIN variables NAMES
names(X_test) = features$V2 # Give the variable names to x_test
names(X_train) = features$V2 # Give the variable names to x_train

#Activiy_label has the 6 activities performed. y_test & y_train has values from 1 to 6, which correspond to the
# activitiy names. Each number correspond to one Activity.
#A new variable will be added to y_test and y_train with the corresponding activity label
y_test <- mutate(y_test, activity_label = NA)
names(y_test) <- c("Activity_id", "activity_label")

#Give a proper name to variable in " subject_Test"
names(subject_test) <- "subject"

#The correspondings activity label is matched to the activity id
#get the size of y_test
y_test_size <- dim(y_test)[1]

counter <- 1
value <- 0

while (counter <= y_test_size) {
        value <- as.numeric(y_test[counter, 1])
        y_test[counter, 2] <- as.character(activity_label[value,1])
        counter <- counter + 1
}

# Test Data is ready.  now we need to BIND the 3 different data
test_data <- cbind(subject_test, y_test, X_test)

# Now, prepare the training Data
y_train <- mutate(y_train, activity_label = NA)
names(y_train) <- c("Activity_id", "activity_label")

#Give a proper name to variable in " subject_Train"
names(subject_train) <- "subject"

#The correspondings activity label is matched to the activity id
#get the size of y_train
y_train_size <- dim(y_train)[1]

counter <- 1
value <- 0

while (counter <= y_train_size) {
        value <- as.numeric(y_train[counter, 1])
        y_train[counter, 2] <- as.character(activity_label[value,1])
        counter <- counter + 1
}

# Trainning Data is ready.  now we need to BIND the 3 different data
trainning_data <- cbind(subject_train, y_train, X_train)

# Both Test and training have been organized and the variables are the same. Now, the 2 sets will be merged
# to have only one complete data

merged_data <- rbind(test_data, trainning_data)

#As stated in the Project, only the mean and the standard deviation should be considered from Features
features_filtered <- grepl("mean|std", features$V2) # Look into the second variable

#Now that the Data has its variable names, we must remember that we will only work with the info
#collected in "features_filter --> corresponding only to mean and standard deviation
merged_data <- merged_data[, features_filtered]

if (!file.exists("./data/project_course3/UCI_HAR_Dataset/Answers")) {dir.create("./data/project_course3/UCI_HAR_Dataset/Answers")}
write.table(merged_data, file = "./data/project_course3/UCI_HAR_Dataset/Answers/merged_data.txt", row.names = FALSE)

# Creates a new independent table grouped by Subject and Activity and showing its Average

new_table <- aggregate(.~subject+activity_label, merged_data, mean)

if (!file.exists("./data/project_course3/UCI_HAR_Dataset/Answers")) {dir.create("./data/project_course3/UCI_HAR_Dataset/Answers")}
write.table(new_table, file = "./data/project_course3/UCI_HAR_Dataset/Answers/New_tidy_data_grouped.txt", row.names = FALSE)

