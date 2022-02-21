## 1. --------------------------------------------------------------------------
## Load the vowel.train and vowel.test data sets:
library(ElemStatLearn)
data(vowel.train)
data(vowel.test)

## Set the variable y to be a factor variable in both the training and test set. 
## Then set the seed to 33833. Fit (1) a random forest predictor relating the 
## factor variable y to the remaining variables and (2) a boosted predictor 
## using the "gbm" method. Fit these both with the train() command in the caret 
## package.

## What are the accuracies for the two approaches on the test data set? 
## What is the accuracy among the test set samples where the two methods agree?
library(caret)

vowel.train$y <- factor(vowel.train$y)
vowel.test$y <- factor(vowel.test$y)
set.seed(33833)

mod1 <- train(y ~ ., method = "rf", data = vowel.train)
mod2 <- train(y ~ ., method = "gbm", data = vowel.train)

pred1 <- predict(mod1, newdata = vowel.test)
confusionMatrix(pred1, vowel.test$y)$overall[1]

pred2 <- predict(mod2, newdata = vowel.test)
confusionMatrix(pred2, vowel.test$y)$overall[1]

df.agree <- data.frame(vowel.test$y, pred1, pred2) %>% 
  filter(pred1 == pred2)

confusionMatrix(df.agree$pred1, df.agree$vowel.test.y)$overall[1]

## Options:
## [N] RF = 0.9987; GBM = 0.5152; Agreement = 0.9985
## [N] RF = 0.3233; GBM = 0.8371; Agreement = 0.9983
## [N] RF = 0.6082; GBM = 0.5152; Agreement = 0.5325
## [Y] RF = 0.6082; GBM = 0.5152; Agreement = 0.6361

## 2. -------------------------------------------------------------------------
## Load the Alzheimer's data using the following commands
library(caret)

library(gbm)

set.seed(3433)

library(AppliedPredictiveModeling)

data(AlzheimerDisease)

adData = data.frame(diagnosis,predictors)

inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]

training = adData[ inTrain,]

testing = adData[-inTrain,]

## Set the seed to 62433 and predict diagnosis with all the other variables 
## using a random forest ("rf"), boosted trees ("gbm") and linear discriminant 
## analysis ("lda") model. Stack the predictions together using random forests 
## ("rf"). What is the resulting accuracy on the test set? 
## Is it better or worse than each of the individual predictions?
set.seed(62433)
mod1 <- train(diagnosis ~., method = "rf",  data = training)
mod2 <- train(diagnosis ~., method = "gbm", data = training)
mod3 <- train(diagnosis ~., method = "lda", data = training)

df.stack <- data.frame(diagnosis = testing$diagnosis, 
                       rf = predict(mod1, newdata = testing),
                       gbm = predict(mod2, newdata = testing),
                       lda = predict(mod3, newdata = testing))

mod4 <- train(diagnosis ~., method = "rf", data = df.stack)

confusionMatrix(df.stack$rf, testing$diagnosis)$overall[1]
confusionMatrix(df.stack$gbm, testing$diagnosis)$overall[1]
confusionMatrix(df.stack$lda, testing$diagnosis)$overall[1]
confusionMatrix(predict(mod4, newdata = df.stack), 
                testing$diagnosis)$overall[1]

## Options:
## [N] Stacked Accuracy: 0.80 is better than random forests and Ida and 
##    the same as boosting
## [Y] Stacked Accuracy: 0.80 is better than all three other methods
## [N] Stacked Accuracy: 0.80 is worse than all the other methods
## [N] Stacked Accuracy: 0.88 is better than all three other methods

## 3. --------------------------------------------------------------------------
## Load the concrete data with the commands:
set.seed(3523)

library(AppliedPredictiveModeling)

data(concrete)

inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]

training = concrete[ inTrain,]

testing = concrete[-inTrain,]

## Set the seed to 233 and fit a lasso model to predict Compressive Strength. 
## Which variable is the last coefficient to be set to zero as the penalty 
## increases? (Hint: it may be useful to look up ?plot.enet).

set.seed(233)
mod <- train(CompressiveStrength ~., method = "lasso", data = training)

library(elasticnet)
plot.enet(mod$finalModel, xvar = "penalty")

## Options:
## [N] Water
## [N] Age
## [N] CoarseAggregate
## [Y] Cement


## 4. --------------------------------------------------------------------------
## Load the data on the number of visitors to the instructors blog from here:
## https://d396qusza40orc.cloudfront.net/predmachlearn/gaData.csv
## Using the commands:
## 
library(lubridate) # For year() function below
download.file("https://d396qusza40orc.cloudfront.net/predmachlearn/gaData.csv",
              "./gaData.csv")

dat = read.csv("./gaData.csv")

training = dat[year(dat$date) < 2012,]

testing = dat[(year(dat$date)) > 2011,]

tstrain = ts(training$visitsTumblr)

## Fit a model using the bats() function in the forecast package to the training
## time series. Then forecast this model for the remaining time points. 
## For how many of the testing points is the true value within the 95% prediction 
## interval bounds?
library(forcast)
mod <- bats(tstrain)
fcast <- forecast(mod, level = 95, h = dim(testing)[1])

df <- data.frame(lower = as.numeric(fcast$lower), 
                 upper = as.numeric(fcast$upper), 
                 val = testing$visitsTumblr) %>% 
  mutate(within = ifelse(val >= lower & val <= upper, TRUE, FALSE))

sum(df$within)/nrow(df)

## Options:
## [Y] 96%
## [N] 93%
## [N] 95%
## [N] 94%
 

## 5. --------------------------------------------------------------------------
## Load the concrete data with the commands:
set.seed(3523)

library(AppliedPredictiveModeling)

data(concrete)

inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]

training = concrete[ inTrain,]

testing = concrete[-inTrain,]

## Set the seed to 325 and fit a support vector machine using the e1071 package 
## to predict Compressive Strength using the default settings. 
## Predict on the testing set. What is the RMSE?
library(e1071)
set.seed(325)

mod <- svm(CompressiveStrength ~., data = training)
prd <- predict(mod, newdata = testing)
RMSE(prd, testing$CompressiveStrength)

## Options:
## [N] 6.93
## [N] 1154.39
## [N] 107.44
## [Y] 6.72