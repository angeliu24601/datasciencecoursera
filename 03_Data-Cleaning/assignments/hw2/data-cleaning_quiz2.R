setwd("./hw2")
# 1. Register an application with the Github API here 
# https://github.com/settings/applications. 
# Access the API to get information on your instructors repositories
#  (hint: this is the url you want 
#  "https://api.github.com/users/jtleek/repos").
#  What time was it created?
library(httr); library(jsonlite)
myapp <- oauth_app("github", 
                   key = "1c05c9b9b49449841f3b",
                   secret = "50795773b4924d7cc45f1664407b57001d207dfa")
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

req <- GET("https://api.github.com/users/jtleek/repos", 
           config(token = github_token))
stop_for_status(req)

json1 <- content(req)
json2 <- jsonlite::fromJSON(toJSON(json1))
json2$documentation_url

#2. The sqldf package allows for execution of SQL commands on R data
# frames. We will use the sqldf package to practice the queries we
# might send with the dbSendQuery command in RMySQL.
# Download the American Community Survey data and load it into an R 
# object called "acs"
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv
# Which of the following commands will select only the data for the
# probability weights pwgtp1 with ages less than 50?
sqldf("select * from acs")
sqldf("select pwgtp1 from acs where AGEP < 50")
sqldf("select pwgtp1 from acs")
sqldf("select * from acs where AGEP < 50")

#3. Using the same data frame you created in the previous problem,
# what is the equivalent function to unique(acs$AGEP)
sqldf("select unique * from acs")
sqldf("select distinct pwgtp1 from acs")
sqldf("select AGEP where unique from acs")
sqldf("select distinct AGEP from acs")

#4. How many characters are in the 10th, 20th, 30th and 100th 
# lines of HTML from this page:
# http://biostat.jhsph.edu/~jleek/contact.html
library(XML)
con <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode <- readLines(con)
close(con)
ans4 <- nchar(htmlCode[c(10, 20, 30, 100)])

#5.Read this data set into R and report the sum of the numbers in the fourth of the nine
# columns.
# https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for
# Original source of the data: 
# http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for
# (Hint this is a fixed width file format)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for", "./wsst.for")
fwf <- read.fwf("./wsst.for", widths=c(10, 9, 4, 9, 4, 9, 4, 9, 4),skip = 4)
ans5 <- sum(fwf[,4])
