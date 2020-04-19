# Johns Hopkins University Data Science Course: Getting And Cleaning Data: Week 4 Programming Assignment

The purpose of this project is to create a tidy dataset. 

## Data Description

The dataset represents data collection from the accelerometers from a Samsung Galaxy S smartphone while subjects did a small number of activity types.

A full description of the data comes from here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The original data source for the project is from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. The data was captured from this source for this current repository on April 14, 2020 at 7:16PM Mountain Time.

The data from the zip file is found in the subfolder `data/`. The data was unzipped into this folder.

## R Script Descriptions

The R files in this repository are as follows:

### run_analysis.R

This script drives the actual analysis. It gets tidy versions of the test and train data sets and merges them together into a single data frame using functions defined in `tidy.R`. It also creates a second dataset that takes the merged data sets and calculates the mean of each data signal after grouping by person and activity.

When this script completes, it will have defined two variables in the R environment:

`complete_tidy_data`: The merged tidy data.

`grouped_complete_tidy_data`: The `complete_tidy_data` dataset grouped by person and activity, summarized by the mean of all signals.

It also writes the file `group_summary_tidy_data.txt` into the project directory that contains the data from `grouped_complete_tidy_data` in a table file with no row names.

### tidy.R

This script groups together functions that can create a tidy version of one of the data sets (train or test). The main function here is `get_tidy_data_set()` which uses other functions in this script to get data from various portions of the dataset and tidy them. This script uses functions in `read_data.R` to read the data into R.

### read_data.R

This script groups functions together that know how to read the various files in the dataset. It understands the folder/file layout of the dataset and the nuances necessary for reading some of the data files.
