# Variables definition

url: has the URL where the ZIP file is located

activity_labels_route: Route for activity_labels
features_route 
test_X_route 
test_Y_route 
train_X_route
train_Y_route
subject_test_route
subject_train_route


activity_label: New Variable added to y_test and y_train
counter: variable used in the while loop to know when the complete data has been evaluated
value: Variable to store the Id of the activity

test_data: Variable where the Merge of the data related with TEST is stored
y_test_size: get the length of the table y_test
y_train_size: get the length of the table y_train

trainning_data: Variable where the Merge of the data related with TRAINNING is stored

merged_data: Variable where both the complete test and trainning information has been merged

features_filtered: Variable to store the index where the key words "std"and "mean" where found within "features"

new_table: Table created to answer the last point. New table filtering by Subject and Activity and showing the Average value of each variable
