# README

## Files in the Repository
> This repository is for the Getting and Cleaning Data Course project, which is part of the Coursera Data Science Specialization. It contains the following files:

> - *README.md*, which explains the files in the repository.
> - *run_analysis.R*, which is the R script that performs the necessary transformation and analysis to produce the tidy output file.
> - *data-cleaning_course-project.txt*, which is the output file produced by the R script. It is tidy data set with the average of each variable for each activity and each subject.
> - *CodeBook.md*, which modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information

## Description of The Analysis
> The steps carried out to transfrom the original data sets and produce the tidy data are:

> 1. Preparatory steps, which include loading the required packages, download the datasets and unzip them into the specified directory, load the data sets into R, and label the columns accordingly
> 2. Merge the training and test data sets into a single data frame
> 3. Extract the measurements on the mean & standard deviation using regular expressions
> 4. Merge the 'activity label' with the data set so that it has descriptive activity names
> 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject
> 6. Export the tidy data set as a text file