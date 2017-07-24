# Variables definition

* *url:* has the URL where the ZIP file is located.
* *activity_labels_route*: Route for activity_labels
* *features_route:* Route for features_route
* *test_X_route:* Route for test_X
* *test_Y_route: * Route for test_Y
* *train_X_route:* Route for train_X
* *train_Y_route:* Route for train_Y
* *subject_test_route:* Route for subject_test
* *subject_train_route:* Route for subject_train
* *activity_label:* New Variable added to y_test and y_train
* *counter:* variable used in the while loop to know when the complete data has been evaluated
* *value:* Variable to store the Id of the activity
* *test_data:* Variable where the Merge of the data related with TEST is stored
* *y_test_size:* get the length of the table y_test
* *y_train_size:* get the length of the table y_train
* *trainning_data:* Variable where the Merge of the data related with TRAINNING is stored
* *merged_data:* Variable where both the complete test and trainning information has been merged
* *features_filtered:* Variable to store the index where the key words "std"and "mean" where found within "features"
* *new_table:* Table created to answer the last point. New table filtering by Subject and Activity and showing the Average value of each variable

# Transformations
activity_label <- select(activity_label, V2) # Second column has the activity information

*Data Highlights*
* There are 561 Features, which match with the amount of variables existing in the TEST and the Training.
Therefore, the FEATURES correspond to the TEST and TRAIN variables NAMES
names(X_test) = features$V2 # Give the variable names to x_test
names(X_train) = features$V2 # Give the variable names to x_train

Activiy_label has the 6 activities performed. y_test & y_train has values from 1 to 6, which correspond to the
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
write.csv(merged_data, file = "./data/project_course3/UCI_HAR_Dataset/Answers/merged_data.csv")

# Creates a new independent table grouped by Subject and Activity and showing its Average

new_table <- aggregate(.~subject+activity_label, merged_data, mean)

if (!file.exists("./data/project_course3/UCI_HAR_Dataset/Answers")) {dir.create("./data/project_course3/UCI_HAR_Dataset/Answers")}
write.csv(merged_data, file = "./data/project_course3/UCI_HAR_Dataset/Answers/New_tidy_data_grouped.csv")


