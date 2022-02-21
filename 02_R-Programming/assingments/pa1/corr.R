#Set working directory
# setwd("./pa1")

#Part 3
corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  ## NOTE: Do not round the result!
  
  correlation <- numeric() #create an empty numeric vector as container for correlations
  
  for (i in 1:length(list.files(directory))) {# loop to get all the data
    path <- paste0("./", directory, "/", sprintf("%03d", i), ".csv")
    df0 <- read.csv(path)
    nobs.complete <- nrow(df0[!is.na(df0$sulfate) & !is.na(df0$nitrate),])
    
    if (nobs.complete > threshold) {# calculate correlation based on if the number of
      #complete cases is greater than the threshold
      correlation <- append(correlation,cor(df0$nitrate, df0$sulfate, use = "complete.obs"))
    } else {correlation}
  }
  
  correlation
}

#Test results
# cr <- corr("specdata", 150); head(cr)
# summary(cr)
# 
# cr <- corr("specdata", 400); head(cr)
# 
# cr <- corr("specdata", 5000); summary(cr)
# length(cr)
# 
# cr <- corr("specdata"); summary(cr)
# length(cr)

