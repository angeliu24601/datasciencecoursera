#Set working directory
# setwd("./pa1")

#Part 2
complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data fame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases 
  
  cases <- data.frame(id = numeric(0), nobs = numeric(0)) # empty data frame as a container
  
  for (i in id) {# loop to get the data based on the id
    path <- paste0("./", directory, "/", sprintf("%03d", i), ".csv")
    df0 <- read.csv(path)
    df0.complete <- df0[!is.na(df0$sulfate) & !is.na(df0$nitrate),]
    cases0 <- data.frame(id = i, nobs = nrow(df0.complete))
    cases <- rbind(cases, cases0)
  }
  cases
}

#Test the results
# complete("specdata", 1)
# complete("specdata", c(2, 4, 8, 10, 12))
# complete("specdata", 30:25)
# complete("specdata", 3)
