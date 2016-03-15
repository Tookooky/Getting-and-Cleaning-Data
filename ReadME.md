# Getting and Cleaning Data Final Project

4 files are included in the project:

##ReadMe.md
Gives a summary of the files in the repo

##run_analysis.R 
Creates datasets from the following source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
The script creates two datasets: 

The first pulls out the mean and standard deviation data from x_train and x_test files, including detailed descriptions for the types of activities performed.

The second combines the subject_test and subject_train data, and combines the subject column with the data from the first dataset.  It then returns the average value of each mean/std deviation value set.

##Codebook.md
Describes the variables and steps used to return the datasets in run_analysis.R

##UCI_tidy.csv  
A table with the second dataset ("tidy dataset")
