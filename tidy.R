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
# Get the activity labels for a set (train or test) appropriately labeled.
get_activity_labels_for_set <- function(set_name, activity_label_frame) {
  read_tibble_file(get_set_data_file(set_name, 'y'))  %>%
    rename(ActivityId=V1) %>%
    inner_join(activity_label_frame )
  
}