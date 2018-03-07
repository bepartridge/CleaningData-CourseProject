#Getting and Cleaning Data - Course Project
This repo fulfils the final assignment of the Coursera course 'Getting and Cleaning Data'.

##Input File
The R script, 'run_analysis.R', requires that the data has been downloaded and unzipped into the working directory.

##Script Summary
The R script does the following:

1. Verifies that the dataset is in the correct folder and returns a message confirming the status of the data.
2. Loads and merges training and test datasets.
3. Extracts only variables representing means or standard deviations.
4. Loads activity and subject data for each observation and merges these identifiers with the dataset.
5. Labels columns with descriptive variable names.
6. Generates a dataset comprising the average value of each experimental variable as measured from a single subject performing a single activity.

##Output File
The final dataset, 'means.txt', is generated in the working directory.
