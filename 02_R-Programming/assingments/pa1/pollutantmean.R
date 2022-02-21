# #Set working directory
# setwd("./pa1")

#Part 1
pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating 
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate"
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used

  ## Return the mean of the pllutant across all monitors list
  ## in the 'id' vector (ignore NA values)
  ## NOTE: do not round the result
  
  df <- data.frame() # empty data frame as a container
  
  for (i in id) {# loop to get the data based on the id
    path <- paste0("./", directory, "/", sprintf("%03d", i), ".csv")
    df0 <- read.csv(path)
    df <- rbind(df, df0)    
  }
  
  mean(df[[pollutant]], na.rm = TRUE) # compute the mean ignoring n.a
}

#Testing results
# pollutantmean("specdata", "sulfate", 1:10)
# pollutantmean("specdata", "nitrate", 70:72)
# pollutantmean("specdata", "nitrate", 23)

