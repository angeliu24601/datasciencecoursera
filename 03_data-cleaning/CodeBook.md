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

## Output File Description
> The independent tidy data set produced by the R script contains the following variables:
- **measurements**, which describes the features selected to be measured. They are:
  - angle.tBodyAccJerkMean..gravityMean.
  - angle.tBodyAccMean.gravity.
  - angle.tBodyGyroJerkMean.gravityMean.
  - angle.tBodyGyroMean.gravityMean.
  - angle.X.gravityMean.
  - fBodyAcc.bandsEnergy...1.24.2
  - fBodyAcc.bandsEnergy...25.48.2
  - fBodyAcc.maxInds.Y
  - fBodyAcc.maxInds.Z
  - fBodyAcc.mean...X
  - fBodyAcc.mean...Y
  - fBodyAcc.mean...Z
  - fBodyAcc.meanFreq...X
  - fBodyAcc.std...X
  - fBodyAccJerk.bandsEnergy...1.24.2
  - fBodyAccJerk.bandsEnergy...25.48.2
  - fBodyAccJerk.maxInds.Y
  - fBodyAccJerk.maxInds.Z
  - fBodyAccJerk.mean...X
  - fBodyAccJerk.mean...Y
  - fBodyAccJerk.mean...Z
  - fBodyAccJerk.meanFreq...X
  - fBodyAccJerk.std...X
  - fBodyAccMag.entropy..
  - fBodyAccMag.kurtosis..
  - fBodyAccMag.skewness..
  - fBodyBodyAccJerkMag.entropy..
  - fBodyBodyAccJerkMag.kurtosis..
  - fBodyBodyAccJerkMag.skewness..
  - fBodyBodyGyroJerkMag.entropy..
  - fBodyBodyGyroJerkMag.kurtosis..
  - fBodyBodyGyroJerkMag.skewness..
  - fBodyBodyGyroMag.entropy..
  - fBodyBodyGyroMag.kurtosis..
  - fBodyBodyGyroMag.skewness..
  - fBodyGyro.bandsEnergy...1.24.2
  - fBodyGyro.bandsEnergy...25.48.2
  - fBodyGyro.maxInds.Y
  - fBodyGyro.maxInds.Z
  - fBodyGyro.mean...X
  - fBodyGyro.mean...Y
  - fBodyGyro.mean...Z
  - fBodyGyro.meanFreq...X
  - fBodyGyro.std...X
  - tBodyAcc.correlation...X.Z
  - tBodyAcc.correlation...Y.Z
  - tBodyAcc.mean...X
  - tBodyAcc.mean...Y
  - tBodyAcc.mean...Z
  - tBodyAcc.std...X
  - tBodyAccJerk.correlation...X.Z
  - tBodyAccJerk.correlation...Y.Z
  - tBodyAccJerk.mean...X
  - tBodyAccJerk.mean...Y
  - tBodyAccJerk.mean...Z
  - tBodyAccJerk.std...X
  - tBodyAccJerkMag.arCoeff..3
  - tBodyAccJerkMag.arCoeff..4
  - tBodyAccMag.arCoeff..3
  - tBodyAccMag.arCoeff..4
  - tBodyGyro.correlation...X.Z
  - tBodyGyro.correlation...Y.Z
  - tBodyGyro.mean...X
  - tBodyGyro.mean...Y
  - tBodyGyro.mean...Z
  - tBodyGyro.std...X
  - tBodyGyroJerk.correlation...X.Z
  - tBodyGyroJerk.correlation...Y.Z
  - tBodyGyroJerk.mean...X
  - tBodyGyroJerk.mean...Y
  - tBodyGyroJerk.mean...Z
  - tBodyGyroJerk.std...X
  - tBodyGyroJerkMag.arCoeff..3
  - tBodyGyroJerkMag.arCoeff..4
  - tBodyGyroMag.arCoeff..3
  - tBodyGyroMag.arCoeff..4
  - tGravityAcc.correlation...X.Z
  - tGravityAcc.correlation...Y.Z
  - tGravityAcc.mean...X
  - tGravityAcc.mean...Y
  - tGravityAcc.mean...Z
  - tGravityAcc.std...X
  - tGravityAccMag.arCoeff..3
  - tGravityAccMag.arCoeff..4
- **activity.name**, which describes the activity the subject is performing when the measurement was taken. The available labels are:
  - WALKING
  - WALKING_UPSTAIRS
  - WALKING_DOWNSTAIRS
  - SITTING
  - STANDING
  - LAYING
- **subject**, which identifies the subject by an ID number
- **mean.value**, which is the calculated average value of each variable for each activity and each subject 