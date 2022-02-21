rankall <- function(outcome, num = "best") {
  ## Change the column names for convenience and format
  names(measure)[c(2,7,11,17,23)] <- c("hospital","state","heart attack",
                                       "heart failure","pneumonia")
  ## Change the class of the variable "hospital" from factor to character
  measure$hospital <- as.character(measure$hospital)
  
  ## Check that outcome is valid
  if (outcome %in% c("heart attack","heart failure","pneumonia") == FALSE) {
    stop("invalid outcome")}
  
  ## Get the column number of the variable specified by outcome
  colnum <- which(names(measure)==outcome)
  ## Order by state, outcome and then by hospital
  measure <- measure[order(measure$state,measure[,colnum],measure$hospital),]
  
  ## Create an empty data frame as a container
  hospitals <- data.frame("hospital"=character(), "state"=factor())
  
  ## Create a loop to get the data for each state
  for (i in levels(measure$state)) {
    ## Subset the data by each state
    onemeasure <- measure[measure$state == i,]
    ## Order by outcome, hospital
    onemeasure <- onemeasure[order(onemeasure[,colnum], onemeasure$hospital),]
    ## Specify what happens when "num" is "best", "worst", 
    if (num == "best") {rownb <- 1}
    if (num == "worst") {rownb <- which.max(onemeasure[,colnum])}
    if (num != "best" & num != "worst") {rownb <- num}
    ## Create the dataframe with ranking in one state
    ## specify what happens when num > the number of hospitals in the given state
    if (rownb > nrow(onemeasure)) {
      hospital <- data.frame("hospital"="NA","state"=i)} else{
        hospital <- onemeasure[rownb,c(2,7)]
      }
    hospitals <- rbind (hospitals,hospital)
  }
  row.names(hospitals) <- hospitals$state
  hospitals
}