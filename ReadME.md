# Getting and Cleaning Data Final Project

4 files are included in the project:

run_analysis.R 
Creates datasets from the following source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
The script creates two datasets - 
The first merges mean and standard deviation data from x_train and x_test files, including detailed descriptions for the types of activities performed.

The second combines the subject_test and subject_train data, and cobines the subject column with the dataset from the first dataset.  It then returns the average value of each mean/std deviation value set.

Codebook.nu
Describes the variables and steps used to return the datasets in run_analysis.R

Readme.txt
Gives a summary of the files in the repo

UCI_tidy.csv  
A table with the second dataset (with tidy dataset)
