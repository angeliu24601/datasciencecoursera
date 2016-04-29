# Code Book

## Introduction
> The goal of the project is to prepare tidy data that can be used for later analysis. The source data was collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


## Data Set Information
> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

> The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

> For each record it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

## Description of the analysis
> The steps carried out to transfrom the original data sets and produce the tidy data are:
1. Preparatory steps, which include loading the required packages, download the datasets and unzip them into the specified directory, load the data sets into R, and label the columns accordingly

2. Mege the training and test data sets into a single data frame

3. Extract the measurements on the mean & standard deviation using regular expressions

4. Merge the 'activity label' with the data set so that it has descriptive activity names

5. Create a second, independent tidy data set with the average of each variable for each activity and each subject

6. Export the tidy data set as a text file