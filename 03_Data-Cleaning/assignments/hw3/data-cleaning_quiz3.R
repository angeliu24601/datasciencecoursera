setwd("./hw3")
#1.The American Community Survey distributes downloadable data about United States communities.
# Download the 2006 microdata survey about housing for the state of Idaho using 
# download.file() from here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
# and load the data into R. The code book, describing the variable names is here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
# Create a logical vector that identifies the households on greater than 10 acres 
# who sold more than $10,000 worth of agriculture products. 
# Assign that logical vector to the variable agricultureLogical. 
# Apply the which() function like this to identify the rows of the data frame 
# where the logical vector is TRUE.
# which(agricultureLogical)
# What are the first 3 values that result?
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url, "./hid06.csv")
hid <- read.csv("hid06.csv")
agricultureLogical <- ifelse(hid$ACR ==3 & hid$AGS == 6, TRUE, FALSE)
ans1 <- head(which(agricultureLogical), 3)

#2. Using the jpeg package read in the following picture of your instructor into R
# https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg
# Use the parameter native=TRUE. What are the 30th and
# 80th quantiles of the resulting data? 
# (some Linux systems may produce an answer 638 different 
# for the 30th quantile)
library(jpeg)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(url,"./jeff.jpeg")
jeff <- readJPEG("./jeff.jpeg", native = TRUE)
ans2 <- quantile(jeff, c(0.3, 0.8))

#3. Load the Gross Domestic Product data for the 190 ranked countries in this data set:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
# Load the educational data from this data set:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
# Match the data based on the country shortcode. How many of the IDs match? 
# Sort the data frame in descending order by GDP rank (so United States is last). 
# What is the 13th country in the resulting data frame?
library(dplyr)
url1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
url2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(url1,"./gdp.csv")
download.file(url2,"./edstats.csv")
gdp <- read.csv("./gdp.csv", skip = 5, header = FALSE, nrows = 190)
edstats <- read.csv("./edstats.csv")
gdp <- select(gdp, V1:V5, -V3)
colnames(gdp) <- c("CountryCode", "Ranking", "Economy", "GDP" )
gdp$GDP <- as.numeric(gsub(",","",gdp$GDP))
gdp.ed <- inner_join(gdp, edstats, by = "CountryCode")
gdp.ed <- arrange(gdp.ed, desc(Ranking))
ans3 <- list(nrow(gdp.ed), gdp.ed[13,3])

#4. What is the average GDP ranking for the "High income: 
# OECD" and "High income: nonOECD" group?
avg.GDP <- tapply(gdp.ed$Ranking, gdp.ed$Income.Group, mean)
ans4 <- avg.GDP[c("High income: OECD","High income: nonOECD")]

#5. Cut the GDP ranking into 5 separate quantile groups. 
# Make a table versus Income.Group. How many countries are 
# Lower middle income but among the 38 nations with highest GDP?
gdp.ed$QGDP <- cut(gdp.ed$GDP, 
                   breaks = c(quantile(gdp.ed$GDP,seq(0, 1, by=0.2))),
                   labels=c("0-20","20-40","40-60","60-80","80-100"))
ans5 <- table(gdp.ed$QGDP, gdp.ed$Income.Group)["80-100","Lower middle income"]
