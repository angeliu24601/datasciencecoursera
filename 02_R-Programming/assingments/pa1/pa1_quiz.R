# set the working directory
setwd("./pa1")

# source the scripts with the functions
source("pollutantmean.R")
source("complete.R")
source("corr.R")

# 1. What value is returned by the following call to pollutantmean()? You should round your output
# to 3 digits.
ans1 <- round(pollutantmean("specdata", "sulfate", 1:10), 3)

# What value is returned by the following call to pollutantmean()? You should round your output to
# 3 digits.
ans2 <- round(pollutantmean("specdata", "nitrate", 70:72), 3)

# What value is returned by the following call to pollutantmean()? You should round your output to
# 3 digits.
ans3 <- round(pollutantmean("specdata", "sulfate", 34), 3)

# What value is returned by the following call to pollutantmean()? You should round your output to
# 3 digits
ans4 <- round(pollutantmean("specdata", "nitrate"), 3)

# What value is printed at end of the following code?
cc <- complete("specdata", c(6, 10, 20, 34, 100, 200, 310))
ans5 <- print(cc$nobs)

# What value is printed at end of the following code?
cc <- complete("specdata", 54)
ans6 <- print(cc$nobs)

# What value is printed at end of the following code?
set.seed(42)
cc <- complete("specdata", 332:1)
use <- sample(332, 10)
ans7 <- print(cc[use, "nobs"])

# What value is printed at end of the following code?
cr <- corr("specdata")                
cr <- sort(cr)                
set.seed(868)                
out <- round(cr[sample(length(cr), 5)], 4)
ans8 <- print(out)

# What value is printed at end of the following code?
cr <- corr("specdata", 129)                
cr <- sort(cr)                
n <- length(cr)                
set.seed(197)                
out <- c(n, round(cr[sample(n, 5)], 4))
ans9 <- print(out)

# What value is printed at end of the following code?
cr <- corr("specdata", 2000)                
n <- length(cr)                
cr <- corr("specdata", 1000)                
cr <- sort(cr)
ans10 <- print(c(n, round(cr, 4)))
