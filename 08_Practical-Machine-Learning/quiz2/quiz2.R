library(caret);library(tidyverse)

# 1. Load the Alzheimer's disease data using the commands:
library(AppliedPredictiveModeling)
data(AlzheimerDisease)

# Which of the following commands will create non-overlapping training and 
# test sets with about 50% of the observations assigned to each?
adData = data.frame(diagnosis, predictors)
trainIndex = createDataPartition(diagnosis,p=0.5, list = FALSE)
training = adData[trainIndex,]
testing = adData[-trainIndex,]

rm(list=ls())

# 2. Load the cement data using the commands:
library(AppliedPredictiveModeling)
data(concrete)
library(caret)
set.seed(1000)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]
# Make a plot of the outcome (CompressiveStrength) versus the index of the samples. 
# Color by each of the variables in the data set (you may find the cut2() function 
# in the Hmisc package useful for turning continuous covariates into factors). 
# What do you notice in these plots?

# 3. Load the cement data using the commands:
library(AppliedPredictiveModeling)
data(concrete)
library(caret)
set.seed(1000)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]
# Make a histogram and confirm the SuperPlasticizer variable is skewed. 
# Normally you might use the log transform to try to make the data more symmetric. 
# Why would that be a poor choice for this variable?
ggplot(data = training, aes(x = Superplasticizer)) +
  geom_histogram()

rm(list=ls())

# 4. Load the Alzheimer's disease data using the commands:
library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

# Find all the predictor variables in the training set that begin with IL. 
# Perform principal components on these variables with the preProcess() function 
# from the caret package. Calculate the number of principal components needed to 
# capture 80% of the variance. How many are there?
IL <- grep("^IL", colnames(training))
preProc <- preProcess(training[, IL], method = "pca", thresh = 0.9)
preProc$rotation

rm(list=ls())

# 5. Load the Alzheimer's disease dat using the commands:
library(caret)
library(AppliedPredictiveModeling)
library(e1071)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

# Create a training data set consisting of only the predictors with variable 
# names beginning with IL and the diagnosis. Build two predictive models, 
# one using the predictors as they are and one using PCA with 
# principal components explaining 80% of the variance in the predictors. 
# Use method="glm" in the train function.
# 
# What is the accuracy of each method in the test set? Which is more accurate?
data_il <- select(training, starts_with("IL"), diagnosis)
fit1 <- train(diagnosis ~ ., method = "glm", data = data_il) 

prediction1 <- predict(fit1, newdata = testing)

confusionMatrix(prediction1, testing$diagnosis)

fit2 <- train(diagnosis ~ ., method = "glm", preProcess = "pca",
              data = data_il, trControl = trainControl(preProcOptions = list(thresh = 0.8)))
prediction2 <- predict(fit2, newdata = testing)

confusionMatrix(prediction2, testing$diagnosis)
