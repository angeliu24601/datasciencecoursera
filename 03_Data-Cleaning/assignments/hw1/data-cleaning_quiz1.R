setwd("./hw1")
#1. The American Community Survey distributes downloadable data about United States communities.
# Download the 2006 microdata survey about housing for the state of Idaho using download.file() 
# from here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
# and load the data into R. The code book, describing the variable names is here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
# How many properties are worth $1,000,000 or more?
library(data.table)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url,"./hid.csv")
hid <- read.csv("./hid.csv")
hid <- data.table(hid)
ans1 <- hid[VAL==24,.N]
# Use the data you loaded from Question 1. Consider the variable FES in the code
# book. Which of the "tidy data" principles does this variable violate?

#3. Download the Excel spreadsheet on Natural Gas Aquisition Program here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx
# Read rows 18-23 and columns 7-15 into R and assign the result
# to a variable called: dat
# What is the value of:sum(dat$Zip*dat$Ext,na.rm=T)
library(xlsx)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(url, "./ngap.xlsx")
dat <- read.xlsx("./ngap.xlsx", sheetIndex = 1, 
                  rowIndex = c(18:23), colIndex = c(7:15))
ans3 <- sum(dat$Zip*dat$Ext,na.rm=T)

#4. Read the XML data on Baltimore restaurants from here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml
# How many restaurants have zipcode 21231?
library(XML)
url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
dataxml <- xmlTreeParse(url, isURL = TRUE, useInternalNodes = TRUE)
zip <- xpathSApply(dataxml, "/response/row/row/zipcode", xmlValue)
ans4 <- sum(zip == 21231)

#5. The American Community Survey distributes downloadable data about 
# United States communities. Download the 2006 microdata survey about 
# housing for the state of Idaho using download.file() from here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv
# using the fread() command load the data into an R object: DT
# The following are ways to calculate the average value of the variable:pwgtp15
# broken down by sex. Using the data.table package, which will deliver 
# the fastest user time?
library(data.table)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(url, "./microdata.csv")
DT <- fread("./microdata.csv")

system.time(sapply(split(DT$pwgtp15,DT$SEX),mean)) #0.01
system.time(mean(DT[DT$SEX==1,]$pwgtp15)) + 
  system.time(mean(DT[DT$SEX==2,]$pwgtp15)) #no
system.time(tapply(DT$pwgtp15,DT$SEX,mean)) #0.02
system.time(DT[,mean(pwgtp15),by=SEX]) #0.01 yes
system.time(rowMeans(DT)[DT$SEX==1]) + system.time(rowMeans(DT)[DT$SEX==2]) #no
system.time(mean(DT$pwgtp15,by=DT$SEX)) # no
