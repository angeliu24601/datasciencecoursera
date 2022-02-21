## set up ----------------------------------------------------------------------
## load required packages
library(tidyverse);library(caret)

## download data 
download.file("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv",
              "./data/pml-training.csv")
download.file("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv",
              "./data/pml-testing.csv")

## load required packages
library(tidyverse);library(caret)

## load data -------------------------------------------------------------------
training <- read.csv("./data/pml-training.csv", stringsAsFactors = FALSE,
                     ## attn: several different NA strings
                     na.strings = c("", "#DIV/0!", NA_character_))

## exlpore and clean up if necessary -------------------------------------------
ref.colnames <- tibble(
      COLNAME = colnames(training),
      CLASS = map_chr(training, class) %>% unname(),
      N_NA = map_int(training, ~ is.na(.x) %>% sum())) %>% 
  mutate(ALL_NA = ifelse(N_NA == nrow(training), TRUE, FALSE))

### excluding the columns that are 
### - the outcome variable (class)
### - mostly NAs 
### - non-measurement columns, such as username, timestamp etc. 
### we will end up using the following variables to build the model
var_model <- ref.colnames %>% 
  filter(N_NA == 0, 
         !str_detect(COLNAME, "classe|X|user_name|timestamp|window")) %>% 
  pull(COLNAME)

## models ----------------------------------------------------------------------
### split the training data and keep part for cross-validation
inTrain <- createDataPartition(y = training$classe, p = 0.7, list = FALSE)

training <- training[inTrain, ]
testing <- training[-inTrain, ]

### decision trees with CART (rpart)
model_rpart <- train(
  classe ~ .,
  data = training[, c("classe", var_model)],
  method = "rpart"
)

saveRDS(model_rpart, "./model/model_rpart.rds")

### gbm
model_gbm <- train(
  classe ~ .,
  data = training[, c("classe", var_model)],
  method = "gbm"
)

saveRDS(model_gbm, "./model/model_gbm.rds")

### random forest
model_rf <- train(
  classe ~ ., 
  data = training[, c("classe", var_model)],
  method = "rf",
  ntree = 100
)

saveRDS(model_rf, "./model/model_rf.rds")

## cross-validation
model_rpart <-  readRDS("./model/model_rpart.rds")
model_gbm <- readRDS("./model/model_gbm.rds")
model_rf <- readRDS("./model/model_rf.rds")

test_rpart <- predict(model_rpart, newdata = testing)
test_gbm <- predict(model_gbm, newdata = testing)
test_rf <- predict(model_rf, newdata = testing)

accuracy_rpart <- confusionMatrix(data = test_rpart, 
                                  reference = factor(testing$classe))
accuracy_gbm <- confusionMatrix(test_gbm, factor(testing$classe))
accuracy_rf <- confusionMatrix(test_rf, factor(testing$classe))

accuracy <- data.frame(rpart = accuracy_rpart$overall["Accuracy"],
                   gbm = accuracy_gbm$overall["Accuracy"],
                   rf = accuracy_rf$overall["Accuracy"])

## prediction ------------------------------------------------------------------
testing_predict <- read.csv("./data/pml-testing.csv", stringsAsFactors = FALSE,
                    ## attn: several different NA strings
                    na.strings = c("", "#DIV/0!", NA_character_))

prediction <- predict(model_rf, newdata = test)
prediction
View(prediction)
