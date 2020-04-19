#
# read_data.R
#

#
# This script contains a collection of functions that read the various data files from the project.
#
# The functions are operating system independent and understand nuances of the file formats.
#

library(readr)
library(dplyr)

#
# Get the root file path for the data set.
#
# This function is operating system independent and will use the proper
# file separator in file paths.
#
# Returns the root file path for the data.
#

get_root_file_path <- function() {
  paste0(c('data', 'UCI HAR Dataset'), collapse=.Platform$file.sep)
}

#
# Get the file path for a file in the root folder of the data set.
#
# This function is operating system independent and will use the proper
# file separator in file paths.
# 
# filename: The filename for the requested file
#
# Returns the filepath for a particular file in the root folder of the data
#

get_root_data_file <- function(filename) {
  paste0(c(get_root_file_path(), filename), collapse=.Platform$file.sep)
}

#
# Get the path name for a file in a particular dataset (train or test).
#
# Files in this folder have a strict naming scheme, so all that need to be
# supplied for a filename is its prefix, e.g. X, y, or subject
#
# This function is operating system independent and will use the proper
# file separator in file paths.
#
# set_name: the name of the data set  (train or test)
# filename_prefix: The prefix for the desired file
#
# Returns the filepath for the requested file.
#

get_set_data_file <- function(set_name, filename_prefix) {
  # Get the full filename of the desired file
  full_filename = paste0(filename_prefix, '_', set_name, '.txt')
  
  paste0(c(get_root_file_path(), set_name, full_filename), collapse=.Platform$file.sep)
}

#
# Read the feature data set, i.e. the x file, for a particular dataset (train or test)
#
# set_name: the name of the data set  (train or test)
#
# Returns a dataframe with the feature data
#

read_feature_data_set <- function(set_name) {
  file_path <- get_set_data_file(set_name, 'X')
  
  # The features data file is a fixed width file where each line has 561 columns. Rather than figure out
  # the widths manually, use the readr package to figure out the column boundaries
  width_info <- fwf_empty(file_path)
  
  read_fwf(file_path, width_info)
}

#
# Read a datafile as a tibble dataframe.
#
# This is not meant to be used to read the features file, which is in a format that can confuse read.csv.
#
# file_path: The file path to the desired file
#
# Returns a tibble of the file
#

read_tibble_file <- function(file_path) {
  # The files do not contain headers.
  tbl_df(read.csv(file_path, header=FALSE, sep=" "))
}
