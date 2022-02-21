setwd("./hw4")
## 1. The American Community Survey distributes downloadable data about 
## United States communities. Download the 2006 microdata survey about housing 
## for the state of Idaho using download.file() from here:
## https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
## and load the data into R. The code book, describing the variable names is here:
## https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
## Apply strsplit() to split all the names of the data frame on the characters 
## "wgtp". What is the value of the 123 element of the resulting list?
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url, "./hid.csv")
data <- read.csv("./hid.csv")
ans1 <- strsplit(names(data), "wgtp")[123]

## 2. Load the Gross Domestic Product data for the 190 ranked countries 
## in this data set:
## https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
## Remove the commas from the GDP numbers in millions of dollars 
## and average them. What is the average?
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(url,"./gdp.csv")
data <- read.csv("./gdp.csv", skip = 5, header = FALSE, nrows = 190,
                 encoding = "UTF-8")
data$V5 <- as.numeric(gsub(",","",data$V5))
ans2 <- mean(data$V5)

## 3. In the data set from Question 2 what is a regular expression 
## that would allow you to count the number of countries whose name 
## begins with "United"? 
## Assume that the variable with the country names in it is named countryNames. 
## How many countries begin with United?
ans3 <- length(grep("^United",data$V4))

## 4. Load the Gross Domestic Product data for the 190 ranked 
## countries in this data set:
## https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
## Load the educational data from this data set:
## https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
## Match the data based on the country shortcode. 
## Of the countries for which the end of the fiscal year is available, 
## how many end in June?
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(url,"./edstats.csv")
edstats <- read.csv("./edstats.csv")
gdp <- data
gdp.ed <- merge(gdp, edstats, by.x = c("V1"), by.y = c("CountryCode"))
gdp.ed.fisc <- gdp.ed[grep("^Fiscal year end",gdp.ed$Special.Notes),]
ans4 <- length(grep("June",gdp.ed.fisc$Special.Notes))

## 5. You can use the quantmod (http://www.quantmod.com/) package 
## to get historical stock prices for publicly traded companies 
## on the NASDAQ and NYSE. Use the following code to download data 
## on Amazon's stock price and get the times the data was sampled.
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
## How many values were collected in 2012? How many values 
## were collected on Mondays in 2012?
sampleTimes2012 <- sampleTimes[grep("2012", sampleTimes)]
sampleTimes2012Day <- weekdays(sampleTimes2012)

ans5 <- c(length(grep("2012", sampleTimes)), length(grep("Monday", sampleTimes2012Day)))
