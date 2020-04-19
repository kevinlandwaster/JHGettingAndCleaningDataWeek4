#
# run_analysis.R
#

#
# This script runs the actual analysis for the final tidy data set that combins the test and the trainig data.
#
# It also creates a second tidy data set comtaining the averages of each variable by person and activity.
#

source('tidy.R')
library(dplyr)

# Get the activity labels first
activity_labels <- get_activity_label_frame()

# Get the complete set of data by combining the training data with the test data.
complete_tidy_data <- rbind(get_tidy_data_set('train', activity_labels), 
                            get_tidy_data_set('test', activity_labels))

# Get the mean for each measuremeant for each subject and activity pair
grouped_complete_tidy_data <- complete_data %>% 
  group_by(SubjectId, Activity) %>% 
  summarize_all(mean)