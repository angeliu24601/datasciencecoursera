## set the working directory
setwd("./pa3")

## read in the downloaded data
measure <- read.csv("./rprog-data-ProgAssignment3-data/outcome-of-care-measures.csv", 
                    na.strings="Not Available")

## source the functions
source("best.R");source("rankall.R");source("rankhospital.R")

## test the functions
best("TX", "heart attack")
best("TX", "heart failure")
best("MD", "heart attack")
best("MD", "pneumonia")
best("BB", "heart attack")
best("NY", "hert attack")

rankhospital("TX", "heart failure", 4)
rankhospital("MD", "heart attack", "worst")
rankhospital("MN", "heart attack", 5000)

head(rankall("heart attack", 20), 10)
tail(rankall("pneumonia", "worst"), 3)
tail(rankall("heart failure"), 10)

## quiz answers
##1. What result is returned by the following code?
best("SC", "heart attack")

##2. 
best("NY", "pneumonia")

##3.
best("AK", "pneumonia")

##4.
rankhospital("NC", "heart attack", "worst")
##5.
rankhospital("WA", "heart attack", 7)

##6.
rankhospital("TX", "pneumonia", 10)

##7.
rankhospital("NY", "heart attack", 7)

##8.
r <- rankall("heart attack", 4)
as.character(subset(r, state == "HI")$hospital)

##9.
r <- rankall("pneumonia", "worst")
as.character(subset(r, state == "NJ")$hospital)

##10.
r <- rankall("heart failure", 10)
as.character(subset(r, state == "NV")$hospital)