#
# tidy.R
#

#
# This file contains a variety of functions that can tidy an individual set of data, i.e. the train or test
# data.
#

source('read_data.R')
library(dplyr)

#
# Get the activity names as a data frame.
#
# The column containing the labels will be called Activity, and the activity ID will be ActivityId
#
get_activity_label_frame <- function() {
  table <- read_tibble_file(get_root_data_file('activity_labels.txt'))  %>%
    rename(ActivityId=V1, Activity=V2)
}

#
# Get the activity labels for a set (train or test). appropriately labeled with a textual valued column
# named 'Activity'.
#
# set_name: the name of the data set  (train or test)
# activity_label_frame: a data frame with the activity ID and names
#
# Returns a dataframe with the Activity ID in a numeric column named ActivityId, and the Activity name
# in a factor column named Activity.

get_activity_labels_for_set <- function(set_name, activity_label_frame) {
  read_tibble_file(get_set_data_file(set_name, 'y'))  %>%
    rename(ActivityId=V1) %>%
    inner_join(activity_label_frame ) %>%
    select(Activity)
}

#
# Get the subject IDs for a set (train or test) appropriately labeled column
# named 'SubjectId'.
#
# set_name: the name of the data set  (train or test)
#
# Returns a data frame with the subject IDs.

get_subject_frame <- function(set_name) {
  read_tibble_file(get_set_data_file(set_name, 'subject')) %>%
    rename(SubjectId=V1)
}

#
# Get the feature column names from the source file.
#
# Returns a vector with the feature names.
#

get_feature_column_names <- function() {
  read_tibble_file(get_root_data_file('features.txt'))$V2
}

#
# Get a tidy feature data frame with all of the desired columns appropriately named.
#
# set_name: the name of the data set  (train or test)
#

get_feature_frame <- function(set_name) {
  table <- read_feature_data_set(set_name)
  
  # Rename the column names to the feature names
  feature_column_names <- get_feature_column_names()
  
  # Get the indices of the columns we want to keep
  feature_column_names_to_keep <- which(grepl("mean|std", feature_column_names))
  
  # Only keep columns from the names we want to keep
  table <- table[,feature_column_names_to_keep]
  
  # rename the columns
  colnames(table) <- feature_column_names[feature_column_names_to_keep]
  
  table
}

#
# Get the dataframe for a set (train or test), with all required columns.
#
# set_name: the name of the data set  (train or test)
# activity_label_frame: a data frame with the activity ID and names
#

get_tidy_data_set <- function(set_name, activity_label_frame) {
  activity_names_frame <- get_activity_labels_for_set(set_name, activity_label_frame)
  
  subject_frame <- get_subject_frame(set_name)
  
  feature_frame <- get_feature_frame(set_name)
  
  cbind(subject_frame, activity_names_frame, feature_frame)
}