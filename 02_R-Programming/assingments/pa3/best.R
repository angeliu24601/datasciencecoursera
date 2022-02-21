best <- function(state, outcome) {
  ## Change the column names for convenience
  names(measure)[c(11,17,23)] <- c("heart attack","heart failure","pneumonia")
  ## Change the class of the variable "Hospital.Name" from factor to character
  measure$Hospital.Name <- as.character(measure$Hospital.Name)
  
  ## Check that state and outcome are valid
  if (state %in% unique(measure$State) == FALSE) {
    stop("invalid state")}
  if (outcome %in% c("heart attack","heart failure","pneumonia") == FALSE) {
    stop("invalid outcome")}
  
  ## Subset the data by specified state
  measure <- measure[measure$State==state,]
  ## Order by Hospital.Name
  measure <- measure[order(measure$Hospital.Name),]
  
  ## Get the column number of the variable specified by outcome
  colnum <- which(names(measure)==outcome)
  ## Get the row number of the where the min for the outcome is found
  row.min <- which.min(measure[,colnum])
  ## Return hospital name in that state with lowest 30-day death rate
  best.hospital <- measure[row.min,]$Hospital.Name
  print(best.hospital)
}