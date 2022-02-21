rankhospital <- function(state, outcome, num = "best") {
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
  measure.state <- measure[measure$State==state,]
  ## Get the column number of the variable specified by outcome
  colnum <- which(names(measure)==outcome)
  ## Order by outcome and then by Hospital.Name
  measure.outcome <- measure.state[order(measure.state[,colnum],measure.state$Hospital.Name),]
  
  ## Specify what happens when "num" is "best", "worst", 
  ## or > the number of hospitals in the given state
  if (num == "best") {num = 1}
  if (num == "worst") {num = which.max(measure.outcome[,colnum])}
  if (num > which.max(measure.outcome[,colnum])) {hospital <- "NA"}
  ## Return hospital name in that state with 30-day death rate 
  ## ranking specified by the "num"
  hospital <- measure.outcome[num,]$Hospital.Name
  print(hospital)
}